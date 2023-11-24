---
title: "Sets Theory and Count Principles"
---

## Set Representation

One of the ways to represent:

$A = \{ n1, n2, n3 ... n \}$ ***--> Infinite Set***

$B = \{ n2, n3 \}$ ***--> Finite Set***

We can say so that:

- **Belongs to**: $n1 \in N$
- **Does not belong to**: $x \notin N$
- **Subset / Supset**: $B \subset A$ or $A \supset B$
- **Union**: $A \cup \{ x \}$
- **Intersection**: $A \cap B = B$

Symbols:

- ***Empty Set: $\emptyset$*** or ***$\{\}$***
- ***$\Leftrightarrow$ means "if and only if" in logic.***
- ***$\lor$ means "or" in logic.***
- ***$\land$ means "and" in logic.***

## Brief Explanation of Progressions

Aritmetic Progression: a1, a2, a3 ... an

Formula: an = a1 + (n - 1) * r
a1 = first element
n = position we want to know
r = ratio

This is not very relevant besides the result of progressions can be defined as sets.

So I basically just learned something and inserted here to not forget :P

## Implicit Sets Representation

$A = \{ x | p(x) \}$

Basically, it means that A is a set of all x that satisfies the property p(x).

***Example:***

$A = \{ x | x^2 = 9 \}$

- So, the only values that elevates to 2 and results in 9 are 3 and -3. Then, the solution in steps is:

$x^2 = 9 \Leftrightarrow x^2 - 9 = 0 \Leftrightarrow (x - 3)(x + 3) = 0$ ***[notable product]***

- ***The product of two numbers is zero if and only if one of them is zero.***

So, $(x - 3)(x + 3) = 0 \Leftrightarrow x - 3 = 0 \lor x + 3 = 0 \Leftrightarrow x = 3 \lor x = -3$

Result: $A = \{ 3, -3 \}$

- ***$x^2 -9 = 0$ is a quadratic equation. So we could also use the Bhaskara's Formula to solve it.***

***Example 2:***

$B = \{ x \in \mathbb{Z} | x^2 = 9 \}$

- Only difference is that we are saying that x is an integer. We do it before the pipe.

Result: $B = \{ 3, -3 \}$

## Empty Set

It's valid to say that $\emptyset \subset X$ for any set *X*.

## Numerical Sets

- ***Natual Numbers ( $\mathbb{N}$ )***: $\{ 1, 2, 3, ... \}$
    - *Some authors include 0 in the set of natural numbers and others don't.*
- ***Integers ( $\mathbb{Z}$ )***: $\{ ..., -2, -1, 0, 1, 2, ... \}$
- ***Rational Numbers ( $\mathbb{Q}$ )***: $\{ \frac{p}{q} | p, q \in \mathbb{Z} \land q \neq 0 \}$
    - *$p$ is the numerator and $q$ is the denominator.*
    - Every $x \in \mathbb{Q}$ can be represented as a fraction.
- ***Real Numbers ( $\mathbb{R}$ )***: $\{ x | x \in \mathbb{Q} \lor x \notin \mathbb{Q} \}$
- ***Irrational Numbers ( $\mathbb{R} - \mathbb{Q}$ )***: $\{ x | x \notin \mathbb{Q} \}$
    - *Irrational numbers are real numbers that cannot be represented as a fraction, because their decimal part is infinite and non-repeating.*
    - *Example: $\pi$*

## Interval Sets

- *We can represent numbers as a line, where each point is a $x$ that $\in \mathbb{R}$.*
- *So we can represent sets of numbers as intervals between points in the line.*

***Example:***

$\{x \in \mathbb{R} | a < x < b\}$

- *This set represents all real numbers between $a$ and $b$, being $a$ and $b$ excluded.*

***Example 2:***

$\{x \in \mathbb{R} | x \geq a\}$

- *This set represents all real numbers greater than or equal to $a$. It's the same as $[a, +\infty)$ (other representation form).*

## Absolute Value

We can relate algebraic representations with geometric representations with the concept of axies in a cartesian plane.

- *Example, we have $|x - 1| = 3$, that means the distance between x and 1 corresponds to 3 units. The solution is a set of the possible X values, as we see below:*

$S = \{4, -2\}$

## Operations Between Sets

### Venn Diagrams

- *The logic is simple: Basically we have a $U$ set called universe and all the sets in the operaton must be a subset of $U$.*

By that we can have:

- *$U - X = X'$ ($X'$ is the complementary set of $x$, meaning is what it needs to be equal to $U$)*

Notation for operatons:

- All basic stuff, ex: $A \cap B = \{ x \in U | x \in A \land x \in B \}$, and etc, etc.

## Multiplication Principle

### Factorial

- *Formula: $n! = n * (n - 1) * (n - 2) * ... * 1$*
- *Conventions: $0! = 1$*
- **Note that the product of consecutive integers can be represented as a factorial.**
    - Ex: $10 * 11 * 12 * 13 * 14 = \frac{9!}{9!} * 10 * 11 * 12 * 13 * 14 = \frac{14!}{9!}$

### Arrangements

- *Formula: $A_{n}^{p} = \frac{n!}{(n - p)!}$*
    - Ex (10 objects for 3 piles): $10 * 9 * 8 = \frac{10!}{(10 - 3)!} = \frac{10!}{7!} = 10 * 9 * 8 = 720$

#### Permutation

- *Particular arrangement case where $p = n$*
- *Formula: $A_{n}^{n} = P_{n} = n!$
- *A good example of it are anagrams.*

#### Combination

- ***Ordination doesn't matter.***
    - Ex. with sets: $\{a, b\} = \{b, a\}$
- *Formula: $C_{p}^{n} = \frac{A_{p}^{n}}{p!} = \frac{n!}{(n-p)!p!}$*
- ***Basically we divide by $p!$ the permutation result to eliminate the repetitions/copies of sets.***

#### With Repetition

- *Formula: $AR_{p}^{n} = n * n * ... * n = n^p$*

##### Permutation With Repetition

- *Formula: $AR_{p, q, ... t}^{n} = \frac{n!}{p! * q! * ... * t!}$*
    - Ex. The anagram of the word ARARAQUARA: $AR_{5, 3}^{10} = \frac{10!}{5!*3!} = 7 * 8 * 9 * 10 = 5040$
        - 5 is the number of times A appears in the word
        - 3 is the number of times R appears in the word
        - **If you trade positions between these letters, you will end up with the same anagram.**

###### Circular Permutation

- *Formula: $PC_{n} = \frac{n!}{n} = (n - 1)!$

##### Combination With Repetition

- *Formula: $CR_{p}^{n} = PR_{n, p - 1}^{n + p - 1}$*
    - Ex. 3 types, 8 items:
        - $CR_{3}^{8} = PR_{8, 2}^{10} = \frac{10!}{8! * 2!} = 45$