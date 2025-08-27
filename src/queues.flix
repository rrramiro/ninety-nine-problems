import java.lang.StringBuilder

pub enum Queue[a](List[a], List[a])

instance ToString[Queue[a]] with ToString[a] {
    pub def toString(xs: Queue[a]): String = Queues.toString(xs)
}

mod Queues {
    pub def toString(l: Queue[a]): String with ToString[a] = region r {
        let sb = StringBuilder.empty(r);
        Queues.forEach(x -> StringBuilder.append("${x}, ", sb), l);
        let s = StringBuilder.toString(sb);
        "Queue#{${String.dropRight(2, s)}}"
    }
/*
    pub def zipWithIndex(q: Queue[a]): Queue[(a, Int32)] =
        let Queue(inb, outb) = q;
        Queue(inb |> List.reverse |> List.zipWithIndex |> List.reverse, outb |> List.zipWithIndex)
*/
    pub def forEach(f: a -> Unit \ ef, q: Queue[a]): Unit \ ef =
        let Queue.Queue(inb, outb) = q;
        (outb ::: List.reverse(inb)) |> List.forEach(f)

    pub def empty(): Queue[a] = Queue.Queue(Nil, Nil)

    pub def isEmpty(q: Queue[a]): Bool =
        let Queue.Queue(inb, outb) = q;
        List.isEmpty(inb) and List.isEmpty(outb)

    pub def length(q: Queue[a]): Int32 =
        let Queue.Queue(inb, outb) = q;
        List.length(inb) + List.length(outb)

    pub def front(q: Queue[a]): Option[a] = match q {
        case Queue.Queue(_ , h :: _) => Some(h)
        case Queue.Queue(in, Nil)    => List.last(in)
    }

    pub def enqueue(elem: a, q: Queue[a]): Queue[a] =
        let Queue.Queue(inb, outb) = q;
        Queue.Queue(elem :: inb, outb)

    pub def enqueueAll(l: List[a], q: Queue[a]): Queue[a] =
        List.foldLeft((acc, e) -> enqueue(e, acc), q, l)

    pub def dequeue(q: Queue[a]): (Option[a], Queue[a]) = match q {
        case Queue.Queue(Nil, Nil)             => (None, q)
        case Queue.Queue(inb, Nil)             => dequeue(Queue.Queue(Nil, List.reverse(inb)))
        case Queue.Queue(inb, (head :: tail))  => (Some(head), Queue.Queue(inb, tail))
    }

}
