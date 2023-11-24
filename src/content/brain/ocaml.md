---
title: "My first day with OCaml"
---

## Variables

So, to declare variables we can use `let` keyword. For example:

```ocaml
let x = 1;;
```

We can also use `;;` to separate expressions. For example:

```ocaml
let x = 1;;
let y = 2;;
```

We can do something like this:

```ocaml
let x = 50 in x * x;;
```

> *Obs*: It will return `2500`. But `x` is not defined outside of `in` block. So, we can't use `x` outside of `in` block.
> If you try to print out `x` value, you will have an error.

## Functions

We can define functions with `let` keyword. For example:

```ocaml
let square x = x * x;;
```

Anonymous functions are defined with `fun` keyword. Example:

```ocaml
map (fun x -> x * 2) [1; 2; 3];;
```

### Recursion

We can do recursion with `let rec` keyword. For example:

```ocaml
let rec range a b =
    if a > b then []
    else a :: range (a + 1) b;;
```

> *Obs*: The difference between `let` and `let rec` is that if we have used `let` we couldn't use `range` function inside of `range` function, we would have an error.

## Float x Int

OCaml needs you to explicitly convert `int` to `float` and vice versa. For example:

```ocaml
let x = 1;;
let y = 2.0;;
let z = float_of_int x +. y;;
```

> *Obs*: The `+.` operator is used to sum `float` numbers. If you try to sum `int` numbers with `+.` operator, you will have an error. The same for the otherwise case.

## Pattern Matching

We can use the `match` and `with` keywords to do pattern matching. For example:

```ocaml
let rec factorial n =
    match n with
    | 0 | 1 -> 1
    | _ -> n * factorial (n - 1);;
```

> *Obs*: The `_` is used to match any value.
> We could replace the last line with `| x -> x * factorial (x - 1)`. It would be the same.
> The `x` is a variable that receives the value of `n` in the case.
> Of course `x` doesn't exist outside of the the case.

We can also simplify the pattern matching by using the `function` keyword. For example:

```ocaml
let rec factorial = function
    | 0 | 1 -> 1
    | n -> n * factorial (n - 1);;
```

> *Obs*: The `function` keyword introduces pattern matching directly.
> The parameter is not named, but we can use it in the cases (hmm).

## Lists

Lists are ordered collections of elements of the same type. For example:

```ocaml
# [];;
- : 'a list = []
# [1; 2; 3];;
- : int list = [1; 2; 3]
# [false; false; true];;
- : bool list = [false; false; true]
# [[1; 2]; [3; 4]; [5; 6]];;
- : int list list = [[1; 2]; [3; 4]; [5; 6]]
```

The `::` (cons) operator adds an element to the beginning of a list. For example:

```ocaml
# 1 :: [];;
- : int list = [1]
# 2 :: [1];;
- : int list = [2; 1]
```

The `@` (append) operator concatenates two lists. For example:

```ocaml
# [1; 2] @ [3; 4];;
- : int list = [1; 2; 3; 4]
```

Non-empty lists have a `head` (it's first element) and a `tail` (the list of the rest of the elements). For example:

```ocaml
# let x = [1; 2; 3];;
val x : int list = [1; 2; 3]
# List.hd x;;
- : int = 1
# List.tl x;;
- : int list = [2; 3]
```

We can create functions that operates over lists using pattern matching. For example:

```ocaml
# let rec total l =
    match l with
    | [] -> 0
    | h :: t -> h + total t;;
val total : int list -> int = <fun>
# total [1; 3; 5; 3; 1];;
- : int = 13
```

> *Obs*: The `h` is the head and the `t` is the tail. We use the `::` operator to desconstruct here.

Another example:

```ocaml
let rec length l =
    match l with
    | [] -> 0
    | _ :: t -> 1 + length t;;
```

> *Obs*: This function will not operate just a list of integers as the latest example, it'll operates lists of any types.
> So the list in the parameter is of type `'a list` (pronounced **alpha list**), and the function is called **polymorphic** since the type isn't relevant.

Let's write a `map` function that will take a function and a list as parameters and will apply the function to every element of the list and return results, just like a map:

```ocaml
let rec map f l = 
    match l with
    | [] -> []
    | h :: t -> f h :: map f t;;
```

Example of usage (using the `total` function we've created before):

```ocaml
# total;;
- : int list -> int = <fun>
# map total [[1; 2]; [3; 4]; [5; 6]];;
- : int list = [3; 7; 11]
# map total [1; 2; 4];;
Error: This expression has type int but an expression was expected of type
         int list
```

> *Obs*: The reason the second returns an error is because total returns `int` and `map` should return a `list`, that's why in the first one we passed a `list` of `lists`, so for each list `total` returned an `int` and the `map` function returned and `list` of `ints`;

Example using anonymous function:

```ocaml
map (fun x -> x * 2) [1; 2; 3];;
```

### Partial Application

We can apply a function passing only some of it's parameters. For example:

```ocaml
let add x y = x + y;;
let add1 = add 1;;
add1 2;;
- : int = 3
```

Let's use it with our map function:

```ocaml
map (add 1) [1; 2; 3];;
- : int list = [2; 3; 4]
```

or let's use partial application of map function:

```ocaml
# map (map (add 1)) [[1; 2]; [3; 4]; [5; 6]];;
- : int list list = [[2; 3]; [4; 5]; [6; 7]]
# map (map total) [[[1; 2]; [1; 2]]; [[1; 2]; [1; 2]]];;
- : int list list = [[3; 3]; [3; 3]]
```

## Tuples

Tuples are ordered collections of elements of different types. For example:

```ocaml
- let t = (1, "okay", '1');;
val t : int * string * char = (1, "okay", '1')
```

## Records

They're similar to tuples, but instead of having elements in a fixed order, they have named elements:

```ocaml
type person =
    {name: string;
    age: int};;
let frank =
    {name: "frank";
    age: 21};;
let age = frank.age;;
```

## Exceptions

Use `raise` keyword to throw exceptions, example:

```ocaml
let f a b =
    if b = 0 then raise (E2 "division by zero") else a / b;;
```

Built-in polymorphic `option` type:

```ocaml
type 'a option = None | Some of 'a;;
```

We may write:

```ocaml
let f a b =
    if b = 0 then None else Some (a / b);;
```

## Imperative OCaml

We use `ref` keyword to create references:

```ocaml
let r = ref 0;;
```

We use `:=` operator to assign a value to the reference:

```ocaml
r := 100;;
```

We use `!` operator to de-reference so we can get the reference contents:

```ocaml
# !r;;
- : int = 100
```

## Loops

For loop:

```ocaml
# let table n =
    for row = 1 to n do
      for column = 1 to n do
        print_string (string_of_int (row * column));
        print_string " "
      done;
      print_newline ()
    done;;
val table : int -> unit = <fun>
```

While loop:

```ocaml
# let smallest_power_of_two x =
    let t = ref 1 in
      while !t < x do
        t := !t * 2
      done;
      !t;;
val smallest_power_of_two : int -> int = <fun>
```

## Arrays

OCaml does have arrays, like:

```ocaml
# let arr = [|1; 2; 3|];;
val arr : int array = [|1; 2; 3|]
# arr.(0);;
- : int = 1
# arr.(0) <- 0;;
- : unit = ()
# arr;;
- : int array = [|0; 2; 3|]
```

## Standard Libraries

Printf module:

```ocaml
let print_length s =
    Printf.printf "%s has %i characters\n" s (String.length s);;
```
