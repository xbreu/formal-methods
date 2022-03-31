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
  always (
    no cards.status.Unissued
  )
}

// Throughout its existence a card cannot belong to more than one client.
assert NoSharedCards {
  always (
    all a : Client, c : a.cards | always (
      cards.c in a
    )
  )
}

check NoUnissuedCards
check NoSharedCards

// ----------------------------------------------------------------------------
// Initial State
// ----------------------------------------------------------------------------

fact Init {
  // There is no card owned by a client
  no cards

  // All cards have not been issued
  (Card.status = Unissued)
}

// ----------------------------------------------------------------------------
// Operations
// ----------------------------------------------------------------------------

// Emit a card to a client.
pred emit [c : Card, a : Client] {
  // Guards
  historically (
    c.status in Unissued
  )

  // Effects
  cards' = cards + a->c
  c.status' = Issued

  // Frame conditions
  all d : Card - c | d.status' = d.status
}

// Cancel a card.
pred cancel [c : Card] {
  // Guards
  c.status in Issued
  some cards.c

  // Effects
  c.status' = Cancelled

  // Frame conditions
  cards' = cards
  all d : Card - c | d.status' = d.status
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
  eventually (
    Card.status = Cancelled
  )
} for exactly 3 Card, exactly 2 Client
