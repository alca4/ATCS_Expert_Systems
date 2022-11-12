/*
** January 18, 2019
** Dr. Eric R. Nelson
**
** Small collection of JESSS utilities for ATCS:Expert Systems
**
** print       - prints any argument
** printline   - print followed by a newline
** ask         - prompt the user and read back a token
** askline     - prompt the user and read back a line of text (a string)
** askQuestion - adds a question mark to the prompt used in ask
** toChar      - given an ASCII integer value, returns the ASCII character as a string
** asciiList$  - Returns a mixed list of symbols/tokens for the ASCII character set that JESS understands.
** asciiToChar - Returns the value from asciiList$ for the number passed to the function 
** boolp       - Test for boolean type
** xor         - Exclusive-OR for two boolean values
** append$     - Appends stuff to a list
** Fix casting a long to a long crash
*/

/*
** Function that prints out a prompt (it's just a bit shorter than using (printout t "text")
*/
(deffunction print (?arg)
   (printout t ?arg)
   (return)
)

/*
** print with a new-line at the end
*/
(deffunction printline (?arg)
   (print ?arg)
   (printout t crlf)
   (return)
)

/*
** ask the user for input and return a token
*/
(deffunction ask (?arg)
   (print ?arg)
   (return (read))
)

/*
** Same as ask but returns a string of text
*/
(deffunction askline (?arg)
   (print ?arg)
   (return (readline))
)

/*
** Appends a question mark to the prompt of the ask function
*/ 
(deffunction askQuestion (?arg)
   (print ?arg)
   (return (ask "? "))
)

/*
** This function returns the character given a number.
** The format function is just printf() in C, but unlike printout this function returns the output,
** so if you use a nil router you don't get a printout, just the return value. A thanks goes to Henry W. for finding this out.
*/
(deffunction toChar (?ascii)
   (return (format nil "%c" (integer ?ascii)))
)


/*
** returns a mixed-type list of the ascii characters understood by JESS
** Control characters are represented as tokes such as NUL CR LF
** Printable characters are represented as strings
*/
(deffunction asciiList$ ()
   (return (create$
            NUL SOH STX ETX EOT ENQ ACK BEL BS TAB LF VT FF CR SO SI DLE DC1 DC2 DC3 DC4 NAK SYN ETB CAN EM SUB ESC FS GS RS US
            " " "!" "\"" "#" "$" "%" "&" "'" "(" ")" "*" "+" "," "-" "." "/"
            "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"
            ":" ";" "<" "=" ">" "?" "@"
            "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
            "[" "\\" "]" "^" "_" "`"
            "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
            "{" "|" "}" "~" DEL
            "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" ""                   ; 128 - 160
            "¡" "¢" "£" "¤" "¥" "¦" "§" "¨" "©" "ª" "«" "¬" "­" "®" "¯" "°" "±" "²" "³" "´" "µ" "¶" "·" "¸"
            "¹" "º" "»" "¼" "½" "¾" "¿" "À" "Á" "Â" "Ã" "Ä" "Å" "Æ" "Ç" "È" "É" "Ê" "Ë" "Ì" "Í" "Î" "Ï" "Ð" "Ñ" "Ò" "Ó" "Ô" "Õ" "Ö" "×"
            "Ø" "Ù" "Ú" "Û" "Ü" "Ý" "Þ" "ß" "à" "á" "â" "ã" "ä" "å" "æ" "ç" "è" "é" "ê" "ë" "ì" "í" "î" "ï" "ð" "ñ" "ò" "ó" "ô" "õ" "ö"
            "÷" "ø" "ù" "ú" "û" "ü" "ý" "þ" "ÿ"
           ) ;create$
   ) ; return
) ; deffunction asciiList

/*
** Returns the ASCII character (as JESS understands them) for the given integer value
** Printable characters including space and TAB are returned as strings
** Control characters are returned as tokens of their code such as NUL BRK ESC
** Quotes and \ are escaped, so \" and \\ strings are returned
** If the argument is outside the range 0 to 255 then NIL is returned
** 
** Precondition: The argument must be a number. Non-integer values are simply cast as integers
**
*/
(deffunction asciiToChar (?ascii)
   (bind ?ascii (integer ?ascii))            ; don't want to crash if someone passes 64.5 for example, so just truncate

   (if (or (< ?ascii 0) (> ?ascii 255)) then ; return NIL if value is out of the range 0 to 255
      (bind ?ret NIL)
    else
      (++ ?ascii)                            ; ASCII is zero index but lists are 1 indexed
      (bind ?ret (nth$ ?ascii (asciiList$))) ; get the character from the list of available characters
   )

   (return ?ret)
) ; deffunction asciiToChar

/*
** Tests if the argument is a boolean, which can only take on the value of TRUE and FALSE 
*/
(deffunction boolp (?x)
   (return (or (eq ?x TRUE) (eq ?x FALSE)))
)

/*
** Simple exclusive-or function
** 
** Function assumes values are either TRUE or FALSE
*/
(deffunction xor (?a ?b)
   (return (and (or ?a ?b) (not (and ?a ?b))))
)

/*
** Appends stuff to the first argument, which must be a list. The other arguments can be
** anything and are all passed to this function as a list. The return value is a list that
** is the concatenation of all the arguments in the order given.
** 
*/
(deffunction append$ (?theList $?stufftoAppend)
   (bind ?loc (+ (length$ ?theList) 1))			; This is where to put the new stuff (at the end)

   (return (insert$ ?theList ?loc $?stufftoAppend))
)

/*
** Fix the casting a long to a long crash bug, e.g. (long 1L) causes a crash.
*/
(defadvice before long (if (longp (nth$ 2 $?argv)) then (return (nth$ 2 $?argv))))
