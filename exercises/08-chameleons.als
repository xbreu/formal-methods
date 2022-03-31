/// Modelo de uma colónia de camaleões onde o número de camaleões é fixo mas
/// onde a cor de cada camaleão pode mudar de acordo com as seguintes regras:
/// - As cores possíveis são Verde, Azul e Amarelo;
/// - Se 2 camaleões de cores diferentes se encontram mudam ambos para a
///   terceira cor;
/// - As cores só se alteram na situação acima.

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

// Se os camaleoes ficarem todos da mesma cor, as cores nunca mais mudam.
assert Estabilidade {

}

// Se inicialmente há um camaleao verde e nenhum azul então não é possível que
// a colónia fique toda amarela.
assert NaoConvergencia {

}

check Estabilidade for 5
check NaoConvergencia for 5

// ----------------------------------------------------------------------------
// Operations
// ----------------------------------------------------------------------------

pred nop {
  colour' = colour
}

pred encounter[x, y : Chameleon] {
  // Effects
  not (x.colour = y.colour) => (
    (x.colour' = Colour - x.colour - y.colour)
    and (y.colour' = Colour - x.colour - y.colour)
  ) else (
    (x.colour' = x.colour)
    and (y.colour' = y.colour)
  )

  // Frame conditions
  all c : Chameleon - x - y | c.colour' = c.colour
}

fact Comportamento {
  always (
    nop
    or some disj x, y : Chameleon | encounter[x, y]
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

// Especifique um cenário onde existe um camaleao que não para de mudar de cor
// tomando recorrentemente todas as cores possíveis
run Example {
  some c : Chameleon | always (
    (eventually c.colour in Green)
    and (eventually c.colour in Yellow)
    and (eventually c.colour in Blue)
  )
}
