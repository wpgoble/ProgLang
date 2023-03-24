# Backus-Naur Form

Given the following properies for list-of-numbers
1. The empty list is a list-of-numbers, and
2. If l is a list-of-numbers and n is a number, then the pair `(n . l)` is a list-of-numbers

We can define this in BNF as follows:
```
<list-of-numbers> ::= ()
<list-of-numbers> ::= (<number> . <list-of-numbers>)
```

## BNF Notational Shortcuts

One can write a set of rules for a single category by writing the left-hand side and `::=` once, 
followed by all the right-hand side seoarated by the symbol `|` (vertical bar, read *or*)

```
<list-of-numbers> ::= () | (<number> . <list-of-numbers>)
```

or 

```
<list-of-numbers> ::= ()
                      (<number> . <list-of-numbers>)
```

The *Kleen star* indicates a sequence of any number of instances of whatever appears between the 
braces. This includes the posibility of no instances at all.

```
<list-of-numbers> ::= ({<number>}*)
```

A varient of the star is the *Kleen plus* which indicates a sequence of *one* or more instances.

```
<list-of-numbers> ::= () | ({<number>}+)
```

Yet another variant of the star notation is the *separated list* notation. If `<expression>` is 
a nonterminal, we write `{<expression>}*(c)` to denote a sequence of any number of instances of the 
nonterminal `<expression>` separated by the non-empty character sequence. If there are zero instances, 
we get the empty string.

```
<list-of-numbers> ::= ({<number>}*(;))

(1;2;3)
```

### Exercise 1.1

Write a syntactic derivation that proves `(-7 . (3 . ( 14 . ())))` is a list of numbers.

```
<list_of_numbers>
=> (<number> . <list_of_numbers>)
=> (<number> . (<number> . <list_of_numbers>))
=> (<number> . (<number> . (<number> . <list_of_numbers>)))
=> (<number> . (<number> . (<number> . ())))
=> (<number> . (<number> . (14 . ())))
=> (<number> . (3 . (14 . ())))
=> (-7 . (3 . (14 . ())))
```

## Other BNF definitions

Many symbol manipulation procedures are designed to operate on lits that contain only symbols and other 
similarily restricted lists. We can formalize this notaiton with these rules:

```
<s-list>            ::= ({<symbol-expression>}*)
<symbol-expression> ::= <symbol> | <s-list>
```

For example:

```
({s-list})
=> (<symbol> <s-list>)
=> (<symbol> <symbol> <s-list>)
=> (<symbol> <symbol> <symbol>)
=> (a b c)
```

A binary tree with numeric leaves and interior nodes labeled with symbols may be represented using 
three-element lists for the interior nodes.

```
<bintree> ::= <number> | (<symbol> <bintree> <bintree>)

1
2
(foo 1 2)
(bar 1 (foo 1 2))
(baz (bar 1 (foo 1 2)) (biz 4 5))
```

## Lambda Calculus

A simple mini-language that is often used to study the theory of programming languages is the *Lambda Calculus*.
This language consists only of variable references, `lambda` expressions with a single formal parameter, and 
procedure calls. We can define it with the following grammar.

```
<expression> ::= <identifier>
             ::= (lambda (<identifier>) <expression>)
             ::= (<expression> <expression>)
```

Where `<identifier>` is any symbol other than `lambda`. This grammar defines the elements of `<expression>` as Scheme 
values, so it is convenient to write programs that manipulate them.

Syntatic categories for data types in Scheme

```
<list>          ::= ({<datum>}*)
<dotted-datum>  ::= ({<datum>}+ . <datum>)
<vector>        ::= #({<datum>}*)
<datum>         ::= <number> | <symbol> | <boolean> | <string>
                ::= <list> | <dotted-datum> | <vector>
```

Consider the following syntactic derivation that proves `(#t (foo . ()) 3)` is a list.

```
<list>
=> (<datum> <datum> <datum>)
=> (<boolean> <datum> <datum>)
=> (#t <datum> <datum>)
=> (#t <dotted-datum> <datum>)
=> (#t ({<datum>}+ . <datum>) <datum>)
=> (#t (<symbol> . <datum>) <datum>)
=> (#t (foo . <datum>) <datum>)
=> (#t (foo . <list>) <datum>)
=> (#t (foo . ()) <datum>)
=> (#t (foo . ()) <number>)
=> (#t (foo . ()) 3)
```

### Exercise 1.2

Rewrite the `<datum>` grammar without using the Kleene star or plus. Then indicate the 
changes to the above derivation that are required by this revised grammar.

```
<list>         ::= ()
               ::= (<datum> . <list>)
               ::= (<datum>)

<dotted-datum> ::= (<datum> . <datum>)
```

### Exercise 1.3 

Write a syntatic derivation that proves `(a "mixed" #(bag (of . data)))` is a datum.

```
<datum>
=> <list>
=> (<datum> <datum> <datum>)
=> (<symbol> <datum> <datum>)
=> (a <datum> <datum>)
=> (a <string> <datum>)
=> (a "mixed" <datum>)
=> (a "mixed" <vector>)
=> (a "mixed" #(<datum> <datum>))
=> (a "mixed" #(<symbol> <datum>))
=> (a "mixed" #(bag <datum>))
=> (a "mixed" #(bag <dotted-datum>))
=> (a "mixed" #(bag (<datum> . <datum>)))
=> (a "mixed" #(bag (<symbol> . <datum>)))
=> (a "mixed" #(bag (of . <datum>)))
=> (a "mixed" #(bag (of . <symbol>)))
=> (a "mixed" #(bag (of . data)))
```

# Recursiverly Specified Programs

Imagine we want to define a procedure to find nonnegative powers of numbers.
`e(n, x) = x^n` where `n` is a nonnegative integer and x != 0. It is easy to 
define a sequence of procedures that compute particular powers.
e_0(x) = x^0, e_1(x) = x, e_2(x) = x^2:

```
e_0(x) = 1
e_1(x) = x * e_0(x)
e_2(x) = x * e_1(x)
e_3(x) = x * e_2(x)
```

We can eliminate the subscript by making it a parameter

```
           ( 1
e(n, x) = {
           ( x * e(n-1, x)

```
