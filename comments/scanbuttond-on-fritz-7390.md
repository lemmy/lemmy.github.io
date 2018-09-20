Comment by Russel | 2014/01/16 at 15:02:17
---------------

Hi,

wie funktioniert diese Zeile auf der Freetz.box:

    “echo “for i in \`ls\`; do cd \$i && pnm2pdf.sh && cd ..; done” >> /var/media/ftp/tmp/body.txt”

pnm2pdf.sh kann ich in keinem Paket finden?

Comment by Markus Alexander Kuppe | 2014/01/16 at 18:55:49
--------------

Hi Russel,

mein Setup hat sich dahingehend geändert, dass ich die Konvertierung von PNM in PDF & DJVU auf meinem Desktop durchführe. Dort stehen deutlich leistungsfähigere OCR Software bereit. Anbei das Script:


    markus@coconut:~ $ cat /usr/local/bin/pnm2pdf.sh
    #!/bin/bash
    #
    # – Converts a gray-scale PNM document to an ocr’ed PDF
    # – Concatenates all pages into a single PDF document
    # – Assumes German documents
    # – Convert the PDF into DJVU (more space efficient)
    
    # The commandline tools required are:
    # – pdftk
    # – cuneiform
    # – ImageMagick (convert)
    # – pdf2djvu
    # – exactimage (hocr2pdf)
    
    # TODO
    # – OCR does not handle rotated images well (not at all)
    # – Doesn’t cleanup temp files afterwards
    
    OCR_LANG=”ger”
    
    for file in `find *.pnm`; do
    LINEART_FILE=${file/.pnm/-lineart.pnm}
    OCR_FILE=${file/.pnm/.hocr}
    OUT_FILE=${file/.pnm/.pdf}
    
    convert $file -colorspace gray -level 10%,90%,1 -blur 2 +dither -monochrome $LINEART_FILE
    
    # Scaling to 75% is done to work around a bug in cuneiform https://bugs.launchpad.net/cuneiform-linux/+bug/609482
    while [ ! -e $OCR_FILE ]; do
    cuneiform -l $OCR_LANG -f hocr -o $OCR_FILE $LINEART_FILE || convert -scale 75% $LINEART_FILE $LINEART_FILE
    done
    
    hocr2pdf -i $file -s -o $OUT_FILE < $OCR_FILE
    done
    
    # concatenate pages
    pdftk *.pdf output out.pdf
    
    # optionally `pdf2djvu –lines -o out.djvu out.pdf` converts the pdf to a much smaller djvu while sacrificing OCR to scan text alignment
    pdf2djvu –lines -o out.djvu out.pdf


Comment by Russel | 2014/01/17 at 08:43:53
-------------

Hallo Markus,

danke für die Info.
Wie sieht dann aber jetzt dein scanbutton.cfg aus?
Meine Hoffnung lag darin, keinen Desktop parallel laufen zu lassen.

Comment by Markus Alexander Kuppe | 2014/01/17 at 11:55:49
---------

Der Desktop läuft nicht parallel, sondern konvertiert die auf der FritzBox gespeicherten PNMs on-demand. Die FritzBox schickt allerdings direkt nach dem Scan JPEGs per E-Mail an. Darin findet sich auch die Cmdline (…pnm2pdf.sh…), die nach dem Kopieren der PNMs auf den Desktop ausgeführt werden muss.
Das Konvertieren ließe sich natürlich auch automatisieren, für mich ist die aktuelle on-demand Lösung in Batches vollkommen ausreichend.

Comment by Russel | 2014/01/17 at 12:14:22
-----------------

:-)
Ah jetzt habe ich endlich die beiden “echo” Zeilen verstanden

Danke nochmal
