open Setup

(* helper to run fib and check the result *)

let check_fib n f_n () = Alcotest.(check int) "fib" f_n (fib n) ;;

let open Alcotest in
    (* test cases that use check_fib above *)
    let test_fib n f_n = test_case ("fib " ^ string_of_int n) `Quick (check_fib n f_n) in
    (* test suite *)
    run "setup" [
        (* test *)
        "fib correctness", [
          (* test cases *)
          test_fib 1 1 ;
          test_fib 2 1 ;
          test_fib 3 2 ;
          test_fib 4 3 ;
          test_fib 5 5 ;
          test_fib 6 8 ;
          test_fib 7 13 ;
          test_fib 8 21 ;
          (* larger cases *)
          test_fib 30 832040
        ]
      ]
