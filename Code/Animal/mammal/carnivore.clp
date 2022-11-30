/*
** Author: Andrew Liang
** Date of Creation: 11.15.2022
** Description: contains identification rules for carnivorous mammals
** Includes a function to undefine each rule
*/

(defrule is-dolphin
   (warm n)
   (water y)
   (whiskers n)
 =>
   (finish "My guess: Is your animal a dolphin? ")
)

(defrule is-polar-bear
   (warm n)
   (tail y)
 =>
   (finish "My guess: Is your animal a polar bear? ")
)

(defrule is-cat
   (warm n)
   (pet y)
 =>
   (finish "My guess: Is your animal a cat? ")
)

(defrule is-drop-bear "this isn't a real animal but it's funny"
   (warm y)
   (tree y)
 =>
   (finish "My guess: Is your animal a drop bear?")
)

(defrule is-lion
   (warm y)
   (whisker y)
 =>
   (finish "My guess: Is your animal a lion?")
)

(defrule is-seal
   (warm n)
   (water y)
   (whisker y)
 =>
   (finish "My guess: Is your animal a seal?")
)

/*
** Deletes all rules defined in file
*/
(deffunction clear-animal-rules ()
   (undefrule is-dolphin)
   (undefrule is-polar-bear)
   (undefrule is-cat)
   (undefrule is-drop-bear)
   (undefrule is-lion)
   (undefrule is-seal)

   (return)
)