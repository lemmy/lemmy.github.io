Comment by Markus Alexander Kuppe | 2013/06/23 at 11:52:37
-----------

Using:

    “pandoc –no-wrap -f markdown -t latex $$i > /tmp/mdtmp.tex && tex2lyx -f /tmp/mdtmp.tex $$o”

as a Markdown > LyX importer causes LyX to crash with a BO during import.

Comment by Stéphane Mourey | 2015/02/12 at 22:31:37
-----------

You should try [Multimarkdown](http://fletcherpenney.net/multimarkdown/) 
which works well for me with the command

     `multimarkdown -t lyx $$i > $$o`

as Markdown -> LyX converter.
