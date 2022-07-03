/// The unsolved exercises and interface for running the file online can be
/// found at http://alloy4fun.inesctec.pt/fRhYhhBqaGGezzmsY

// ----------------------------------------------------------------------------
// Definitions
// ----------------------------------------------------------------------------

sig Workstation {
  workers : set Worker,
  succ : set Workstation
}

one sig begin, end in Workstation {}

sig Worker {}

sig Human, Robot extends Worker {}

abstract sig Product {
  parts : set Product
}

sig Material extends Product {}

sig Component extends Product {
  workstation : set Workstation
}

sig Dangerous in Product {}

// ----------------------------------------------------------------------------
// Properties
// ----------------------------------------------------------------------------

// Workers are either human or robots.
pred inv1 {

}

// Every workstation has workers and every worker works in one workstation.
pred inv2 {

}

// Every component is assembled in one workstation.
pred inv3 {

}

// Components must have parts and materials have no parts.
pred inv4 {

}

// Humans and robots cannot work together.
pred inv5 {

}

// Components cannot be their own parts.
pred inv6 {

}

// Components built of dangerous parts are also dangerous.
pred inv7 {

}

// Dangerous components cannot be assembled by humans.
pred inv8 {

}

// The workstations form a single line between begin and end.
pred inv9 {

}

// The parts of a component must be assembled before it in the production line.
pred inv10 {

}
