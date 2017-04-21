---
layout: post
title:  Optimization notes
date:   2017-04-21 
categories: optimization notes
---

This article is a result of an investigation I conducted over the optimization literature.
As a researcher in networking I rely often on optimization techniques and I need to understand them in depth.
So far, I have not found any textbook or article which I fully like so I decided to write one myself.
This text represents what I wanted to read when I started studying optimization and it is intended to constitute a reminder for the future.

$$
\newcommand{\st}{\text{subject to}}
\newcommand{\openopt}{\begin{aligned}}
\newcommand{\closeopt}{\end{aligned}}
$$

### The Problem (a.k.a. primal)
The formulation of an optimization problem can be given, without loss of generality, as:

$$
\label{primal}
\openopt
& \min_x & &  f(x) \\
& \st & & g_i(x) \leq 0, \forall i
\closeopt
$$

To ease the notation, where not specified, $$x\in \mathbb{R}, i\in \mathbb{N} \cap [1,m]$$.
We assume that $$f(x), g_i(x)\in C^1 \forall i$$, i.e., they are linear and continuously differentiable over our dominion.
We also assume that $$f(x), g_i(x) \forall i$$ are convex functions. This is a quite strong assumption but without this convexity property (which grants there are not local minima) solution gets way more complex.
We need convexity on $$g_i(x)$$ for the reason explained in the _Lagrangian relaxation_ section.

---
**NOTE:**
If $$f(x), g_i(x)$$ are linear and all your original constraints were equalities (but for the range $$x\geq 0$$), you may think to solve it using the simplex method. Simplex method does not provide all the optimal solutions (in general) but it works with standard algebraic solvers.

---

The previous problem optimization is quite powerful from the representation point of views; in fact we can transform:
 * a maximization problem: $$\max_x f(x) =  - \min_x -f(x)$$;
 * an inequality constraint: $$ h_i(x) \geq 0 \iff -h_i(x) \leq 0 $$;
 * an equality constraint: $$ h_i(x) = 0 \iff -h_i(x) \leq 0, h_i(x) \leq 0 $$;
 * variable dominion constraints, such as $$x\geq 0$$ can be interpreted as $$g_i(x) \leq 0$$.

Textbooks usually keep the distinction between equalities and inequalities for a reason will be presented in the _the special case of equalities_ section.


### The Lagrangian Relaxation
This section presents the idea behind the Lagrangian relaxation: get rid of the constraints (or at least of some of them).
Solving primal problem most of the time is hard exactly for the presence of the constraints.
However, consider this one-constrain toy example:

$$
\openopt
& \min_x & &  f(x) \\
& \st & & g(x) \leq 0 
\closeopt
$$

We have that, for any scalar $$\lambda \in \mathbb{R}_+$$ that is large enough, 

$$
\openopt
\label{relaxed}
& \min_x & &  f(x) &\geq &  \min_x & &f(x) + \lambda g(x)\\
& \st & & g(x) \leq 0 
\closeopt
$$

In fact, the value of $$g(x)$$ impacts on the minimization problem, privileging the values of $$x$$ which makes $$g(x) < 0$$.
The role of $$\lambda$$ is amplifying this effect.

We call the Lagrangian function: $$L(x,\lambda) = f(x) + \sum_i \lambda_i g_i(x)$$.
In general, we have $$L(x^*,\lambda) \leq f(x^*) + \sum_i \lambda_i g_i(x^*), \forall \lambda \in \mathbb{R}_+^n$$.

It is worth noticing, if $$f(x), g_i(x)$$ are convex (as anticipated in the _problem_ section) then $$L(x, \lambda)$$ is convex.


#### The special case of equalities
Suppose your original problem is

$$
\openopt
& \min_x & &  f(x) \\
& \st & & g(x) = 0
\closeopt
$$

which you port to our standard form of:

$$
\openopt
& \min_x & &  f(x) \\
& \st & & g(x) \leq 0 \\
&  & & -g(x) \leq 0
\closeopt
$$

Now the Lagrange function is: 
$$L(x, \lambda_1, \lambda_2) = f(x) + \lambda_1 g(x) -\lambda_2 g(x) = f(x) + (\lambda_1 - \lambda_2)g(x)$$ with $$\lambda_1, \lambda_2 \geq 0$$
If we now define $$\mu = \lambda_1 - \lambda_2$$ we can than rewrite it as:
$$L(x, \mu) = f(x) + \mu g(x) $$ 
But now $$\mu \in \mathbb{R}$$ and it is not anymore constrained to positive values.

### Optimum lower bound (a.k.a. dual)

Starting from the Lagrangian relaxation we can go further and there is an equivalence result stating:
$$
\openopt
\label{dual}
& \min_x & &  f(x) & = &   & \max_\lambda \min_x L(x, \lambda) \\
& \st & & g_i(x) \leq 0, \forall i
\closeopt
$$

#### Dual of a linear problem
It is worth noticing that it can be possible to represent $$x$$ through some constraints and remove it from the objective function; e.g.:

$$
\openopt
& \min_x & &  c^Tx \\
& \st & & Ax - b = 0 \\
&  & & x \geq 0 
\closeopt
$$

has $$L(x, \mu, \lambda) = c^Tx \sum_j \lambda_j(-x_j) + \sum_i \mu_i(a_i^Tx - b_i) = -b^T\mu + (c +A^T\mu - \lambda)^Tx$$.
But minimizing $$L(x, \mu, \lambda)$$ would have not lower bound if $$(c +A^T\mu - \lambda) \neq 0$$.

