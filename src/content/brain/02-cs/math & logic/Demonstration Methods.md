---
title: "Demonstration Methods"
---

# Understanding About Trivial, Direct, Indirect, and Vacuum Demonstrations

## What is a Demonstration?

A sequence of affirmations where each affirmation have to be justified by the previous affirmations.

## Direct Demonstration

- **Modus Ponens (Modus Ponendo Ponens)**: Is a deductive argument form and rule of inference.
- If $p$ is true, and $q$ is true, then $p \Rightarrow q$ is true.

## Demonstration by Contradiction or by Reduction to Absurdity

| $p$ | $q$ | $p \Rightarrow q$
|-----|-----|-----------------
| $T$ | $T$ | $T$
| $T$ | $F$ | $F$
| $F$ | $T$ | $T$
| $F$ | $F$ | $T$

If $p$ is true and $q$ is false, then $p \Rightarrow q$ is false? this is an impossible situation, meaning it leads to an absurdity.

$$
[ (p \land \neg q) \Rightarrow F ] \\
A = \mathbb{U} \texttt{ of all possible values of x} \\
\emptyset \subset A = F \\
\texttt{ but if } \emptyset \not\subset A \\
\texttt{ then, must have some } x \in \emptyset | x \not\in A \\
$$

- **But it is not possible to have $x \in \emptyset$**, since it is an absurdity.
- Then $p \Rightarrow q$ is true.

## Other Demonstrations

| $p(x) | q(x)$ | $p(x) \Rightarrow q(x)$
|-------|-------|------------------------
| $T$ | $T$   | $T$
| $T$ | $F$   | $F$
| $F$ | $T$   | $T$
| $F$ | $F$   | $T$

- **Trivial Demonstration**: $p(x) \Rightarrow q(x)$ is true for all $x \in \mathbb{U}$ where $q(x)$ is true.
- **Vacuum Demonstration**: $p(x) \Rightarrow q(x)$ is true for all $x \in \mathbb{U}$ where $p(x)$ is false.
- **Indirect Demonstration**: For an arbitrary $x \in \mathbb{U}$, if $q(x)$ is false and $p(x) \Rightarrow q(x)$ is true, then $p(x)$ is false.

## Demonstrations in Propositions with Quantifiers

- i.e. $(\forall x \in \mathbb{R}) (x^2 \geq 0)$, this is a proposition with a quantifier that is **true**, we can demonstrate it.
    - Negation: $(\exists x \in \mathbb{R}) (x^2 < 0)$
- i.e. $(\exists n \in \mathbb{N}) (2^n + 1 \texttt{ is prime})$, this is a proposition with a quantifier that is **true**, we can demonstrate it.
    - Negation: $(\forall n \in \mathbb{N}) (2^n + 1 \texttt{ is not prime})$
- i.e. $(\forall y \in \mathbb{R}) (\exists x \in \mathbb{R}) (x^2 = y)$, this is a proposition with a quantifier that is **false**, we can demonstrate it.
    - Negation: $(\exists y \in \mathbb{R}) (\forall x \in \mathbb{R}) (x^2 \neq y)$

## Principle of Induction

- i.e. $A \subset \mathbb{N}$, $1 \in A$, and $\forall n \in \mathbb{N} (n \in A \Rightarrow n + 1 \in A)$, then $A = \mathbb{N}$.
- Basically, we make a supposition that if it's true for $n$, then it is true for $n + 1$, and so on.

*I should probably make a good review of those topics...*
