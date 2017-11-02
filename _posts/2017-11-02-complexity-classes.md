---
layout: post
title:  Complexity classes
date:   2017-11-02
categories: algorithms complexity np np-hard np-complete
---

The following notes are meant to act as a reminder for the most popular problem classes.

We indicate a generic problem with $$X$$; it can be solved through different algorithms, we indicate with $$f$$ a generic algorithm solving $$X$$. 

### Complexity class

We can classify $$f$$ with respect to the following bounds:
 * $$f\in \Omega(t(n)) \iff$$ the cost (in terms of time or memory usage) of executing $$f$$ increase faster than $$t(n)$$
 * $$f\in \Theta(t(n)) \iff$$ the cost (in terms of time or memory usage) of executing $$f$$ increase as fast as $$t(n)$$
 * $$f\in O(t(n)) \iff$$ the cost (in terms of time or memory usage) of executing $$f$$ increase slower than $$t(n)$$

If we have that $$f'\in O(f)\forall f$$ solving $$X$$ and $$f'\in \Theta(t'(n)))$$, then we say $$X$$ belongs to the complexity class of problems solvable with an algorithm with complexity $$t'(n)$$, $$X\in C_{t'(n)}$$.

Popular classes of interest include polinomial $$P$$ and exponential $$E$$.

#### Non-deterministic polynomial time class (NP)
A problem $$X$$ belongs to the class $$N\!P$$ if:
 * the faster known solving algorithm for X is not polynomial, $$X\notin P$$
 * given a solution $$s$$ for $$X$$, its correctness can be checked with a polynomial time algorithm.

### Reduction
Let's consider two problems $$X$$ and $$Y$$ with solving algorithms $$f_X,f_Y$$ respectively.
If we can use $$f_X$$ to solve $$Y$$, it means problem $$Y$$ __reduces__ to $$X$$ and, straightforwardly $$Y$$ is at most difficult as $$X$$.
One example to this scenario is given with $$X$$ the problem of multiplying two numbers and $$Y$$ the problem of computing the value of a squared number; the latter can always be solved using a solving algorithm for the former.

If we can do the same the other way round, using $$f_Y$$ to solve $$X$$, it means $$X$$ is at most difficult as $$Y$$ as well and $$X,Y$$ are said to be __equivalent__.

### Hardness and completeness
Given a problem $$X$$ and a complexity class $$C$$, if every problem $$Y\in C$$ can be reduced to $$X$$ it means that $$X$$ is hard at least as the hardest problem in $$C$$ and so we say $$X$$ is _$$C$$-hard_.

If $$X$$ is $$C$$-hard and $$X\in C$$ then $$X$$ is said to be _$$C$$-complete_.

$$\implies C\text{-hard} \supset C\text{-complete} \subseteq C $$

where last equality holds only if all problems $$Y\in C$$ are equally difficult.

### $$P$$ versus $$N\!P$$
While it is pretty straightforward that $$N\!P \supseteq P$$, nor the equality or the proper (strict) inclusion have never been proved.
Thus, we only have:

$$ N\!P\text{-hard} \supset N\!P\text{-complete} \supseteq N\!P \supseteq P$$

Leaving the hypothesis $$N\!P = P$$ still not contradicted.
