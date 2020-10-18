// Count the leaves of a binary tree
// A leaf is a node with no successors.
namespace P61 {

    pub enum Tree {
        case Leaf,
        case Node(Tree, Tree)
    }

    def leafs(t: Tree): Int = match t {
        case Leaf       => 1
        case Node(l, r) => leafs(l) + leafs(r)
    }

    @test
    def testLeafs01(): Bool = 
        leafs(Leaf) == 1

    @test
    def testLeafs02(): Bool = 
        leafs(Node(Leaf, Leaf)) == 2

    @test
    def testLeafs03(): Bool = 
        leafs(Node(Leaf, Node(Leaf, Leaf))) == 3

}

