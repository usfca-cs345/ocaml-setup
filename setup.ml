(* This is the library portion of our OCaml project, it provides an efficient
   implementation of the Fibonacci series *)

(* The helper keeps track of the number of steps left, and the last two
   fibonacci numbers *)
let fib n = let rec helper n fn1 fn2 =
              if n = 0 then fn1
              else helper (n - 1) (fn1 + fn2) fn1
            in helper (n - 1) 1 0
