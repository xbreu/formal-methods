/// The unsolved exercises and interface for running the file online can be
/// found at http://alloy4fun.inesctec.pt/Sb4ZFxbpoLgMo2Nhh

// ----------------------------------------------------------------------------
// Definitions
// ----------------------------------------------------------------------------

sig User {
  follows : set User,
  sees : set Photo,
  posts : set Photo,
  suggested : set User
}

sig Influencer extends User {}

sig Photo {
  date : one Day
}
sig Ad extends Photo {}

sig Day {}

// ----------------------------------------------------------------------------
// Properties
// ----------------------------------------------------------------------------

// Every image is posted be one user.
pred inv1 {

}

// An user cannot follow itself.
pred inv2 {

}

// An user only sees (non ad) photos posted by followed users.
// Ads can be seen by everyone.
pred inv3 {

}

// If an user posts an ad then all its posts should be labelled as ads.
pred inv4 {

}

// Influencers are followed by everyone else.
pred inv5 {

}

// Influencers post every day.
pred inv6 {

}

// Suggested are other users followed by followed users, but not yet followed.
pred inv7 {

}

// An user only sees ads from followed or suggested users.
pred inv8 {

}
