/*
** Author: Andrew Liang
** Date of Creation: 11.15.2022
** Description: contains identification rules for herbivorous mammals
** Includes a function to undefine each rule
*/

(defrule is-cow
   (tail n)
   (farm y)
 =>
   (finish "My guess: Is your animal a cow? ")
)

(defrule is-rabbit
   (tail y)
   (pet y)
 =>
   (finish "My guess: Is your animal a rabbit? ")
)

(defrule is-moose
   (tail y)
   (horn y)
 =>
   (finish "My guess: Is your animal a moose? ")
)

(defrule is-elephant
   (tail n)
   (warm y)
 =>
   (finish "My guess: Is your animal an elephant? ")
)

(defrule is-koala
   (tail n)
   (tree y)
 =>
   (finish "My guess: Is your animal a koala?")
)

(defrule is-panda
   (tail y)
   (tree y)
 =>
   (finish "My guess: Is your animal a panda?")
)

(defrule is-goat
   (tail y)
   (farm y)
 =>
   (finish "My guess: Is your animal a goat? ")
)

/*
** Deletes all rules defined in file
*/
(deffunction clear-animal-rules ()
   (undefrule is-cow)
   (undefrule is-rabbit)
   (undefrule is-moose)
   (undefrule is-elephant)
   (undefrule is-koala)
   (undefrule is-panda)
   (undefrule is-goat)

   (return)
)