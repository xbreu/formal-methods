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
    #(Fork) > 1
  }
}

// ----------------------------------------------------------------------------
// Properties
// ----------------------------------------------------------------------------

// The same fork can never be in the hand of two different philosophers.
assert ForksInHand {
  fairness => always (
    forks in Philosopher lone -> Fork
  )
}

// Any philosophers that takes one fork will be able to eat.
assert EverytimeOneTakesOneEats {
  fairness => always (
    all p : Philosopher | p in forks . Fork =>
    eventually eat[p]
  )
}

// The system cannot enter in a deadlock state, where the philosophers can
// only think.
assert NoDeadlock {
  always (
    some p : Philosopher |
    (#(p . forks) = 2)
    or (p . next not in Philosopher . forks)
    or (p . ~next not in Philosopher . forks)
  )
}

check ForksInHand for 6
check EverytimeOneTakesOneEats for 6
check NoDeadlock for 6

// ----------------------------------------------------------------------------
// Events
// ----------------------------------------------------------------------------

pred fairness {
  all p : Philosopher {
    always eventually (#(p . forks) = 2)
    => always eventually eat[p]

    always eventually (
      (p . next not in Philosopher . forks)
      or (p . ~next not in Philosopher . forks)
    ) => always eventually take[p]
  }
}

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
  {
    // Guards
    (p . next not in Philosopher . forks)

    // Effects
    forks' = forks + p -> (p . next)
  } or {
    // Guards
    (p . ~next not in Philosopher . forks)

    // Effects
    forks' = forks + p -> (p . ~next)
  }
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
run Example {
  all p : Philosopher | eventually eat[p]
} for exactly 4 Philosopher, 4 Fork, 1..15 steps
