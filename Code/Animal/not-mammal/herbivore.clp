(defrule is-bee
   (arthropod y)
 =>
   (finish "My guess: Is your animal a bee? ")
)

(defrule is-salamander
   (water y)
 =>
   (finish "My guess: Is your animal a salamander? ")
)

(defrule is-iguana
   (claws y)
 =>
   (finish "My guess: Is your animal an iguana? ")
)

(defrule is-pigeon
   (bird y)
 =>
   (finish "My guess: Is your animal a pigeon? ")
)

(deffunction clear-animal-rules ()
   (undefrule is-bee)
   (undefrule is-salamander)
   (undefrule is-iguana)
   (undefrule is-pigeon)

   (return)
)