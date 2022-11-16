(defrule is-crab
   (bird n)
   (arthropod y)
 =>
   (finish "My guess: Is your animal a crab? ")
)

(defrule is-turtle
   (bird n)
   (reptile y)
 =>
   (finish "My guess: Is your animal a turtle? ")
)

(defrule is-duck
   (bird y)
   (aus y)
 =>
   (finish "My guess: Is your animal a duck? ")
)

(defrule is-chicken
   (bird y)
   (claws y)
 =>
   (finish "My guess: Is your animal a chicken? ")
)

(defrule is-goldfish
   (bird n)
   (fish y)
 =>
   (finish "My guess: Is your animal a goldfish? ")
)

(deffunction clear-animal-rules ()
   (undefrule is-crab)
   (undefrule is-turtle)
   (undefrule is-duck)
   (undefrule is-chicken)
   (undefrule is-goldfish)

   (return)
)