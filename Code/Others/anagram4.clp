/*
** Author: Andrew Liang
** Date of Creation: 09.28.2022
** Description: 
** this module contains functions for retrieving an input string
** checking that it is small enough for program to handle (length <= 10)
** and permutes its anagrams
** dynamically builds the anagram-permuting rule
** finally, it contains a rule to kickstart the program
*/

(clear)
(reset)
(batch "./Code/utilities_v4.clp")

(defglobal ?*MAX_LEN* = 10) ; maximum length of string that program can handle

(deftemplate Letter (slot c) (slot p)) ; represents a letter, with a character and character id

; RULES

(defrule rule-1 "Kickstarts the program by asking for input and creating the anagram, always runs first"
   (declare (salience 100))
=>
   (makeValidAnagrams)
)

; FUNCTIONS

/*
** Build a pattern for the nth character in the anagram
** 
** For the third character, function returns: (Letter (c ?c3) (p ?p3 &~?p2 &~?p1))
*/
(deffunction createPattern (?num)
   (bind ?pattern (str-cat "(Letter (c ?c" ?num ") (p ?p" ?num ))

   (for (bind ?i (- ?num 1)) (>= ?i 1) (-- ?i)
      (bind ?pattern (str-cat ?pattern " &~?p" ?i))
   )

   (return (str-cat ?pattern "))"))
)

/*
** Builds the left hand side of the rule described below
** 
** If the anagram length is 3, function returns: 
** (Letter (c ?c1) (p ?p1)) 
   (Letter (c ?c2) (p ?p2 &~?p1)) 
   (Letter (c ?c3) (p ?p3 &~?p2 &~?p1))
*/
(deffunction createLHS (?num)
   (bind ?LHS "")

   (for (bind ?i 1) (<= ?i ?num) (++ ?i)
      (bind ?LHS (str-cat ?LHS (createPattern ?i) " "))
   )

   (return ?LHS)
)

/*
** Builds the right hand side of the rule described below
** 
** If the anagram length is 3, function returns: (print (str-cat ?c1 ?c2 ?c3 ?c4" "))
*/
(deffunction createRHS (?num)
   (bind ?RHS "(printout t (str-cat ")

   (for (bind ?i 1) (<= ?i ?num) (++ ?i)
      (bind ?RHS (str-cat ?RHS "?c" ?i " "))
   )

   (bind ?RHS (str-cat ?RHS ") crlf)"))

   (return ?RHS)
)

/*
** Given a number n, build a rule which permutes all anagrams of length n
** 
** Example of length 3:
** (defrule anagram-rule 
      (Letter (c ?c1) (p ?p1)) 
      (Letter (c ?c2) (p ?p2 &~?p1)) 
      (Letter (c ?c3) (p ?p3 &~?p2 &~?p1))
   =>
      (print (str-cat ?c1 ?c2 ?c3" "))
   )
*/
(deffunction createCorrectLengthRule (?num)
   (bind ?ruleStatement "(defrule anagram-rule ")
   (bind ?ruleStatement (str-cat ?ruleStatement (createLHS ?num) " "))
   (bind ?ruleStatement (str-cat ?ruleStatement "=> "))
   (bind ?ruleStatement (str-cat ?ruleStatement (createRHS ?num) " "))
   (bind ?ruleStatement (str-cat ?ruleStatement ")"))

   (return ?ruleStatement)
)

/*
** asserts a Letter fact given a letter and a position
*/
(deffunction assertLetter (?letter ?position)
   (assert (Letter (c ?letter) (p ?position)))

   (return)
)

/*
** takes in a list of characters and asserts each of them as a Letter fact
*/
(deffunction makeFacts (?charList)

   (for (bind ?i 1) (<= ?i (length$ ?charList)) (++ ?i)
      (assertLetter (nth$ ?i ?charList) ?i)
   )

   (return)
)

/*
** This function takes in a string and explodes all characters into a list
*/
(deffunction slice$ (?str)
   (bind ?ans (create$))

   (for (bind ?i 1) (<= ?i (str-length ?str)) (++ ?i)
      (bind ?ans (create$ ?ans (sub-string ?i ?i ?str)))                                    ; loops over 
   )

   (return ?ans)
)

/*
** This function repeatedly asks the user for an input 
** until it reads a string of length <= 10
*/
(deffunction getValidInput ()
   (printline (str-cat "please input a word of length no greater than " ?*MAX_LEN*))
   (bind ?str (read t))

   (while (> (str-length ?str) ?*MAX_LEN*)
      (printline "string length wasn't correct >:(")
      (bind ?str (read t))
   )

   (return ?str)
)

/*
** This function asks for an input string and permutes its possible anagrams
*/
(deffunction makeValidAnagrams ()
   (bind ?charList (slice$ (getValidInput)))
   (makeFacts ?charList)
   (build (createCorrectLengthRule (length$ ?charList)))
   (return)
)