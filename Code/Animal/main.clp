/*
** Author: Andrew Liang
** Date of Creation: 10.06.2022
** Description: 
** Plays the animal game using forward and backward chaining
** 
** Each animal has some traits
** Traits contain a string (its name) and a number (its condition)
** n: when asked question, user either responded no or system found that no remaining animal could have this trait
** y: when asked question, user either responded yes or system found that all remaining animals had this trait
** 
** Each animal has an associated rule which guesses the animal when its characteristics are matched
** This rule is not necessarily in this file
** 
** The game terminates with a win when an animal is guessed (regardless of whether the animal was correct)
** The game terminates with a loss when one of two conditions are met:
** 1. Twenty questions have been asked before the system determined an animal
** 2. The system cannot gain new information and has not determined an animal
** 
** Salience is used so that rules pertaining to the first knowledge island split fire first
** 
*/

(batch "./Code/utilities_v4.clp")
(defglobal ?*HEADER* = "./Code/Animal")      ; header of the file 

(defglobal ?*QUESTION_LIMIT* = 20)
(defglobal ?*questionsAsked* = 0)

; does backward chaining for every trait. some traits which require explanation have additional comments
(do-backward-chaining omnivore)
(do-backward-chaining carnivore)
(do-backward-chaining herbivore)
(do-backward-chaining mammal)
(do-backward-chaining arthropod)
(do-backward-chaining reptile)
(do-backward-chaining bird)
(do-backward-chaining fish)
(do-backward-chaining farm)
(do-backward-chaining pet)
(do-backward-chaining tree)
(do-backward-chaining water)                 ; lives underwater for part of their life
(do-backward-chaining shell)                 ; has shell or protective covering
(do-backward-chaining horn)
(do-backward-chaining tail)                  ; has a short tail compared to its body
(do-backward-chaining claw)
(do-backward-chaining warm)                  ; lives in a warm land environment (desert, savannah)
(do-backward-chaining aus)                   ; native to australia-not imported within last 1000 years
(do-backward-chaining whisker)
(do-backward-chaining sting)
(do-backward-chaining reptile-bird)          ; a reptile or bird
(do-backward-chaining appendage)             ; has >4 appendages

(defrule first-rule "prints user interface instructions"
   (declare (salience 100))
 =>
   (printline "Welcome to the Animal Game! Please think of an animal.")
   (printline "In the course of this game you will be asked a up to 20 yes/no questions regarding your animal.")
   (printline "Please answer with forms of yes, no, and unsure. Note that unsure answers will be treated as a no.")
   (printline "You can also answer 'f' for a facts dump and 'q' to exit the game")
   (printline "The game can be rerun by using the commands \"(reset) (run)\" in Jess")
   (printline "The system has twenty questions to guess your animal. Good luck!")
   (printline "")
)

(defrule last-rule "last rule to fire, fires when no animals with matching characteristics found. erases all animal rules batched in"
   (declare (salience -100))
 =>
   (finish "I can't get any more information and I still don't know what it is :(")
)

; Question asking functions
(defrule ask-omnivore
   (need-omnivore ?)
 =>
   (assert (omnivore (askQuestion "Is your animal an omnivore? ")))
)

(defrule ask-carnivore
   (need-carnivore ?)
 =>
   (assert (carnivore (askQuestion "Is your animal a carnivore? ")))
)

(defrule ask-herbivore
   (need-herbivore ?)
 =>
   (assert (herbivore (askQuestion "Is your animal an herbivore? ")))
)

(defrule ask-mammal
   (declare (salience 1))
   (need-mammal ?)
 =>
   (assert (mammal (askQuestion "Is your animal a mammal? ")))
)

(defrule ask-arthropod
   (need-arthropod ?)
 =>
   (assert (arthropod (askQuestion "Is your animal an arthropod? ")))
)

(defrule ask-reptile
   (need-reptile ?)
 =>
   (assert (reptile (askQuestion "Is your animal a reptile? ")))
)

(defrule ask-bird
   (need-bird ?)
 =>
   (assert (bird (askQuestion "Is your animal a bird? ")))
)

(defrule ask-fish
   (need-fish ?)
 =>
   (assert (fish (askQuestion "Is your animal a fish? ")))
)

(defrule ask-farm
   (need-farm ?)
 =>
   (assert (farm (askQuestion "Is your animal a farm animal? ")))
)

(defrule ask-pet
   (need-pet ?)
 =>
   (assert (pet (askQuestion "Is your animal a common household pet? ")))
)

(defrule ask-tree
   (need-tree ?)
 =>
   (assert (tree (askQuestion "Can your animal climb trees? ")))
)

(defrule ask-water
   (need-water ?)
 =>
   (assert (water (askQuestion "Does your animal live underwater for some of their life? ")))
)

(defrule ask-shell
   (need-shell ?)
 =>
   (assert (shell (askQuestion "Does your animal have a shell or other protective covering? ")))
)

(defrule ask-horn
   (need-horn ?)
 =>
   (assert (horn (askQuestion "Does your animal have a horn or antlers? ")))
)

(defrule ask-tail
   (need-tail ?)
 =>
   (assert (tail (askQuestion "Does your animal have a short tail? ")))
)

(defrule ask-claw
   (need-claw ?)
 =>
   (assert (claw (askQuestion "Does your animal have claws? ")))
)

