Install bibtex2html (1.97-5 as of writing) with apt:
---------------------------

apt-get install bibtex2html


Generate markdown style output compatible with pelican pages:
---------------------------

echo "Title: talks" > ../../blog/content/pages/talks.md \
&& bibtex2html -unicode -r -d -css /theme/css/main.css -o talks -nodoc personal.bib \
&& cat talks.html >> ../../blog/content/pages/talks.md \
&& mv publications_bib.html ../../blog/content/pages/publications_bib.html \
&& rm *.html


Generate bibtex output with (old method, not used anymore):
---------------------------

bibtex2html -unicode -r -d -css /theme/css/main.css -t publications -o index personal.bib

The -css /theme... links to the pelican static blog css file in the generated output

