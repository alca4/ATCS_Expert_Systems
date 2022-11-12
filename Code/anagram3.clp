/*
** Author: Andrew Liang
** Date of Creation: 09.23.2022
** Description: 
** this module contains functions for retrieving an input string
** checking that it is of correct length
** and with the functions and rules in anagram2, making an anagram of the inputted string
** finally, a rule to kickstart the program
*/

(batch "./Code/anagram2.clp")

(defrule startup-rule "Kickstarts the program by asking for input and creating the anagram, always runs first"
   (declare (salience 100))
=>
   (makeValidAnagrams)
)

/*
** This function takes in a string and explodes all characters into a list
*/
(deffunction slice$ (?str)
   (bind ?ans (create$))

   (for (bind ?i 1) (<= ?i (str-length ?str)) (++ ?i)
      (bind ?ans (create$ ?ans (sub-string ?i ?i ?str)))                                        ; loops over 
   )

   (return ?ans)
)

/*
** This function repeatedly asks the user for an input until it reads a four-letter string
*/
(deffunction getValidInput ()
   (printline "please input a word of length 4")
   (bind ?str (read t))

   (while (neq (str-length ?str) 4)
      (printline "string length wasn't correct >:(")
      (bind ?str (read t))
   )

   (return ?str)
)

/*
** This function asks for an input string of length 4 and permutes the possible anagrams
*/
(deffunction makeValidAnagrams ()
   (makeFacts (slice$ (getValidInput)))

   (return)
)

(run)