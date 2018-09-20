#!/bin/bash
#
# abcde4ab is a wrapper for abcde for audiobooks (multidiscs)
# (written by Markus Alexander Kuppe)
#
# v0.1

# user defined variables
ARTIST=$1
ALBUM=$2
CD_COUNT=$3

# Optional user def vars (if starting from a CD > 1)
FROM=${4-"1"}

# nested non-standard tools
ABCDE=`which abcde` || "/usr/bin/abcde"
EYED3=`which eyeD3` || "/usr/bin/eyeD3"

CONF="abcde4ab.conf.tmp"

for CD_NUM in `seq -w $FROM $CD_COUNT`; do
    # Build title out of artist, album and cdnum
    TITLE="${ARTIST} - ${ALBUM} - CD${CD_NUM}v${CD_COUNT}"

    # replace whitespaces in filename with underscores
    FILE_NAME=${TITLE// /_}

    # create temporary abcde.conf to define output file name
    echo "ONETRACKOUTPUTFORMAT='$FILE_NAME'" > $CONF

    # encode with abcde
    # "-o mp3": encode to mp3
    # "-1": encode whole cd into a single mp3 file
    # "-N": non interactive mode
    # "-x": eject cd when all tracks have been read
    # "-a": additionally write cue file
    # "-W": concatenate cds
    # "-c": use custom abcde.conf file
    $ABCDE -o mp3 -1 -N -p -x -a default,cue -W $CD_NUM -c $CONF || exit 1

    # Remove tmp config
    test -e $CONF && rm $CONF

    # merge cue sheet into mp3
    $EYED3 --add-chapter-from-cue $FILE_NAME.cue $FILE_NAME.mp3 || exit 1

    # fix artist, album
    # (cddb might return inconsistent results for each disc id)
    $EYED3 --album "$ALBUM" --artist "$ARTIST" --title "$TITLE" --text-frame="TPOS:${CD_NUM}/${CD_COUNT}" --genre "Hoerbuch" $FILE_NAME.mp3 || exit 1

    # wait next CD to be inserted into drive
    read -p "Insert CD #${CD_NUM} of ${CD_COUNT} into drive and press ENTER"
done
