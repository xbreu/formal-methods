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
  Worker in (Human + Robot)
}

// Every workstation has workers and every worker works in one workstation.
pred inv2 {
  all w : Workstation | some w . workers
  all w : Worker | one workers . w
}

// Every component is assembled in one workstation.
pred inv3 {
  all c : Component | one c . workstation
}

// Components must have parts and materials have no parts.
pred inv4 {
  parts . Product = Component
}

// Humans and robots cannot work together.
pred inv5 {
  all w : Workstation | (w . workers in Human) or (w . workers in Robot)
}

// Components cannot be their own parts.
pred inv6 {
  no c : Component | c in (c . ^parts)
}

// Components built of dangerous parts are also dangerous.
pred inv7 {
  ^parts.Dangerous in Dangerous
}

// Dangerous components cannot be assembled by humans.
pred inv8 {
  all c : Component | (c in Dangerous) => (c . workstation . workers) in Robot
}

// The workstations form a single line between begin and end.
pred inv9 {
  succ in Workstation lone -> lone Workstation
  Workstation in (begin . *succ)
  no (end . succ)
}

// The parts of a component must be assembled before it in the production line.
pred inv10 {
  all c, p : Component | (p in c . parts) =>
  (c . workstation) in (p . workstation . ^succ)
}
