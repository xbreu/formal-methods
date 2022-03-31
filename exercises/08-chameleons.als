/// Model of a community of chameleons, where there's a fixed number of
/// chameleons, but their colours can change according to the following rules:
/// - The possible colours are: green, blue and yellow;
/// - If two chameleons with different colours meet, both change to the other
///   colour;
/// - The colours can only change in the event above.

// ----------------------------------------------------------------------------
// Definitions
// ----------------------------------------------------------------------------

sig Chameleon {
  var colour : one Colour
}

abstract sig Colour {}

one sig Green, Blue, Yellow extends Colour {}

// ----------------------------------------------------------------------------
// Properties
// ----------------------------------------------------------------------------

// If the chameleons all have the same color, they will never change again.
assert Stability {
  always (
    one (Chameleon . colour) => always colour' = colour
  )
}

// If initially there is one green chameleon and no blue one, then, it is not
// possible for the community to be all yellow.
assert NoConvergence {
  one (colour . Green) and no (colour . Blue) =>
  always Chameleon . colour != Yellow
}

check Stability for 5
check NoConvergence for 5

// ----------------------------------------------------------------------------
// Operations
// ----------------------------------------------------------------------------

pred nop {
  colour' = colour
}

pred encounter[x, y : Chameleon] {
  // Guards
  x.colour != y.colour

  // Effects
  x.colour' = Colour - x.colour - y.colour
  y.colour' = x.colour'

  // Frame conditions
  all c : Chameleon - x - y | c.colour' = c.colour
}

fact Behaviour {
  always (
    nop
    or some x, y : Chameleon | encounter[x, y]
  )
}

// ----------------------------------------------------------------------------
// Scenarios
// ----------------------------------------------------------------------------

fun GreenChameleon : set Chameleon {
  colour . Green
}

fun BlueChameleon : set Chameleon {
  colour . Blue
}

fun YellowChameleon : set Chameleon {
  colour . Yellow
}

// A scenario where there is a chameleon that does not stop changing color,
// repeatedly taking on all of the possible colors.
run Example {
  some c : Chameleon | all x : Colour | always eventually c.colour in x
}
