---
layout: post
title:  Referencing publications
date:   2017-06-26
categories: tool referencer plugin publications
---

In my work I often have to cite mine or other works in the form of Bibtex references.
I end up having a database made of pdfs to be read and continuously checking Google scholar for the Bibtex entries to be used.

I found the program [__referencer__](http://icculus.org/referencer/) very useful for organizing such publications along with their Bibtex records.
Referencer creates an organized database accessible through a nice interface and it retrieves the paper meta data using the main public indexing systems available online. Then, it can export the whole collection as a Bibtex file.
It is completely open source and available for *buntu platforms.

I really like it but for the lack of the possibility of exporting only one specific paper Bibtex. Luckily, it is easily extensible so I could create my own [plugin](https://github.com/lucabaldesi/referencer/blob/export_bibtex_entries/plugins/export_bibtex_entries.py) that solves the problem.

I forked the entire git repository which is now available on my [github profile](https://github.com/lucabaldesi/referencer/).

