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
** Each trait has a rule to ask it if it hasn't fired and 
** a rule which asserts other facts based on which traits it can gain additional information on
** Ex. if all birds are carnivores and no birds are domesticated (this is made up)
** then if (a_bird y) is detected, the rule will assert (a_carnivore y) and (a_domesticated_animal n) will be asserted
** 
** The game terminates with a win when an animal is guessed (regardless of whether the animal was correct)
** The game terminates with a loss when one of three conditions are met:
** 1. A trait has contradictory information (system determined that the animal both has and does not have a trait)
** 2. Twenty questions have been asked before the system determined an animal
** 3. The system cannot gain new information and has not determined an animal
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

(defrule conflicting-responses "terminates the game when there the animal both has and does not have a trait"
   (declare (salience 100))
   (trait ?txt ?v1)
   (trait ?txt ?v2 &~ ?v1)
 =>
   (finish (str-cat "Information on " ?txt " was conflicting."))
)

(defrule last-rule "last rule to fire, fires when no animals with matching characteristics found"
   (declare (salience -100))
 =>
   (finish "I can't get any more information and I still don't know what it is :(")
)

; Question asking functions
(defrule ask-is-mammal
   (not (trait a_mammal ?v))
 =>
   (assert (trait a_mammal (askQuestion "Is your animal a mammal?")))
)

(defrule ask-is-heavier-than-table
   (not (trait heavier_than_a_table ?v))
 =>
   (assert (trait heavier_than_a_table (askQuestion "Is your animal heavier than a table?")))
)

(defrule ask-is-omnivore
   (not (trait an_omnivore ?v))
 =>
   (assert (trait an_omnivore (askQuestion "Is your animal an omnivore?")))
)

(defrule ask-is-piscivore
   (not (trait a_piscivore ?v))
 =>
   (assert (trait a_piscivore (askQuestion "Is your animal a piscivore?")))
)

(defrule ask-is-arthropod
   (not (trait an_arthropod ?v))
 =>
   (assert (trait an_arthropod (askQuestion "Is your animal an arthopod?")))
)

(defrule ask-a-legged-animal
   (not (trait a_legged_animal ?v))
 =>
   (assert (trait a_legged_animal (askQuestion "Is your animal a legged animal?")))
)

(defrule ask-an-herbivore
   (not (trait an_herbivore ?v))
 =>
   (assert (trait an_herbivore (askQuestion "Is your animal an herbivore?")))
)

(defrule ask-an-animal-which-lives-underwater
   (not (trait an_animal_which_lives_underwater ?v))
 =>
   (assert (trait an_animal_which_lives_underwater (askQuestion "Is your animal an animal which lives underwater?")))
)

(defrule ask-a-carnivore
   (not (trait a_carnivore ?v))
 =>
   (assert (trait a_carnivore (askQuestion "Is your animal a carnivore?")))
)

; Animal rules: identifies an animal based on a unique subset of traits 
(defrule is-osprey
   (trait a_mammal n)
   (trait a_piscivore y)
   (trait an_animal_which_lives_underwater n)
 =>
   (finish "Is your animal an osprey?")
)

(defrule is-moth
   (trait an_arthropod y)
 =>
   (finish "Is your animal a moth?")
)

(defrule is-orangutan
   (trait a_mammal y)
   (trait heavier_than_a_table y)
   (trait an_omnivore y)
 =>
   (finish "Is your animal an orangutan?")
)

(defrule is-cow
   (trait a_mammal y)
   (trait heavier_than_a_table y)
   (trait a_legged_animal y)
 =>
   (finish "Is your animal a cow?")
)

(defrule is-horse
   (trait a_mammal y)
   (trait heavier_than_a_table y)
   (trait a_legged_animal y)
   (trait an_herbivore y)
   (trait an_animal_which_lives_underwater n)
 =>
   (finish "Is your animal a horse?")
)

(defrule is-frog
   (trait a_mammal n)
   (trait an_animal_which_lives_underwater y)
   (trait a_carnivore y)
 =>
   (finish "Is your animal a frog?")
)

; Dependency rules: if [some trait], then some other trait is true/false
(defrule is-a-mammal-then
   (declare (salience 10))
   (trait a_mammal y)
 =>
   (assert (trait heavier_than_a_table y))
   (assert (trait a_piscivore n))
   (assert (trait an_arthropod n))
   (assert (trait an_animal_which_lives_underwater n))
   (assert (trait a_carnivore n))
)

(defrule is-heavier-than-a-table-then
   (declare (salience 10))
   (trait heavier_than_a_table y)
 =>
   (assert (trait a_mammal y))
   (assert (trait a_piscivore n))
   (assert (trait an_arthropod n))
   (assert (trait an_animal_which_lives_underwater n))
   (assert (trait a_carnivore n))
)

(defrule is-a-omnivore-then
   (declare (salience 10))
   (trait an_omnivore y)
 =>
   (assert (trait a_mammal y))
   (assert (trait heavier_than_a_table y))
   (assert (trait a_piscivore n))
   (assert (trait an_arthropod n))
   (assert (trait a_legged_animal n))
   (assert (trait an_herbivore n))
   (assert (trait an_animal_which_lives_underwater n))
   (assert (trait a_carnivore n))
)

(defrule is-a-piscivore-then
   (declare (salience 10))
   (trait a_piscivore y)
 =>
   (assert (trait a_mammal n))
   (assert (trait heavier_than_a_table n))
   (assert (trait an_omnivore n))
   (assert (trait an_arthropod n))
   (assert (trait a_legged_animal n))
   (assert (trait an_herbivore n))
   (assert (trait an_animal_which_lives_underwater n))
   (assert (trait a_carnivore n))
)

(defrule is-a-legged-animal-then
   (declare (salience 10))
   (trait a_legged_animal y)
 =>
   (assert (trait a_mammal y))
   (assert (trait heavier_than_a_table y))
   (assert (trait an_omnivore n))
   (assert (trait a_piscivore n))
   (assert (trait an_arthropod n))
   (assert (trait an_animal_which_lives_underwater n))
   (assert (trait a_carnivore n))
)

(defrule is-an-herbivore-then
   (declare (salience 10))
   (trait an_herbivore y)
 =>
   (assert (trait a_mammal y))
   (assert (trait heavier_than_a_table y))
   (assert (trait a_legged_animal y))
   (assert (trait an_omnivore n))
   (assert (trait a_carnivore n))
   (assert (trait is_piscivore n))
   (assert (trait an_animal_which_lives_underwater n))
   (assert (trait a_carnivore n))
)

(defrule is-an-animal-which-lives-underwater-then
   (declare (salience 10))
   (trait an_animal_which_lives_underwater y)
 =>
   (assert (trait a_carnivore y))
   (assert (trait a_mammal n))
   (assert (trait heavier_than_a_table n))
   (assert (trait a_legged_animal n))
   (assert (trait an_omnivore n))
   (assert (trait an_arthropod n))
   (assert (trait is_piscivore n))
   (assert (trait an_herbivore n))
)

(defrule is-a-carnivore-then
   (declare (salience 10))
   (trait a_carnivore y)
 =>
   (assert (trait a_mammal n))
   (assert (trait heavier_than_a_table n))
   (assert (trait a_legged_animal n))
   (assert (trait an_omnivore n))
   (assert (trait an_arthropod n))
   (assert (trait is_piscivore n))
   (assert (trait an_herbivore n))
   (assert (trait an_animal_which_lives_underwater y))
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