So we can introduce this constraint and our problem becomes:

$$
\openopt
& \max_{\lambda,\mu} \min_x & &  -b^T\mu + (c +A^T\mu - \lambda)^Tx\\
& \st & & c +A^T\mu - \lambda= 0 \\
&  & & \lambda \geq 0 
\closeopt
$$

Which is obviously equal to:

$$
\openopt
& \max_{\mu} & &  -b^T\mu \\
& \st & & c +A^T\mu - \lambda= 0 \\
&  & & \lambda \geq 0 
\closeopt
$$

And, since $$\lambda \geq 0$$ and picking a new variable $$\eta = -\mu$$:

$$
\openopt
& \max_{\eta} & &  b^T\eta \\
& \st & & c +A^T\eta \leq 0 
\closeopt
$$

---
**NOTE:**
If you have a linear problem with $$n$$ variables and $$m << n$$ constraints, it is computationally convenient to solve the dual problem (with the dual-simplex), as it will have $$m$$ variables and $$n$$ constraints.

---


### The Lagrangian and KKT Theorems
The nice thing about a Lagrangian relaxation is that the minimization objective becomes finding the minimum of a function (no constraints anymore).
In the introductory courses of analysis, they teach to use derivates to find the extrema of a given function.
In our case we use the gradient but it is quite similar.

**Theorem (Lagrange):**
The Langrange theorem states that if $$x^*$$ is a optimum for $$f(x)$$, all the constraints are expressed with equalities and it holds the _Linearly Independence Constraint Qualification (LICQ)_ (i.e., rank$$(\nabla g(x^*)) = m$$), then it exists $$\lambda^*$$:

$$ \nabla L(x^*, \lambda^*) = 0$$

We can use this theorem to solve analytically with only equality constraints:
 1. find $$M=\{(x,\lambda) : \nabla L(x^*, \lambda^*) = 0\}$$
 2. evaluate $$f(x) \forall x: \exists \lambda \text{ such that } (x,\lambda)\in M$$

**Theorem (KKT):**
The KKT theorem states that, given a problem in the form of primal for which it holds the LICQ; let $$\cal{E},\cal{I}$$ be the index sets of the equality and inequality constraints respectively, if $$x^*$$ is a minimum then:
 * <span/>$$\nabla L(x^*, \lambda^*) = 0$$
 * <span/>$$\lambda_i^*g_i(x^*) = 0\forall i \in \cal{E}\cup \cal{I}$$
 * <span/>$$\lambda_i^*\geq 0\forall i \in \cal{I}$$

The main difference between Lagrange theorem and the KKT theorem is that the latter has to carefully handle the inequalities constraints; in particular it requires that, if a constraint is _active_, $$g_i(x^*)<0$$ than $$\lambda^*=0$$. Otherwise, we would have
$$L(x^*,\lambda^*) = f(x^*) + \sum_i \lambda_i^* g_i(x^*) \neq f(x^*) $$


Both Lagrange and KKT theorems provide _necessary_ conditions for optimality, hence once got a set of critical points candidate to be optima we have to test them against the primal objective function and constraints.

### Bonus: Solving a linear dual with the subgradient method
In general we can solve it via a cutting plane or tangential approximation approaches to recover both primal and dual solution.

However, if our problem is linear (i.e., $$f(x)$$ and $$g_i(x)$$ are linear) we can use the subgradient method.
The subgradient algorithm is a method to maximize (minimize) a function using only very few assumptions.
Suppose you want to maximize $$f(x)$$, then chosen an particular sequence $$\{a_k\}$$, you iterate over $$k=1,\dots,N$$:

 1. <span/>$$x_{k+1} = x_k + a_k g(f, x_k)$$
 2. <span/>if $$\parallel  x_{k+1} - x_k \parallel > \epsilon $$ then $$k=k+1$$ and return to step 1

where $$g(f, x_k)$$ is the _subgradient_ of $$f(x)$$ computed in $$(x_k)$$. 
If $$f(x)\in C^1$$ then $$g(f, x_k) = \nabla f(x_k)$$.

It is important to choose carefully $$\{a_k\}$$ so that the method converges.
Several alternatives have been published, among others these properties grant the convergence:

 * <span/>$$a_k \geq 0 \forall k$$
 * <span/>$$\lim_{k\to \infty} a_k = 0$$
 * <span/>$$\sum_{k=1}^{\infty} a_k = \infty$$

A practical choice can be $$a_k = \frac{a}{b+ck}$$ for some $$a>0,\ c>0,\ b\geq 0$$.


Hence, solving a dual problem in the form of the dual, becomes:
 1. <span/>Choose $$\epsilon,\lambda_0$$, set $$k=0$$
 2. <span/>$$x_k = \arg\min_x L(x, \lambda_{k})$$
 3. <span/>$$\lambda_{k+1} = \max(0, \lambda_{k} + a_k\nabla_{\lambda} L(x_k, \lambda))$$
 4. <span/>if $$|\lambda_{k+1} - \lambda_k | > \epsilon$$ then $$k=k+1$$ and return to step 2
Sherali et al. proved that in our context, final result is distorted but we can reconstruct it:

$$x^* = \sum_{j=1}^{k+1} \frac{x_k}{k}$$

Recall that the constraint $$\lambda[k]\geq 0$$ imposed by step 3 is needed if and only if $$\lambda$$ is associated to an inequality constraint.
