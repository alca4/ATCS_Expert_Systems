/*
** Author: Andrew Liang
** Date of Creation: 09.23.2022
** Description: 
** this module contains a rule for permuting all four-letter anagrams
** also contains functions to assert a letter as a fact and assert all characters in a list
*/

(clear)
(reset)

(batch "./Code/utilities_v4.clp")

(deftemplate Letter (slot c) (slot p)) ; represents a letter, with a character and character id

(defrule rule-1 "Enumerates permutations of letters of length 4"
   (Letter (c ?c1) (p ?p1)) 
   (Letter (c ?c2) (p ?p2 &~?p1)) 
   (Letter (c ?c3) (p ?p3 &~?p2 &~?p1))
   (Letter (c ?c4) (p ?p4 &~?p3 &~?p2 &~?p1))
=>
   (print (str-cat ?c1 ?c2 ?c3 ?c4" "))
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