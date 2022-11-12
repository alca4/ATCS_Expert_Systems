/*
* Author: Andrew Liang
* Date of Creation: 09.02.2022
* Description:
* This module asks the user for a nonnegative integer n
* and returns the first n fibonacci numbers
*/

(batch "./Code/utilities_v3.clp")

/*
* fibo takes in a nonnegative integer n and returns the first n fibonacci numbers in a list
*/
(deffunction fibo (?a)
   (bind ?ans (create$))
   
   (for (bind ?i 1) (<= ?i ?a) (++ ?i)
   
      (if (<= ?i 2) then
         (bind ?ans (create$ ?ans 1))                                               ; f(1) = f(2) = 1
       else
         (bind ?ans (create$ ?ans (+ (nth$ (- ?i 1) ?ans) (nth$ (- ?i 2) ?ans))))   ; definition: f(n) = f(n - 1) + f(n - 2)
      )
   
   )

   (return ?ans)
)

/*
* check takes in a string and checks if it is a representation of a nonnegative integer
* returns true if input can be represented as an integer, false otherwise
*/
(deffunction check (?input)
   (bind ?ret FALSE)

   (if (and (numberp ?input) (eq* ?input (integer ?input))) then                    ; checks if input is an integer
      
      (if (>= ?input 0) then                                                        ; checks if input is nonnegative
         (bind ?ret TRUE)
      ) 

   ) 

   (return ?ret)
)

/*
* fibonacci takes in an input
* if the input is a nonnegative integer n it returns the first n fibonacci numbers
* otherwise it returns false
*/
(deffunction fibonacci (?input)
   (bind ?ret FALSE)
   
   (if (check ?input) then
      (bind ?ret (fibo ?input))
   )

   (return ?ret)
)

/*
* fib takes in an input
* if the input is interpreted as a nonnegative integer n and first n fibonacci numbers are printed
* otherwise prints "invalid input"
*/
(deffunction fib ()
   (printline "Please output a nonnegative integer: ")
   (bind ?input (read t))
   (bind ?ans (fibonacci ?input))
   
   (if (not ?ans) then
      (printline "Invalid Input")
    else
      (print "First ")
      (print (integer ?input))
      (print " fibonacci numbers: ")
      (printline ?ans)
   )
   
   (return)
)

(fib)
