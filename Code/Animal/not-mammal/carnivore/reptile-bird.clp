(defrule is-alligator
   (reptile y)
   (tree n)
 =>
   (finish "My guess: Is your animal an alligator? ")
)

(defrule is-snake
   (reptile y)
   (tree y)
 =>
   (finish "My guess: Is your animal a snake? ")
)

(defrule is-owl
   (reptile n)
   (tail y)
 =>
   (finish "My guess: Is your animal an owl? ")
)

(defrule is-penguin
   (reptile n)
   (tail n)
 =>
   (finish "My guess: Is your animal a penguin? ")
)

(deffunction clear-animal-rules ()
   (undefrule is-alligator)
   (undefrule is-snake)
   (undefrule is-owl)
   (undefrule is-penguin)

   (return)
)
