// Implementation of Java's Random.nextInt(bound) in Flix
mod Randoms {

    // Generates a random integer in the range [0, bound) using the same algorithm as Java's Random.nextInt(bound)
    pub def nextInt(bound: Int32): Int32 \ Random =
        if (bound <= 0) 
            bug!("IllegalArgument: bound must be positive")
        else {
            // Get a 31-bit random number (equivalent to next(31) in Java)
            let r = Random.randomInt32() `Int32.bitwiseAnd` 0x7FFFFFFF;
            let m = bound - 1;
            
            // Check if bound is a power of 2
            if (Int32.bitwiseAnd(bound, m) == 0) {
                // For powers of 2, use bit manipulation for efficiency
                // Use unsafe cast to handle the multiplication
                let product = bound * r;
                product `Int32.rightShift` 31
            } else {
                // Rejection sampling to avoid bias for non-power-of-2 bounds
                nextIntReject(bound, m, r)
            }
        }

    // Helper function for rejection sampling to ensure uniform distribution
    def nextIntReject(bound: Int32, m: Int32, u: Int32): Int32 \ Random =
        let r = u `Int32.remainder` bound;
        if (u - r + m < 0) {
            // Reject and try again with a new random number
            let nextU = Random.randomInt32() `Int32.bitwiseAnd` 0x7FFFFFFF;
            nextIntReject(bound, m, nextU)
        } else {
            r
        }


        
}