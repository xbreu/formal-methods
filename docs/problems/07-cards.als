/// Abstract model for an bank card emission system.

// ----------------------------------------------------------------------------
// Definitions
// ----------------------------------------------------------------------------

abstract sig Status {}

one sig Unissued, Issued, Cancelled extends Status {}

sig Card {
  var status : one Status
}

sig Client {
  var cards : set Card
}

// ----------------------------------------------------------------------------
// Properties
// ----------------------------------------------------------------------------

// Clients can never have unissued cards.
assert NoUnissuedCards {

}

// Throughout its existence a card cannot belong to more than one client.
assert NoSharedCards {

}

check NoUnissuedCards
check NoSharedCards

// ----------------------------------------------------------------------------
// Initial State
// ----------------------------------------------------------------------------

fact Init {

}

// ----------------------------------------------------------------------------
// Operations
// ----------------------------------------------------------------------------

// Emit a card to a client.
pred emit [c : Card, a : Client] {

}

// Cancel a card.
pred cancel [c : Card] {

}

pred nop {
  status' = status
  cards' = cards
}

fact Traces {
  always (
    nop
    or some c : Card | cancel[c]
    or some a : Client | emit[c, a]
  )
}

// ----------------------------------------------------------------------------
// Scenarios
// ----------------------------------------------------------------------------

// Scenario where 3 cards are emited to at least 2 clients and all are
// eventually canceled, using scopes to control the cardinality of the
// signatures.
run Example {

}
