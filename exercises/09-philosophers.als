/// Model for a philosopher group dinner

// ----------------------------------------------------------------------------
// Definitions
// ----------------------------------------------------------------------------

// The "things" that are around the table.
abstract sig Thing {
  next : one Thing
}

// Forks that each philosopher has in hand.
sig Philosopher extends Thing {
  var forks : set Fork
}

sig Fork extends Thing {}

// The table is round, which means that the things form a ring.
// And the forks and the philosophers are interspersed.
fact Table {
  always {
    (all t : Thing | Thing in t.^next)
    Philosopher . next in Fork
    Fork . next in Philosopher
  }
}

// ----------------------------------------------------------------------------
// Properties
// ----------------------------------------------------------------------------

// The same fork can never be in the hand of two different philosophers.
assert ForksInHand {
  always (
    forks in Philosopher one -> Fork
  )
}

// Any philosophers that takes one fork will be able to eat.
assert EverytimeOneTakesOneEats {
  always (
    all p : Philosopher | p in forks . Fork =>
    eventually p not in forks . Fork
  )
}

// The system cannot enter in a deadlock state, where the philosophers can
// only think.
assert NoDeadlock {

}

check ForksInHand for 6
check EverytimeOneTakesOneEats for 6
check NoDeadlock for 6

// ----------------------------------------------------------------------------
// Events
// ----------------------------------------------------------------------------

// A philosopher can eat if they already have two forks in hand, and they
// release the forks after eating.
pred eat[p : Philosopher] {
  // Guards
  #(p . forks) = 2

  // Effects
  forks' = forks - (p <: forks)
}

// A philosopher can take one of the forks that are close to they.
pred take[p : Philosopher] {
  // Guards

  // Effects

  // Frame conditions
}

// Beyond eating and taking forks, the philosophers can think.
pred think[p : Philosopher] {
  forks' = forks
}

// In the initial state, the forks are all released, after that, the
// philosophers can eat, take a fork or think.
fact Behaviour {
  no forks
  always (some p : Philosopher | eat[p] or take[p] or think[p])
}

// ----------------------------------------------------------------------------
// Scenarios
// ----------------------------------------------------------------------------

// Scenario where all the 4 philosophers get to eat.
run Exemple {

}
