#!/bin/bash

# Generate pdfs
tail -n +4 ./cat-wordlist-ascii.txt | head -n -16 > wordlist.txt
latexmk -pdf -quiet cat-wordlist.tex
mv cat-wordlist.pdf cat-wordlist-ascii.pdf

tail -n +4 ./cat-wordlist-utf8.txt | head -n -16 > wordlist.txt
latexmk -pdf -quiet cat-wordlist.tex
mv cat-wordlist.pdf cat-wordlist-utf8.pdf

# Clean files
latexmk -c
rm wordlist.txt
