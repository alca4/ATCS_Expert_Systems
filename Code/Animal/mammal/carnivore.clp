(defrule is-dolphin
   (warm n)
   (water y)
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

(deffunction clear-animal-rules ()
   (undefrule is-dolphin)
   (undefrule is-polar-bear)
   (undefrule is-cat)
   (undefrule is-drop-bear)
   (undefrule is-lion)

   (return)
)