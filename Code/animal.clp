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
(do-backward-chaining mammal)
(do-backward-chaining omnivore)
(do-backward-chaining carnivore)
(do-backward-chaining herbivore)
(do-backward-chaining legs)
(do-backward-chaining bird)
(do-backward-chaining underwater)
(do-backward-chaining arthropod)
(do-backward-chaining fins)
(do-backward-chaining domesticated)
(do-backward-chaining tree)

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
(defrule ask-mammal
   (need-mammal ?)
 =>
   (assert (mammal (askQuestion "Is your animal a mammal?")))
)

(defrule ask-omnivore
   (need-omnivore ?)
 =>
   (assert (omnivore (askQuestion "Is your animal an omnivore?")))
)

(defrule ask-carnivore
   (need-carnivore ?)
 =>
   (assert (carnivore (askQuestion "Is your animal a carnivore?")))
)

(defrule ask-herbivore
   (need-herbivore ?)
 =>
   (assert (herbivore (askQuestion "Is your animal an herbivore?")))
)

(defrule ask-legs
   (need-legs ?)
 =>
   (assert (legs (askQuestion "Is your animal a legged animal?")))
)

(defrule ask-bird
   (need-bird ?)
 =>
   (assert (bird (askQuestion "Is your animal a bird?")))
)

(defrule ask-underwater
   (need-underwater ?)
 =>
   (assert (underwater (askQuestion "Is your animal an animal which lives underwater?")))
)

(defrule ask-arthropod
   (need-arthropod ?)
 =>
   (assert (arthropod (askQuestion "Is your animal an arthropod?")))
)

(defrule ask-fins
   (need-fins ?)
 =>
   (assert (fins (askQuestion "Is your animal an animal which has fins?")))
)

(defrule ask-domesticated
   (need-domesticated ?)
 =>
   (assert (domesticated (askQuestion "Is your animal domesticated?")))
)

(defrule ask-tree
   (need-tree ?)
 =>
   (assert (tree (askQuestion "Is your animal able to climb trees?")))
)

; Animal rules: identifies an animal based on a unique subset of traits 
(defrule is-owl
   (carnivore y)
   (face y)
 =>
   (finish "Is your animal an owl?")
)

(defrule is-cow
   (herbivore y)
   (mammal y)
   (domesticated y)
 =>
   (finish "Is your animal a cow?")
)

(defrule is-bee
   (herbivore y)
   (arthropod y)
 =>
   (finish "Is your animal a bee?")
)

(defrule is-frog
   (carnivore y)
   (tree y)
   (underwater y)
 =>
   (finish "Is your animal a frog?")
)

(defrule is-goldfish
   (omnivore y)
   (fins y)
 =>
   (finish "Is your animal a goldfish?")
)

(defrule is-bear
   (omnivore y)
   (mammal y)
   (tree y)
 =>
   (finish "Is your animal a bear?")
)

(defrule is-duck
   (omnivore y)
   (face y)
 =>
   (finish "Is your animal a duck?")
)

(defrule is-cat
   (carnivore y)
   (mammal y)
 =>
   (finish "Is your animal a cat?")
)

(defrule is-dog
   (omnivore y)
   (mammal y)
 =>
   (finish "Is your animal a dog?")
)

(defrule is-shark
   (carnivore y)
   (fins y)
 =>
   (finish "Is your animal a shark?")
)

(defrule is-snake
   (carnivore y)
   (tree y)
   (reptile y)
 =>
   (finish "Is your animal a snake?")
)

(defrule is-crab
   (omnivore y)
   (arthropod y)
 =>
   (finish "Is your animal a crab?")
)

(defrule is-elephant
   (herbivore y)
   (mammal y)
   (face y)
 =>
   (finish "Is your animal a crab?")
)

; Gameplay functions

/*
** Executed when an animal is found or for some reason the game is terminated
** Prints the appropriate message
** Stops the rule engine
*/
(deffunction finish (?msg)
   (printline ?msg)
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
      (printline ?msg)
      (bind ?ans (lowcase (readline t)))

      (while (not (or (= ?ans "y") (= ?ans "yes") (= ?ans "n") (= ?ans "no") 
                      (= ?ans "u") (= ?ans "unknown") (= ?ans "i don't know") (= ?ans "unsure") 
                      (= ?ans "q") (= ?ans "quit")))
         
         (if (= ?ans "f") then (facts)
          else (printline "please respond with yes, no, or unsure")
         )

         (bind ?ans (read t))

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