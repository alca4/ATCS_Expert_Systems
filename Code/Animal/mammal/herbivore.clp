(defrule is-cow
   (horn y)
   (farm y)
 =>
   (finish "My guess: Is your animal a cow? ")
)

(defrule is-rabbit
   (horn n)
   (pet y)
 =>
   (finish "My guess: Is your animal a rabbit? ")
)

(defrule is-moose
   (horn y)
   (tail y)
 =>
   (finish "My guess: Is your animal a moose? ")
)

(defrule is-elephant
   (horn n)
   (warm y)
 =>
   (finish "My guess: Is your animal an elephant? ")
)

(defrule is-koala
   (horn n)
   (tree y)
 =>
   (finish "My guess: Is your animal a koala?")
)

(deffunction clear-animal-rules ()
   (undefrule is-cow)
   (undefrule is-rabbit)
   (undefrule is-moose)
   (undefrule is-elephant)
   (undefrule is-koala)

   (return)
)