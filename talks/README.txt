Install bibtex2html (1.97-5 as of writing) with apt:
---------------------------

apt-get install bibtex2html

Jabref
------

1) Update personal.bib with Jabref, text editor, ...
2) Jabref: Select all entries > File > Save selected as plain Bibtex > personal-plain.bib
3) Continue at generate markdown below

Generate markdown style output compatible with pelican pages:
---------------------------

echo "Title: talks" > ../../blog/content/pages/talks.md 
&& bibtex2html -unicode -r -d -css /theme/css/main.css -o talks -nodoc personal-plain.bib 
&& cat talks.html >> ../../blog/content/pages/talks.md 
&& cp talks_bib.html ../../blog/content/pages/ 
&& rm *.html

Generate bibtex output with (old method, not used anymore):
---------------------------

bibtex2html -unicode -r -d -css /theme/css/main.css -t publications -o index personal.bib

The -css /theme... links to the pelican static blog css file in the generated output

