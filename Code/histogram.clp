/*
* Author: Andrew Liang
* Date of Creation: 09.09.2022
* Description: this alphabetic histogram calculates the occurences of the letters in a paragraph
* Uppercase and Lowercase characters are considered the same letter
*/

(batch "./Code/utilities_v4.clp")

/*
* findFrequency takes in a list of chars and returns a list 
* where the value at index i represents the the number of occurences
* of the character with ascii value i
*
* the original list must only contain ascii characters
*/
(deffunction findFrequency (?chars)
   (bind ?MAX_ASCII 256) 

   (bind ?freq (create$))

   (for (bind ?i 1) (<= ?i ?MAX_ASCII) (++ ?i)
      (bind ?freq (create$ ?freq 0))
   )

   (for (bind ?i 1) (<= ?i (length$ ?chars)) (++ ?i)
      (bind ?asciiVal (asc (lowcase (nth$ ?i ?chars))))
      (bind ?freq (replace$ ?freq ?asciiVal ?asciiVal (create$ (+ (nth$ ?asciiVal ?freq) 1))))  ; increments number at asciiVal by 1
   )

   (return ?freq)
)

/*
* slice takes in a string, converts uppercase characters to lowercase,
* and explodes it into a list
*
* O(length of string)
*/
(deffunction slice$ (?str)
   (bind ?ans (create$))

   (for (bind ?i 1) (<= ?i (str-length ?str)) (++ ?i)
      (bind ?ans (create$ ?ans (sub-string ?i ?i ?str)))                                        ; loops over 
   )

   (return ?ans)
)

/*
* histo asks for a line, interprets it as a string, and prints out
* the frequency of the letters
*
* lowercase and uppercase letters are considered the same when calculating frequency
*
* input line may only contain ascii characters
*/
(deffunction histo ()
   (printline "Please insert a line (with only ascii characters :>)")
   (bind ?str (slice$ (readline t)))

   (bind ?freq (findFrequency ?str))

   (bind ?ASCII_LOWER_A 97)
   (bind ?ASCII_LOWER_Z 122)

   (for (bind ?i ?ASCII_LOWER_A) (<= ?i ?ASCII_LOWER_Z) (++ ?i)
      (printline (str-cat (toChar ?i) " appeared " (nth$ ?i ?freq) " times "))
   )

   (return)
)

(printline (histo))