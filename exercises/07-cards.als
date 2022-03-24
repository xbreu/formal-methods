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

// Os clientes nunca podem deter cartões unissued.
assert NoUnissuedCards {
  always (
    no cards.status.Unissued
  )
}

// Ao longo da sua existência um cartão nunca pode pertencer a mais do que um
// cliente.
assert NoSharedCards {
  always (
    all a : Client, c : a.cards | always (
      cards.c in a
    )
  )
}

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

check NoUnissuedCards
check NoSharedCards

// Operação de emitir um cartão para um cliente.
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

// Operação de cancelar um cartão.
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

// Especifique um cenário onde 3 cartões são emitidos a pelo menos 2 clientes e
// são todos inevitavelmente cancelados, usando os scopes para controlar a
// cardinalidade das assinaturas.
// Tente também definir um theme onde os cartões emitidos são verdes e os
// cancelados são vermelhos, ocultando depois toda a informação que seja
// redundante.
// Pode introduzir definições auxiliares no modelo se necessário.
run Example {
  eventually (
    Card.status = Cancelled
  )
} for exactly 3 Card, exactly 2 Client
