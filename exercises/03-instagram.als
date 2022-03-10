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
  posts in User one -> set Photo
}

// An user cannot follow itself.
pred inv2 {
  not some u : User | u->u in follows
}

// An user only sees (non ad) photos posted by followed users.
// Ads can be seen by everyone.
pred inv3 {
  all p : Photo - Ad, u1 : User | u1->p in sees
  => some u2 : User | u2->p in posts and u1->u2 in follows
}

// If an user posts an ad then all its posts should be labelled as ads.
pred inv4 {
  all a : Ad, p : Photo - Ad, u : User | u->a in posts => u->p not in posts
}

// Influencers are followed by everyone else.
pred inv5 {
  all i : Influencer, u : User | u != i => u->i in follows
}

// Influencers post every day.
pred inv6 {
  all d : Day, i : Influencer | some p : Photo | i->p in posts and p->d in date
}

// Suggested are other users followed by followed users, but not yet followed.
pred inv7 {
  all u1, u3 : User | (u1->u3 in suggested) <=>
  (u1->u3 not in follows and u1 != u3) and
  (some u2 : User | u1->u2 in follows and u2->u3 in follows)
}

// An user only sees ads from followed or suggested users.
pred inv8 {
  all v, u : User, a : Ad | (v->a in sees and u->a in posts)
  => (v->u in follows or v->u in suggested)
}
