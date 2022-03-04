/// First-order logic revision exercises based on a simple model of a file
/// system trash can.
///
/// The model has 3 unary predicates (sets), File, Trash and Protected, the
/// latter two a sub-set of File. There is a binary predicate, link, a sub-set
/// of File x File.

// The set of files in the file system.
sig File {
      // A file is potentially a link to other files.
    link : set File
}

// The set of files in the trash.
sig Trash in File {}

// The set of protected files.
sig Protected in File {}

// The trash is empty.
pred inv1 {
    not some f : File | f in Trash
}

// All files are deleted.
pred inv2 {
    all f : File | f in Trash
}

// Some file is deleted.
pred inv3 {
    some f : File | f in Trash
}

// Protected files cannot be deleted.
pred inv4 {
    all p : Protected | p not in Trash
}

// All unprotected files are deleted.
pred inv5 {
    all f : File | (f not in Protected) => (f in Trash)
}

// A file links to at most one file.
pred inv6 {
    all l, f1, f2 : File | (l->f1 in link) and (l->f2 in link) => f1 = f2
}

// There is no deleted link.
pred inv7 {
    not some l, f : File | (l->f in link) and (f in Trash)
}

// There are no links.
pred inv8 {
    not some l, f : File | l->f in link
}

// A link does not link to another link.
pred inv9 {
    not some l1, l2, f : File | (l1->l2 in link) and (l2->f in link)
}

// If a link is deleted, so is the file it links to.
pred inv10 {
    all l, f : File | (l->f in link) and (l in Trash) => (f in Trash)
}

