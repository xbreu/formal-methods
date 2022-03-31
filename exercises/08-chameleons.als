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
  always (
    one (Chameleon . colour) => always colour' = colour
  )
}

// Se inicialmente há um camaleao verde e nenhum azul então não é possível que
// a colónia fique toda amarela.
assert NaoConvergencia {
  one (colour . Green) and no (colour . Blue) =>
  always Chameleon . colour != Yellow
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
  // Guards
  x.colour != y.colour

  // Effects
  x.colour' = Colour - x.colour - y.colour
  y.colour' = x.colour'

  // Frame conditions
  all c : Chameleon - x - y | c.colour' = c.colour
}

fact Comportamento {
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

// Especifique um cenário onde existe um camaleao que não para de mudar de cor
// tomando recorrentemente todas as cores possíveis
run Example {
  some c : Chameleon | all x : Colour | always eventually c.colour in x
}
