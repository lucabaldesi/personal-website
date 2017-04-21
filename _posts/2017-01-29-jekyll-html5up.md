---
layout: post
title:  Building a static, liquid website
date:   2017-01-17 16:16:01 -0600
categories: jekyll html5up  
---

My [website]({{ site.baseurl }}) born today for work needs. I need a simple-to-maintain and elegant solution to showcase my resume and my research activity. To this end I use [Jekyll](https://jekyllrb.com/), a static html file processor and the [html5up](https://html5up.net/) templates.

html5up templates are designed by professionals in web design and besides being good looking they have been realized with portability in mind. An html5up based website will maintain the same readability and visual effects on all the supported devices (notebooks, tablet and smartphone).

Realizing an entire website using one of those templates can be boring and time consuming (other than difficult to maintain) because of the repeated code you have to copy and paste over and over. Jekyll fixes this issue. Jekyll is [ruby](https://www.ruby-lang.org/en/) gem and once installed can be used to transform template files in actual, ready-to-be-served html web pages.

What I have done it is simple turning the html5up template I liked the most into a Jekyll layout template. After this I can create simple text pages (both in html or in markdown) and generate the final pages with a command line call to jekyll.
