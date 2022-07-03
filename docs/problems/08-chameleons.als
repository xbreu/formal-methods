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

}

// ----------------------------------------------------------------------------
// Properties
// ----------------------------------------------------------------------------

// If the chameleons all have the same color, they will never change again.
assert Stability {

}

// If initially there is one green chameleon and no blue one, then, it is not
// possible for the community to be all yellow.
assert NoConvergence {

}

check Stability for 5
check NoConvergence for 5

// ----------------------------------------------------------------------------
// Operations
// ----------------------------------------------------------------------------

pred nop {

}

pred encounter[x, y : Chameleon] {

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

// A scenario where there is a chameleon that does not stop changing color,
// repeatedly taking on all of the possible colors.
run Example {

}
