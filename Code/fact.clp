/*
* Author: Andrew Liang
* Date of Creation: 08.25.2022
* Description:
* This module asks the user for an input and checks if the input is a nonnegative integer
* and returns the factorial of that number as a 64 bit integer (long)
*/

(batch "./Code/utilities_v3.clp")

/*
* fact takes in a long (64 bit integer) and returns its factorial
*/
(deffunction fact (?a)
   (if (<= ?a 1) then 
      (return 1)
    else 
      (return (* ?a (fact (-- ?a))))
   )
)

/*
* factorial asks the user to enter values until it receives either a nonnegative int or long
* then it prints out the factorial
* also stores and prints the number of attempts the user needed to enter the value
*/
(deffunction factorial ()
   (bind ?finished FALSE)
   (bind ?attempts 0)

   (while (not ?finished)
      (print "Please input a nonnegative integer: ")
      (bind ?num (read t))

      (if (and (numberp ?num) (not (floatp ?num))) then  ; checks if input is an integer

         (if (>= ?num 0) then                            ; checks if input is nonnegative
            (print "Answer is: ")
            (if (integerp ?num) then                     ; checks if input is an int
               (bind ?ans (fact (long ?num)))            ; if true, casts it to long and passes it to fact
             else 
               (bind ?ans (fact ?num))                   ; if false, passes the value into fact
            )                                            ; because longs cannot be recasted to longs
            (printline ?ans)
            (bind ?finished TRUE)
          else
            (printline "Invalid Input (integer was negative) >:(")
            (++ ?attempts)
         ) ; if (?num >= 0)

       else 
         (printline "Invalid Input (not an integer) >:(")
         (++ ?attempts)
      ) ; if (?num is integer or ?num is long)

   ) ; while not ?finished) 

   (print "You took ")
   (print ?attempts)
   (printline " attempts to make a valid input.")
   (if (> ?attempts 0) then
      (printline "You took a while but you got it eventually.")
    else
      (printline "Yayy!")
   )

   (return ())
)

(factorial)
