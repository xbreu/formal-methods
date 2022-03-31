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
  some Entry
  some Exit
}

// Signals belong to one track.
pred inv2 {
  signals in Track one -> Signal
}

// Exit tracks are those without successor.
pred inv3 {
  Exit = Track - (succs . Track)
}

// Entry tracks are those without predecessors.
pred inv4 {
  Entry = Track - (Track . succs)
}

// Junctions are the tracks with more than one predecessor.
pred inv5 {
  all t : Track | (t in Junction) <=> (#(t . ~succs) > 1)
}

// Entry tracks must have a speed signal.
pred inv6 {
  all e : Entry | some (e . signals) & Speed
}

// The station has no cycles.
pred inv7 {
  all t : Track | t not in (t . ^succs)
}

// It should be possible to reach every exit from every entry.
pred inv8 {
  (Entry->Exit) in (*succs)
}

// Tracks not followed by junctions do not have semaphores.
pred inv9 {
  all t : Track | no ((t . succs) & Junction) =>
  no ((t . signals) & Semaphore)
}

// Every track before a junction has a semaphore.
pred inv10 {
  all t : Track | some ((t . succs) & Junction) =>
  some ((t . signals) & Semaphore)
}
