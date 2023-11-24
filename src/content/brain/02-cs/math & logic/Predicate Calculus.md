---
title: "Predicate Calculus"
---

# Simple and Composed Open Sentences

## Open Sentence and Proposition

- $P:$ Filipe is a CSS student (proposition)
- $p(x): x^2 - 5x + 6 = 0$ (open sentence)

The open sentence is a functional proposition, i.e., it is a proposition that depends on a variable, so by that I cannot say if it is true or false, unlike a normal proposition.

### Universal Set

Universal set, Universe, or Domain of Discourse is the set of all possible values for the variable.

i.e., 

- $x + 15 = 8$
- $x = -7$ (truth value)
- $x \in \mathbb{U}$ and $\mathbb{U} = \mathbb{R}$

### Truth Set

The truth set is the set of all values that make the open sentence true. Following the latest example, the truth set is:

- $T_p = \{-7\}$
- Notation: $T_p = x | x \in \mathbb{U} \land p(x) = T$
- This $\mathbb{U}$ is scoped, so it the universal set might have different possible values depending on the sentence.

**What if the sentence has more than one variable?**

i.e., $p(x, y): x^2 + y^2 = 1$

- $T_p = \{(0, 1), (0, -1), (1, 0), (-1, 0)\}$
- Notation: $T_p = \{(x, y) | x \in \mathbb{U} \land y \in \mathbb{U} \land p(x, y) = T\}$

## Predicates

A predicate assigns to the subject a property or a relation.

- $p(x): x$ is a student (where $x$ is the subject, $p$ is the predicate and $p(x)$ is the proposition, **at least is how I understood it**)

## Quantified Propositions

i.e., $p(x): x^2 > 4$

- Where the universe is $\mathbb{U} = {3,4,5,6,7}$
    - $T_p = \mathbb{U}$
    - So, $\forall$ $x \in \mathbb{U}: x^2 > 4$
    - This is called a **universal quantifier** because it is true for all values of the universe
- Where the universe is $\mathbb{U} = {0,1,2,3,4}$
    - $T_p = {5}$
    - So, $\exists$ $x \in \mathbb{U}: x^2 > 4$
    - This is called a **existential quantifier** because it is true for some values of the universe
- Where the universe is $\mathbb{U} = {-1,0,1,2,3}$
    - $T_p = {3,4}$
    - So, $\exists!$ $x \in \mathbb{U}: x^2 > 4$ ($\exists!$ means that there is only one element that satisfies the proposition)
    - This is called a **unique existential quantifier** because it is true for only one value of the universe

**What if the sentence has more than one variable?**

i.e., $p(x, y): 2x + y < 11$

- Let's say that $y \in \mathbb{U}$ and $x \in \mathbb{U}$, where $\mathbb{U} = \{1,2,3,4\}$
- Notation: $(\forall$ $y \in \mathbb{U})(2x + y < 11)$
- $T_p = \emptyset$, because if $x = 6$, then it's false for every value of $y$
- We can also have **free variables**, as we gonna see right now...

## Free Variables and Bound Variables

- i.e., $S(n) = \sum\limits_{k=1}^{10} f(n, k)$
- It means that $n$ is a free variable, because it is not bounded by the $\sum$ operator
- $k$ is a bound variable, because it is bounded by the $\sum$ operator ($k$ will be a value from 1 to 10)

## Negation of Quantified Propositions

- i.e., $p(x): (\forall x \in \mathbb{R})(x^2 \geq 0)$
- $\neg p(x): (\exists x \in \mathbb{R})(x^2 < 0)$

---------------

Doesn't take too much to understand the obvious importance of those topics for programming, anybody that has ever programmed in any language can make parallels with the topics presented and programming concepts.
