/*
* Author: Andrew Liang
* Date of Creation: 09.09.2022
* Description: 
* this anagram (tries to) permute a list of characters until the program crashes
*/

(batch "./Code/utilities_v4.clp")

(clear)
(reset)

(deftemplate Letter (slot c) (slot p)) ; represents a letter, with a character and character id

(assert (Letter (c A) (p 1)))
(assert (Letter (c B) (p 2)))
(assert (Letter (c C) (p 3)))
(assert (Letter (c D) (p 4)))
(assert (Letter (c E) (p 5)))
(assert (Letter (c F) (p 6)))
(assert (Letter (c G) (p 7)))
(assert (Letter (c H) (p 8)))
(assert (Letter (c I) (p 9)))
(assert (Letter (c J) (p 10)))
(assert (Letter (c K) (p 11)))


(defrule rule-1 "Enumerates permutations of unique letters of length 11"
   (Letter (c ?c1)) 
   (Letter (c ?c2 &~?c1)) 
   (Letter (c ?c3 &~?c2 &~?c1))
   (Letter (c ?c4 &~?c3 &~?c2 &~?c1))
   (Letter (c ?c5 &~?c4 &~?c3 &~?c2 &~?c1))
   (Letter (c ?c6 &~?c5 &~?c4 &~?c3 &~?c2 &~?c1))
   (Letter (c ?c7 &~?c6 &~?c5 &~?c4 &~?c3 &~?c2 &~?c1))
   (Letter (c ?c8 &~?c7 &~?c6 &~?c5 &~?c4 &~?c3 &~?c2 &~?c1))
   (Letter (c ?c9 &~?c8 &~?c7 &~?c6 &~?c5 &~?c4 &~?c3 &~?c2 &~?c1))
   (Letter (c ?c10 &~?c9 &~?c8 &~?c7 &~?c6 &~?c5 &~?c4 &~?c3 &~?c2 &~?c1))
   (Letter (c ?c11 &~?c10 &~?c9 &~?c8 &~?c7 &~?c6 &~?c5 &~?c4 &~?c3 &~?c2 &~?c1))
=>
   (printout t ?c1 ?c2 ?c3 ?c4 ?c5 ?c6 ?c7 ?c8 ?c9 ?c10" " crlf)
)

(run)