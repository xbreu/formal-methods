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

}

// Only professors can teach courses.
pred inv2 {

}

// Courses must have teachers.
pred inv3 {

}

// Projects are proposed by one course.
pred inv4 {

}

// Only students work on projects and projects must have someone working on
// them.
pred inv5 {

}

// Students only work on projects of courses they are enrolled in.
pred inv6 {

}

// Students work on at most one project per course.
pred inv7 {

}

// A professor cannot teach herself.
pred inv8 {

}

// A professor cannot teach colleagues.
pred inv9 {

}

// Only students have grades.
pred inv10 {

}

// Students only have grades in courses they are enrolled.
pred inv11 {

}

// Students have at most one grade per course.
pred inv12 {

}

// A student with the highest mark in a course must have worked on a project on
// that course.
pred inv13 {

}

// A student cannot work with the same student in different projects.
pred inv14 {

}

// Students working on the same project in a course cannot have marks differing
// by more than one unit.
pred inv15 {

}
