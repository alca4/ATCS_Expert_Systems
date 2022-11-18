/*
** Author: Andrew Liang
** Date of Creation: 11.15.2022
** Description: contains identification rules for omnivorous nonmammals
** Includes a function to undefine each rule
*/

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
   (claw n)
 =>
   (finish "My guess: Is your animal a duck? ")
)

(defrule is-chicken
   (bird y)
   (claw y)
 =>
   (finish "My guess: Is your animal a chicken? ")
)

(defrule is-goldfish
   (bird n)
   (fish y)
 =>
   (finish "My guess: Is your animal a goldfish? ")
)

/*
** Deletes all rules defined in file
*/
(deffunction clear-animal-rules ()
   (undefrule is-crab)
   (undefrule is-turtle)
   (undefrule is-duck)
   (undefrule is-chicken)
   (undefrule is-goldfish)
   
   (return)
)