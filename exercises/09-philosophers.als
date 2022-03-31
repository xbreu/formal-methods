/// Modelo do jantar dos filósofos

// ----------------------------------------------------------------------------
// Definitions
// ----------------------------------------------------------------------------

// As "coisas" à volta da mesa
abstract sig Coisa {
  prox : one Coisa
}

// Garfos que cada filósofo tem na mão
sig Filosofo extends Coisa {
  var garfos : set Garfo
}

sig Garfo extends Coisa {}

// A mesa é redonda, ou seja, as coisas formam um anel
// Os garfos e os filósofos estão intercalados
fact Mesa {
  always {
    (all c : Coisa | Coisa in c.^prox)
    Filosofo . prox in Garfo
    Garfo . prox in Filosofo
  }
}

// ----------------------------------------------------------------------------
// Properties
// ----------------------------------------------------------------------------

// O mesmo garfo nunca pode estar na mão de dois filósofos
assert GarfosNaMao {
  always (
    garfos in Filosofo one -> Garfo
  )
}

// Qualquer filósofo que pega num garfo vai conseguir comer
assert SempreQuePegaCome {
  always (
    all f : Filosofo | f in garfos . Garfo =>
    eventually f not in garfos . Garfo
  )
}

// O sistema não pode bloquear numa situação em que só é possível pensar
assert SemBloqueio {

}

check GarfosNaMao for 6
check SempreQuePegaCome for 6
check SemBloqueio for 6

// ----------------------------------------------------------------------------
// Events
// ----------------------------------------------------------------------------

// Um filosofo pode comer se já tiver os dois garfos junto a si e pousa os
// garfos depois
pred come [f : Filosofo] {
  // Guards
  #(f . garfos) = 2

  // Effects
  garfos' = garfos - (f <: garfos)
}

// Um filósofo pode pegar num dos garfos que estejam pousados junto a si
pred pega [f : Filosofo] {
  // Guards

  // Effects

  // Frame conditions
}

// Para além de comer ou pegar em garfos os filósofos podem pensar
pred pensa [f : Filosofo] {
  garfos' = garfos
}

// No inicio os garfos estão todos pousados
// Depois os filósfos só podem comer, pegar ou pensar
fact Comportamento {
  no garfos
  always (some f : Filosofo | come[f] or pega[f] or pensa[f])
}

// ----------------------------------------------------------------------------
// Scenarios
// ----------------------------------------------------------------------------

// Especifique um cenário com 4 filósofos onde todos conseguem comer
run Exemplo {

}
