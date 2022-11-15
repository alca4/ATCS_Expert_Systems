/*
** Author: Andrew Liang
** Date of Creation: 10.06.2022
** Description: 
** Plays the animal game using purely forward chaining
** 
** Each animal has some traits
** Traits contain a string (its name) and a number (its condition)
** n: when asked question, user either responded no or system found that no remaining animal could have this trait
** y: when asked question, user either responded yes or system found that all remaining animals had this trait
** 
** Each animal has an associated rule which guesses the animal when its characteristics are matched
** 
** The game terminates with a win when an animal is guessed (regardless of whether the animal was correct)
** The game terminates with a loss when one of two conditions are met:
** 1. Twenty questions have been asked before the system determined an animal
** 2. The system cannot gain new information and has not determined an animal
** 
** Salience order is as follows:
** 10000: first rule: prints debug info
** 100: conflicting response: the system is certain at this point there can be no animal
** 10: dependency rules: the system must get as much information as it can before guessing
** 1: animal-guessing rules: the system must ensure there are no matching animals before guessing an animal
** 0: question-asking rules: the system must ensure it cannot ask questions before deterining there can be no more information given
** -100: there is no more information left
*/

(batch "./Code/utilities_v4.clp")
(defglobal ?*QUESTION_LIMIT* = 20)
(defglobal ?*QUESTIONS_ASKED* = 0)

; need backward chaining
(do-backward-chaining omnivore)
(do-backward-chaining carnivore)
(do-backward-chaining herbivore)
(do-backward-chaining mammal)
(do-backward-chaining arthropod)
(do-backward-chaining reptile)
(do-backward-chaining farm)
(do-backward-chaining leg)
(do-backward-chaining pet)
(do-backward-chaining tree)
(do-backward-chaining water)
(do-backward-chaining bird)
(do-backward-chaining fish)
(do-backward-chaining heavy)
(do-backward-chaining medium)
(do-backward-chaining light)
(do-backward-chaining shell)
(do-backward-chaining horn)
(do-backward-chaining tail)
(do-backward-chaining claw)

(defrule first-rule "prints user interface instructions"
   (declare (salience 10000))
 =>
   (printline "Welcome to the Animal Game! Please think of an animal.")
   (printline "In the course of this game you will be asked a up to 20 yes/no questions regarding your animal.")
   (printline "Please answer with forms of yes, no, and unsure. Note that unsure answers will be treated as a no.")
   (printline "You can also answer 'f' for a facts dump and 'q' to exit the game")
   (printline "The system has twenty questions to guess your animal. Good luck!")
   (printline "")
)

