(defrule is-bee
   (arthropod y)
 =>
   (finish "My guess: Is your animal a bee? ")
)

(defrule is-salamander
   (arthopod n)
   (claw n)
 =>
   (finish "My guess: Is your animal a salamander? ")
)

(defrule is-iguana
   (claw y)
   (aus n)
 =>
   (finish "My guess: Is your animal an iguana? ")
)

(defrule is-pigeon
   (bird y)
 =>
   (finish "My guess: Is your animal a pigeon? ")
)

(defrule is-parrot
   (claw y)
   (aus y)
 =>
   (finish "My guess: Is your animal a parrot? ")
)

(deffunction clear-animal-rules ()
   (undefrule is-bee)
   (undefrule is-salamander)
   (undefrule is-iguana)
   (undefrule is-pigeon)
   (undefrule is-parrot)

   (return)
)