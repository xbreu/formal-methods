/// The unsolved exercises and interface for running the file online can be
/// found at http://alloy4fun.inesctec.pt/aGLwjkC4HDq9ckpcA

open util/ordering[Grade]

// ----------------------------------------------------------------------------
// Definitions
// ----------------------------------------------------------------------------

sig Person {
  teaches : set Course,
  enrolled : set Course,
  projects : set Project
}

sig Professor, Student in Person {}

sig Course {
  projects : set Project,
  grades : Person -> Grade
}

sig Project {}

sig Grade {}

// ----------------------------------------------------------------------------
// Properties
// ----------------------------------------------------------------------------

// Only students can be enrolled in courses.
pred inv1 {
  (enrolled . Course) in Student
}

// Only professors can teach courses.
pred inv2 {
  (teaches . Course) in Professor
}

// Courses must have teachers.
pred inv3 {
  Course in (Person . teaches)
}

// Projects are proposed by one course.
pred inv4 {
  (this/Course <: projects) in Course one -> Project
}

// Only students work on projects and projects must have someone working on
// them.
pred inv5 {
  (this/Person <: projects) in Student some -> Project
}

// Students only work on projects of courses they are enrolled in.
pred inv6 {
  all s : Student |
  (s . (this/Person <: projects) . ~(this/Course <: projects))
  in s . enrolled
}

// Students work on at most one project per course.
pred inv7 {
  all c:Course, s:Student | lone (s.projects) & (c.projects)
}

// A professor cannot teach herself.
pred inv8 {
  all p : Professor | p not in (p . teaches . ~enrolled)
}

// A professor cannot teach colleagues.
pred inv9 {
  all p : Professor, c : p . teaches |
  no (c . ~teaches - p) & (p . teaches . ~enrolled)
}

// Only students have grades.
pred inv10 {
  grades in Course -> Student -> Grade
}

// Students only have grades in courses they are enrolled.
pred inv11 {
  all s : Student | (grades . Grade . s) in (s . enrolled)
}

// Students have at most one grade per course.
pred inv12 {
  all s : Student, c : Course | lone s . (c . grades)
}

// A student with the highest mark in a course must have worked on a project on
// that course. TODO
pred inv13 {
  // all c : Course | some s : (c . ~enrolled) | {
  //   max[Person . (c . grades)] = (s . (c . grades))
  //   some (c . projects & s . projects)
  // }
}

// A student cannot work with the same student in different projects.
pred inv14 {
  all disj s1, s2 : Student | lone (s1 . projects & s2 . projects)
}

// Students working on the same project in a course cannot have marks differing
// by more than one unit. TODO
pred inv15 {
  // all c : Course, p : c . projects, disj s1, s2 : p . ~(Person <: projects) |
  // (s1 . (c . grades)) . prev =  (s2 . (c . grades)) or
  // (s2 . (c . grades)) . prev =  (s1 . (c . grades))
}