; termination rules (if these fire i've lost the game)

(defrule last-rule "last rule to fire, fires when no animals with matching characteristics found"
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

(defrule ask-farm
   (need-farm ?)
 =>
   (assert (farm (askQuestion "Is your animal a farm animal? ")))
)

(defrule ask-leg
   (need-leg ?)
 =>
   (assert (leg (askQuestion "Does your animal have legs? ")))
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
   (assert (water (askQuestion "Does your animal live underwater? ")))
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

(defrule ask-heavy
   (need-heavy ?)
 =>
   (assert (heavy (askQuestion "Does your animal have a mass > 10kg? ")))
)

(defrule ask-medium
   (need-medium ?)
 =>
   (assert (medium (askQuestion "Does your animal have a mass between 1kg and 10kg? ")))
)

(defrule ask-light
   (need-light ?)
 =>
   (assert (light (askQuestion "Does your animal have a mass between < 10kg? ")))
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
   (assert (tail (askQuestion "Does your animal have a tail of >10cm? ")))
)

(defrule ask-claw
   (need-claw ?)
 =>
   (assert (claw (askQuestion "Does your animal have claws? ")))
)

; Animal rules: identifies an animal based on a unique subset of traits 
(defrule is-pig
   (omnivore y)
   (farm y)
   (heavy y)
 =>
   (finish "My guess: Is your animal a pig? ")
)

(defrule is-dog
   (omnivore y)
   (pet y)
   (medium y)
 =>
   (finish "My guess: Is your animal a dog? ")
)

(defrule is-hamster
   (omnivore y)
   (light y)
   (tail y)
 =>
   (finish "My guess: Is your animal a hamster? ")
)

(defrule is-bear
   (omnivore y)
   (tree y)
 =>
   (finish "My guess: Is your animal a bear? ")
)

(defrule is-crab
   (omnivore y)
   (arthropod y)
 =>
   (finish "My guess: Is your animal a crab? ")
)

(defrule is-turtle
   (omnivore y)
   (reptile y)
 =>
   (finish "My guess: Is your animal a turtle? ")
)

(defrule is-chicken
   (omnivore y)
   (bird y)
   (claws y)
 =>
   (finish "My guess: Is your animal a chicken? ")
)

(defrule is-duck
   (farm y)
   (water y)
 =>
   (finish "My guess: Is your animal a duck? ")
)

(defrule is-goldfish
   (omnivore y)
   (fish y)
 =>
   (finish "My guess: Is your animal a goldfish? ")
)

(defrule is-cat
   (carnivore y)
   (mammal y)
   (pet y)
 =>
   (finish "My guess: Is your animal a cat? ")
)

(defrule is-polar-bear
   (carnivore y)
   (mammal y)
   (leg y)
   (heavy y)
 =>
   (finish "My guess: Is your animal a polar bear? ")
)

(defrule is-dolphin
   (mammal y)
   (water y)
 =>
   (finish "My guess: Is your animal a dolphin? ")
)

(defrule is-alligator
   (carnivore y)
   (reptile y)
   (leg y)
 =>
   (finish "My guess: Is your animal an alligator? ")
)

(defrule is-snake
   (reptile y)
   (tree y)
 =>
   (finish "My guess: Is your animal a snake? ")
)

(defrule is-owl
   (carnivore y)
   (medium y)
 =>
   (finish "My guess: Is your animal an owl? ")
)

(defrule is-frog
   (carnivore y)
   (light y)
 =>
   (finish "My guess: Is your animal a frog? ")
)

(defrule is-polar-bear
   (carnivore y)
   (mammal y)
 =>
   (finish "My guess: Is your animal a polar bear? ")
)

(defrule is-penguin
   (carnivore y)
   (water y)
   (bird y)
 =>
   (finish "My guess: Is your animal a penguin? ")
)

(defrule is-dolphin
   (carnivore y)
   (mammal y)
   (water y)
 =>
   (finish "My guess: Is your animal a dolphin? ")
)

(defrule is-whale
   (carnivore y)
   (mammal y)
   (water y)
 =>
   (finish "My guess: Is your animal a dolphin? ")
)

; Gameplay functions

/*
** Executed when an animal is found or for some reason the game is terminated
** Prints the appropriate message
** Stops the rule engine
*/
(deffunction finish (?msg)
   (printline ?msg)
   (printline (str-cat "Number of questions asked: " ?*QUESTIONS_ASKED*))
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

   (if (= ?*QUESTIONS_ASKED* ?*QUESTION_LIMIT*) then (finish "It seems that I have asked too many questions :( ")
    else
      (printout t ?msg)
      (bind ?ans "")
      (while (= (str-length ?ans) 0) (bind ?ans (lowcase (readline t))))

      (while (not (or (= ?ans "y") (= ?ans "yes") (= ?ans "n") (= ?ans "no") 
                      (= ?ans "u") (= ?ans "unknown") (= ?ans "i don't know") (= ?ans "unsure") 
                      (= ?ans "q") (= ?ans "quit")))

         (if (= ?ans "f") then 
            (facts)
            (printout t ?msg)
          else 
            (printout t "please respond with yes, no, or unsure ")
         )

         (while (= (str-length ?ans) 0) (bind ?ans (lowcase (readline t))))

      ) ; (while (not (or (= ?ans "y") (= ?ans "yes") (= ?ans "n") (= ?ans "no") 
        ;                 (= ?ans "u") (= ?ans "unknown") (= ?ans "i don't know") (= ?ans "unsure") 
        ;                 (= ?ans "q") (= ?ans "quit")))

      (if (or (= ?ans "q") (= ?ans "quit")) then (finish "Game terinated by user choice."))

      (if (or (= ?ans "y") (= ?ans "yes")) then (bind ?ret y)
       else (bind ?ret n)
      )

   ) ; (if (= ?*QUESTIONS_ASKED* ?*QUESTION_LIMIT*) then

   (++ ?*QUESTIONS_ASKED*)

   (return ?ret)
)