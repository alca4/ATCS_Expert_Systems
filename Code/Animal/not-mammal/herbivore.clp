/*
** Author: Andrew Liang
** Date of Creation: 11.15.2022
** Description: contains identification rules for herbivorous nonmammals
** Includes a function to undefine each rule
*/

(defrule is-bee
   (arthropod y)
 =>
   (finish "My guess: Is your animal a bee? ")
)

(defrule is-salamander
   (tree y)
   (water y)
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
   (aus n)
 =>
   (finish "My guess: Is your animal a pigeon? ")
)

(defrule is-parrot
   (bird y)
   (aus y)
 =>
   (finish "My guess: Is your animal a parrot? ")
)

/*
** Deletes all rules defined in file
*/
(deffunction clear-animal-rules ()
   (undefrule is-bee)
   (undefrule is-salamander)
   (undefrule is-iguana)
   (undefrule is-pigeon)
   (undefrule is-parrot)

   (return)
)