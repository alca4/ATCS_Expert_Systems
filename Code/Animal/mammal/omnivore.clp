/*
** Author: Andrew Liang
** Date of Creation: 11.15.2022
** Description: contains identification rules for omnivorous mammals
** Includes a function to undefine each rule
*/

(defrule is-pig
   (pet n)
   (tree n)
   (farm y)
 =>
   (finish "My guess: Is your animal a pig? ")
)

(defrule is-grizzly-bear
   (pet n)
   (tree y)
   (tail y)
 =>
   (finish "My guess: Is your animal a grizzly bear? ")
)

(defrule is-dog
   (pet y)
   (tree n)
   (whisker n)
 =>
   (finish "My guess: Is your animal a dog? ")
)

(defrule is-squirrel
   (pet n)
   (tree y)
   (whisker y)
 =>
   (finish "My guess: Is your animal a squirrel? ")
)

(defrule is-mouse
   (pet n)
   (tree n)
   (whisker y)
 =>
   (finish "My guess: Is your animal a mouse? ")
)

(defrule is-monkey
   (pet n)
   (tree y)
   (tail n)
   (whisker n)
 =>
   (finish "My guess: Is your animal a monkey? ")
)

/*
** Deletes all rules defined in file
*/
(deffunction clear-animal-rules ()
   (undefrule is-pig)
   (undefrule is-grizzly-bear)
   (undefrule is-dog)
   (undefrule is-squirrel)
   (undefrule is-mouse)
   (undefrule is-monkey)

   (return)
)