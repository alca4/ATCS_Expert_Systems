/*
** Author: Andrew Liang
** Date of Creation: 11.17.2022
** Description: contains identification rules for carnivorous animals which are not reptiles or birds
** Includes a function to undefine each rule
*/

(defrule is-shark
   (fish y)
   (appendage n)
 =>
   (finish "My guess: Is your animal a shark? ")
)

(defrule is-frog
   (tree y)
 =>
   (finish "My guess: Is your animal a frog? ")
)

(defrule is-coral
   (shell y)
 =>
   (finish "My guess: Is your animal a coral? ")
)

(defrule is-anemone
   (sting y)
 =>
   (finish "My guess: Is your animal a sea anemone? ")
)

(defrule is-axolotl
   (claw y)
 =>
   (finish "My guess: Is your animal an axolotl? ")
)

(defrule is-octopus
   (appendage y)
 =>
   (finish "My guess: Is your animal an octopus? ")
)

/*
** Deletes all rules defined in file
*/
(deffunction clear-animal-rules ()
   (undefrule is-shark)
   (undefrule is-frog)
   (undefrule is-coral)
   (undefrule is-anemone)
   (undefrule is-axolotl)
   (undefrule is-octopus)

   (return)
)
