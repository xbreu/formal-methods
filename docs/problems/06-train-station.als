/// The unsolved exercises and interface for running the file online can be
/// found at http://alloy4fun.inesctec.pt/KC4Km53MR47kLGYCN

// ----------------------------------------------------------------------------
// Definitions
// ----------------------------------------------------------------------------

sig Track {
  succs : set Track,
  signals : set Signal
}

sig Junction, Entry, Exit in Track {}

sig Signal {}

sig Semaphore, Speed extends Signal {}

// ----------------------------------------------------------------------------
// Properties
// ----------------------------------------------------------------------------

// The station has at least one entry and one exit.
pred inv1 {

}

// Signals belong to one track.
pred inv2 {

}

// Exit tracks are those without successor.
pred inv3 {

}

// Entry tracks are those without predecessors.
pred inv4 {

}

// Junctions are the tracks with more than one predecessor.
pred inv5 {

}

// Entry tracks must have a speed signal.
pred inv6 {

}

// The station has no cycles.
pred inv7 {

}

// It should be possible to reach every exit from every entry.
pred inv8 {

}

// Tracks not followed by junctions do not have semaphores.
pred inv9 {

}

// Every track before a junction has a semaphore.
pred inv10 {

}
