(defrule is-dolphin
   (water y)
 =>
   (finish "My guess: Is your animal a dolphin? ")
)

(defrule is-polar-bear
   (tail y)
 =>
   (finish "My guess: Is your animal a polar bear? ")
)

(defrule is-cat
   (pet y)
 =>
   (finish "My guess: Is your animal a cat? ")
)

(defrule is-drop-bear "this isn't a real animal but it's funny. the win message drops down. weird spacing in code makes it neat when printing out"
   (tree y)
 =>
   (finish "My guess: Is your animal a drop bear?")
)

(deffunction clear-animal-rules ()
   (undefrule is-dolphin)
   (undefrule is-polar-bear)
   (undefrule is-cat)
   (undefrule is-drop-bear)

   (return)
)