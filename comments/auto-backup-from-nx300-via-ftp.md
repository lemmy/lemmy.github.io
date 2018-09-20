Comment by: Bill Hart Date: 2014-09-29 09:57:17
----------

Hi,

Just a couple of updates on hacking the Samsung NX cameras.  I'm using the NX300M so comments refer to them specifically.  Samsung have removed the autoexec.sh exploit from the last couple of firmware revisions - from 1.11 on.  However you can find and install older firmware  http://downloadcenter.samsung.com/content/FM/201407/20140707123850056/NX300M_FW_v1.11.zip and 'upgrade' to an older version.

It looks like they have removed from '/etc/go.sh' the code which looked for and executed a autoexec.sh file on the SD card.  I would build a modified version of their firmware but the instructions from the developer site are fairly poor and it looks like a day or so's work to get it to build.

Wifi stuff worked well for me (saved me a few hours at least), I'd wondered if you'd considered using rsync rather than ftp ?  Its supposed to be part of busybox.

cheers
Bill Hart

Comment by: Lee Olds Date: 2014-12-30 19:02:17
----------

Hello,
Thanks for describing how you did this. I have the NX300 (not NX300M).
In response to Bill Hart's comment, I've tested the autoexec.sh hack
on the latest NX300 firmware (1.45), and it still works fine there.
Also, I've seen page describing how someone set up an auto-backup on
NX300 using the ssh client that comes in the camera.
https://cedarandthistle.wordpress.com/2014/11/01/autobackup-to-linux-from-the-samsung-nx300m/
