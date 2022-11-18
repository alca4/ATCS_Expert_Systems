(defrule is-alligator
   (reptile y)
   (claw y)
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
   (bird y)
   (tail y)
 =>
   (finish "My guess: Is your animal an owl? ")
)

(defrule is-penguin
   (reptile n)
   (bird y)
   (water y)
 =>
   (finish "My guess: Is your animal a penguin? ")
)

(defrule is-shark
   (reptile n)
   (bird n)
   (fish y)
 =>
   (finish "My guess: Is your animal a shark? ")
)

(defrule is-frog
   (reptile n)
   (bird n)
   (tree y)
 =>
   (finish "My guess: Is your animal a frog? ")
)

(defrule is-coral
   (reptile n)
   (bird n)
   (shell y)
 =>
   (finish "My guess: Is your animal a coral? ")
)

(defrule is-anemone
   (reptile n)
   (bird n)
   (sting y)
 =>
   (finish "My guess: Is your animal a sea anemone? ")
)

(deffunction clear-animal-rules ()
   (undefrule is-alligator)
   (undefrule is-snake)
   (undefrule is-owl)
   (undefrule is-penguin)
   (undefrule is-shark)
   (undefrule is-frog)
   (undefrule is-coral)
   (undefrule is-anemone)

   (return)
)
