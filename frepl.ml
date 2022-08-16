(* This is the main executable, it provies a REPL to call the fibonacci function *)

open Setup
open Format

let rec repl () =
    match LNoise.linenoise "> " with (*read*)
    | None -> ()
    | Some l -> begin
        LNoise.history_add l |> ignore;
        match int_of_string_opt l with
          None -> printf "'%s' is not a well-formatted integer\n%!" l
         |Some n when n < 1 -> printf "Fibonacci series is defined only for positive integers\n%!"
         |Some n -> printf "fib %n = %n\n%!" n (fib n) (*eval + print*)
      end
    ;
      repl () (*loop*)
  ;;

begin
  (* repl mode *)
  printf "Welcome to frepl, your friendly neighborhood Fibonacci repl!\n%!";
  LNoise.history_set ~max_length:100 |> ignore;
  repl ()
end