(defrule ask-warm
   (need-warm ?)
 =>
   (assert (warm (askQuestion "Does your animal live in a warm land environment? ")))
)

(defrule ask-aus
   (need-aus ?)
 =>
   (assert (aus (askQuestion "Is one of your animal's subspecies native to Australia? ")))
)

(defrule ask-whisker
   (need-whisker ?)
 =>
   (assert (whisker (askQuestion "Does your animal have whiskers? ")))
)

(defrule ask-sting
   (need-sting ?)
 =>
   (assert (sting (askQuestion "Does your animal sting? ")))
)

(defrule ask-reptile-bird
   (need-reptile-bird ?)
 =>
   (assert (reptile-bird (askQuestion "Is your animal a reptile or bird? ")))
)

(defrule ask-appendage
   (need-appendage ?)
 =>
   (assert (appendage (askQuestion "Does your animal have more than 4 appendages? ")))
)

; First knowledge island separation: mammal vs non-mammal

(defrule is-mammal
   (declare (salience 2))
   (mammal y)
 =>
   (bind ?*HEADER* (str-cat ?*HEADER* "/mammal"))
)

(defrule is-not-mammal
   (declare (salience 2))
   (mammal n)
 =>
   (bind ?*HEADER* (str-cat ?*HEADER* "/not-mammal"))
)

; Second knowledge island separation: what does the animal eat?

(defrule is-omnivore
   (declare (salience 1))
   (omnivore y)
 =>
   (bind ?*HEADER* (str-cat ?*HEADER* "/omnivore"))
   (assert (carnivore n))
)

(defrule is-carnivore
   (declare (salience 1))
   (carnivore y)
 =>
   (bind ?*HEADER* (str-cat ?*HEADER* "/carnivore"))
   (assert (omnivore n))
)

(defrule is-herbivore
   (declare (salience 1))
   (omnivore n)
   (carnivore n)
 =>
   (bind ?*HEADER* (str-cat ?*HEADER* "/herbivore"))
)

; Third knowledge island separation: among carnivorous nonmammals, is the animal a reptile or bird or not?

(defrule is-carnivore-reptile-bird "checks for a carnivore that is a reptile or bird"
   (mammal n)
   (carnivore y)
   (reptile-bird y)
 =>
   (bind ?*HEADER* (str-cat ?*HEADER* "/reptile-bird"))
)

(defrule is-carnivore-not-reptile-bird "checks for a carnivore that is neither a reptile nor bird"
   (mammal n)
   (carnivore y)
   (reptile-bird n)
 =>
   (bind ?*HEADER* (str-cat ?*HEADER* "/not-reptile-bird"))
)


(defrule load-animals "loads animals based on the header determined by knowledge island separation"
   (declare (salience -1))
 =>
   (batch (str-cat ?*HEADER* ".clp"))
)

; Gameplay functions

/*
** Executed when an animal is found or for some reason the game is terminated
** Prints the appropriate message
** If animals have been loaded in from a knowledge island, erases them
** Stops the rule engine
*/
(deffunction finish (?msg)

   (printline ?msg)

   (clear-animal-rules)                      ; only a function when animals are loaded in
                                             ; otherwise interpreted as pattern and left alone

   (printline (str-cat "Number of questions asked: " ?*questionsAsked*))
   (halt)
)

/*
** Given a trait (stored as ?msg), asks the user if their animal has this trait
** Halts the rule engine it system receives 'q' or 'quit'
** Prints the facts if receives 'f'
** Asks until a yes, no, or unsure answer is received
** returns y if user answered with forms of "yes", n if user answered with "no" or "unsure"
*/
(deffunction askQuestion (?msg)

   (bind ?ret "dummy") ; if the question limit is exceeded, it still needs to return ?ret, so a dummy variable is assigned here

   (if (eq ?*questionsAsked* ?*QUESTION_LIMIT*) then (finish "It seems that I have asked too many questions :( ")
    else
      (printout t ?msg)
      (bind ?ans "")
      (while (eq (str-length ?ans) 0) (bind ?ans (lowcase (readline t))))

      (while (not (or (eq ?ans "y") (eq ?ans "yes") (eq ?ans "n") (eq ?ans "no") 
                      (eq ?ans "u") (eq ?ans "unknown") (eq ?ans "i don't know") (eq ?ans "unsure") 
                      (eq ?ans "q") (eq ?ans "quit")))

         (if (eq ?ans "f") then 
            (facts)
            (printout t ?msg)
          else 
            (printout t "please respond with yes, no, or unsure ")
         )

         (bind ?ans "")
         (while (eq (str-length ?ans) 0) (bind ?ans (lowcase (readline t))))
      ) ; (while (not (or (eq ?ans "y") (eq ?ans "yes") (eq ?ans "n") (eq ?ans "no") 
        ;                 (eq ?ans "u") (eq ?ans "unknown") (eq ?ans "i don't know") (eq ?ans "unsure") 
        ;                 (eq ?ans "q") (eq ?ans "quit")))

      (if (or (eq ?ans "q") (eq ?ans "quit")) then (finish "Game terinated by user choice."))

      (if (or (eq ?ans "y") (eq ?ans "yes")) then (bind ?ret y)
       else (bind ?ret n)
      )

   ) ; (if (eq ?*questionsAsked* ?*QUESTION_LIMIT*) then

   (++ ?*questionsAsked*)

   (return ?ret)
)