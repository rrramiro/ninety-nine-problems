opaque type Queue[a] = (List[a], List[a])

instance ToString[Queue[a]] with ToString[a] {
    pub def toString(xs: Queue[a]): String = Queues.toString(xs)
}

namespace Queues {
    pub def toString(xs: Queue[a]): String with ToString[a] = toStringHelper(xs) as & Pure

    def toStringHelper(xs: Queue[a]): String & Impure with ToString[a] =
        let sb = StringBuilder.new();
        Queues.foreach(x -> StringBuilder.appendString!("${x}, ", sb), xs);
        let s = StringBuilder.toString(sb);
        "Queue#{${String.dropRight(2, s)}}"

    pub def foreach(f: a -> Unit & Impure, q: Queue[a]): Unit & Impure =
        let Queue(inb, outb) = q;
        (outb ::: List.reverse(inb)) |> List.foreach(f)

    pub def empty(): Queue[a] = Queue(Nil, Nil)

    pub def isEmpty(q: Queue[a]): Bool =
        let Queue(inb, outb) = q;
        List.isEmpty(inb) and List.isEmpty(outb)

    pub def length(q: Queue[a]): Int32 =
        let Queue(inb, outb) = q;
        List.length(inb) + List.length(outb)

    pub def front(q: Queue[a]): Option[a] = match q {
        case Queue(_ , h :: _) => Some(h)
        case Queue(in, Nil)    => List.last(in)
    }

    pub def enqueue(elem: a, q: Queue[a]): Queue[a] =
        let Queue(inb, outb) = q;
        Queue(elem :: inb, outb)

    pub def enqueueAll(l: List[a], q: Queue[a]): Queue[a] =
        List.foldLeft((acc, e) -> enqueue(e, acc), q, l)

    pub def dequeue(q: Queue[a]): (Option[a], Queue[a]) = match q {
        case Queue(Nil, Nil)             => (None, q)
        case Queue(inb, Nil)             => dequeue(Queue(Nil, List.reverse(inb)))
        case Queue(inb, (head :: tail))  => (Some(head), Queue(inb, tail))
    }

}
