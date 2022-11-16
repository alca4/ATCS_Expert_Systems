(defrule is-pig
   (farm y)
 =>
   (finish "My guess: Is your animal a pig? ")
)

(defrule is-bear
   (tree y)
 =>
   (finish "My guess: Is your animal a bear? ")
)

(defrule is-dog
   (aus y)
 =>
   (finish "My guess: Is your animal a dog? ")
)

(defrule is-hamster
   (whisker y)
 =>
   (finish "My guess: Is your animal a hamster? ")
)

(deffunction clear-animal-rules ()
   (undefrule is-pig)
   (undefrule is-bear)
   (undefrule is-dog)
   (undefrule is-hamster)

   (return)
)