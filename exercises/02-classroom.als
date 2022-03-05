/// First-order logic revision exercises based on a simple model of a classroom
/// management system.
///
/// The model has 5 unary predicates (sets), Person, Student, Teacher, Group
/// and Class, Student and Teacher a sub-set of Person. There are two binary
/// predicates, Tutors a sub-set of Person x Person, and Teaches a sub-set of
/// Person x Teaches. There is also a ternary predicate Groups, sub-set of
/// Class x Person x Group.
///
/// The unsolved exercises and interface for running the file online can be
/// found at http://alloy4fun.inesctec.pt/Pdvipvrpr5hg7JKbs

// The registered persons.
sig Person  {
  // Each person tutors a set of persons.
  Tutors : set Person,
  // Each person teaches a set of classes.
  Teaches : set Class
}

// The registered groups.
sig Group {}

// The registered classes.
sig Class  {
  // Each class has a set of persons assigned to a group.
  Groups : Person -> Group
}

// Some persons are teachers.
sig Teacher in Person  {}

// Some persons are students.
sig Student in Person  {}

// Every person is a student.
pred inv1 {
  all p : Person | p in Student
}

// There are no teachers.
pred inv2 {
  not some p : Person | p in Teacher
}

// No person is both a student and a teacher.
pred inv3 {
  not some p : Person | (p in Teacher) and (p in Student)
}

// No person is neither a student nor a teacher.
pred inv4 {
  all p : Person | (p in Teacher) or (p in Student)
}

// There classes assigned to teachers.
pred inv5 {
  some c : Class, t : Teacher | t->c in Teaches
}

// Every teacher has classes assigned.
pred inv6 {
  all t : Teacher | some c : Class | t->c in Teaches
}

// Every class has teachers assigned.
pred inv7 {
  all c : Class | some t : Teacher | t->c in Teaches
}

// Teachers are assigned at most one class.
pred inv8 {
  all t : Teacher, c1, c2 : Class |
  (t->c1 in Teaches) and (t->c2 in Teaches) => (c1 = c2)
}

// No class has more than a teacher assigned.
pred inv9 {
  all c : Class, t1, t2 : Teacher |
  (t1->c in Teaches) and (t2->c in Teaches) => (t1 = t2)
}

// For every class, every student has a group assigned.
pred inv10 {
  all c : Class, s : Student | some g : Group | c->s->g in Groups
}

// A class only has groups if it has a teacher assigned.
pred inv11 {
  all c : Class, g : Group, p : Person |
  (c->p->g in Groups) => (some t : Teacher | t->c in Teaches)
}

// Each teacher is responsible for some groups.
pred inv12 {
  all t : Teacher | some c : Class, g : Group, p : Person |
  (t->c in Teaches) and (c->p->g in Groups)
}

// Only teachers tutor, and only students are tutored.
pred inv13 {
  all p1, p2 : Person |
  (p1->p2 in Tutors) => (p1 in Teacher) and (p2 in Student)
}

// Every student in a class is at least tutored by the teachers assigned to
// that class.
pred inv14 {
  all s : Person, g : Group, c : Class | (c->s->g in Groups) =>
  (all t : Person | (t->c in Teaches) => (t->s in Tutors))
}

// Assuming a universe of 3 persons, the tutoring chain of every person
// eventually reaches a Teacher.
pred inv15 {
  all p1 : Person | some p2, p3 : Person |
  (p2->p1 in Tutors) and ((p2 in Teacher) or
  (p3->p2 in Tutors) and ((p3 in Teacher) or
  (p1->p3 in Tutors) and  (p1 in Teacher)))
}
