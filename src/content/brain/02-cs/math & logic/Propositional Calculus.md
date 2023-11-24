---
title: "Propositional Calculus"
---

## Composed and Simple Propositions

- A **proposition** is a statement that is either true or false.
- A **simple proposition** is a proposition that is not composed of other propositions.
- A **composed proposition** is a proposition that is composed of other propositions.
    - Notation: $P(p, q, r, ...)$
- Symbols:
    - ~ or $\neg$ (negation)
    - $\land$ (conjunction)
    - $\lor$ (disjunction)
    - $\veebar$ or $\oplus$ (exclusive or)
    - $\rightarrow$ (implication)
    - $\leftrightarrow$ (biconditional)
    - $\uparrow$ (nand - not and)
    - $\downarrow$ (nor - not or)

## Aristotle's Logic

- Syllogism: A form of deductive reasoning consisting of a **major premise, a minor premise, and a conclusion**.
    - Ex: *"Every man is mortal. Socrates is a man. Therefore, Socrates is mortal."*

# Truth Tables

## Simple Proposition

| $p$ |
| --- |
| T   |
| F   |

## Composed Proposition

| $p$ | $q$ |
| --- | --- |
| T   | T   |
| T   | F   |
| F   | T   |
| F   | F   |

## Example

$$
\underbrace{\left(\underbrace{p \land q}_{T}\right) \rightarrow
\left(\underbrace{\underbrace{\neg q}_{F} \rightarrow \underbrace{p}_{T}}_{T}\right)}_{T}
$$

***And the truth table:***

| $p$ | $q$ | $p \land q$ | $\neg q$ | $\neg q \rightarrow p$ | $p \land q \rightarrow (\neg q \rightarrow p)$  |
| --- | --- | ----------- | -------- | ---------------------- | ----------------------------------------------- |
| T   | T   | T           | F        | T                      | T                                               |
| T   | F   | F           | T        | T                      | T                                               |
| F   | T   | F           | F        | T                      | T                                               |
| F   | F   | F           | T        | F                      | T                                               |

# Introduction to Boolean Algebra

## Contradiction

- A proposition that is always false.

## Tautology

- A proposition that is always true.

## Contingency

- A proposition that is neither a tautology nor a contradiction.

## Boolean Algebra

- $T = 1$
- $F = 0$
- $\land = *$
- $\lor = +$
- $\neg x = \overline{x}$

## Example

| $p$ | $q$ | $\overline{p}$ | $\overline{p} + q$ |
| --- | --- | -------------- | ------------------ |
| 1   | 1   | 0              | 1                  |
| 1   | 0   | 0              | 0                  |
| 0   | 1   | 1              | 1                  |
| 0   | 0   | 1              | 1                  |

# Logical Implication, Logical Equivalence and Inference Rules

- **Logical Implication**: $p \land q \Rightarrow p \lor q$
- **Logical Equivalence**: $p \land q \Leftrightarrow p \lor q$

## Inference Rules:

- *Modus Ponens*: 
$$
\underbrace{p \rightarrow q}_{T} \land \underbrace{p}_{T} \therefore \underbrace{q}_{T}
$$
- *Modus Tollens*:
$$
\underbrace{p \rightarrow q}_{T} \land \underbrace{\neg q}_{T} \therefore \underbrace{\neg p}_{T}
$$
- *Hypothetical Syllogism*:
$$
\underbrace{p \rightarrow q}_{T} \land \underbrace{q \rightarrow r}_{T} \therefore \underbrace{p \rightarrow r}_{T}
$$
- *Disjunctive Syllogism*:
$$
\underbrace{p \land q}_{T} \land \underbrace{\neg p}_{T} \therefore \underbrace{q}_{T}
$$
- etc.
