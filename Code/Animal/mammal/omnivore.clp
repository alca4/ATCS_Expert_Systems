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
   (pet n)
   (tree n)
   (aus y)
 =>
   (finish "My guess: Is your animal a dog? ")
)

(defrule is-hamster
   (pet n)
   (tree n)
   (whisker y)
 =>
   (finish "My guess: Is your animal a hamster? ")
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

(deffunction clear-animal-rules ()
   (undefrule is-pig)
   (undefrule is-grizzly-bear)
   (undefrule is-dog)
   (undefrule is-hamster)
   (undefrule is-squirrel)
   (undefrule is-mouse)

   (return)
)