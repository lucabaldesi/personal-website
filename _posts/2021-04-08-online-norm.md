---
layout: post
title:  On the on-line data mean/variance computation
date:   2021-04-08
categories: statistics science research AI
---

Sometimes it is not possible to compute the mean and variance on the whole dataset; in machine learning you often need to normalize data that cannot fit in RAM.
To compute mean and standard deviation on chunked data, we need some adapted formulas.

### The problem
Our dataset in composed on chunks $$c_k,\ k=1,\dots$$; each chunk is made up of elements $$a_i^{(k)},\ i=1,\dots,n^{(k)}$$ (note we do not assume all chunks to have the same length).
Our goal is to compute the mean and variance of all the elements $$a_i^{(k)},\ i=1,\dots,n^{(k)};k=1,\dots,T$$, where $$T$$ is the last chunk received.
However, we cannot directly compute the mean and variance on the elements $$a_i^{(k)}$$ as they cannot reside in memory at the same time.

### Basic fomulas
Given an ordered set $$a_1,\dots,a_n$$ we define:

 * the sample mean, $$\bar{a} = \frac{\sum_i^n a_i}{n}$$
 * the sample variance, $$\hat{a} = \frac{\sum_i^n (a_i-\bar{a})^2}{n-1}$$

We note that:
$$\hat{a} = \frac{\sum_i^n a_i^2 -\sum_i^n2a_i\bar{a}+\sum_i^n\bar{a}^2}{n-1} = \frac{\sum_i^n a_i^2 -2n\bar{a}^2+n\bar{a}^2}{n-1} = \frac{\sum_i^n a_i^2}{n-1} -\frac{n\bar{a}^2}{n-1}  $$

### Statistics composition
Given two ordered sets, $$a_1,\dots,a_n$$ with statistics $$\bar{a},\hat{a}$$, and $$b_1,\dots,b_m$$ with statistics $$\bar{b},\hat{b}$$ we have that:

 * the combined set has mean $$\bar{c} = \frac{\sum_i^n a_i + \sum_j^m b_j}{n+m}$$
 * the combined set has variance $$\hat{c} = \frac{\sum_i^n a_i^2 + \sum_j^m b_j^2}{n+m-1} - \frac{(n+m)\bar{c}^2}{n+m-1}$$

It follows that:

$$\bar{c} = \frac{n\bar{a} + m\bar{b}}{n+m}$$

Being $$\sum_i^n a_i^2 = (n-1)\hat{a} + n\bar{a}^2$$,

$$\hat{c} = \frac{(n-1)\hat{a}+n\bar{a}^2+(m-1)\hat{b}+m\bar{b}^2}{n+m-1} - \frac{(n+m)\bar{c}^2}{n+m-1}$$

### The solution
Given our chunks $$c_k$$ coming in order, we can apply the formulas from the previous section to keep up-to-date mean $$\mu$$ and variance $$v$$ of our entire dataset.

First we compute $$\mu,v$$ on $$c_1$$. When we receive/load $$c_2$$ we compute its mean and variance, $$\bar{c}_2,\hat{c}_2$$, and we use the composition formulas, combining $$\mu,v$$ with $$\bar{c}_2,\hat{c}_2$$, and saving the results in $$\mu,v$$. When we receive/load $$c_3$$ we repeat,... and so on.
