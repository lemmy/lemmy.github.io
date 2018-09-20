Comment by: Mickael Istria Date: 2013-12-19 15:23:17
----------

Xvfb is not the best choice IMO.

Locally, I recommend to use Xephyr, which creates a new DISPLAY and opens a dedicated window in your desktop where you can see and interact with what’s happening in this display (without taking focus on your current DISPLAY).
Remotely, I would recommend using Xvnc which will allow to connect to and interact locally with the remote display and application with any VNC client.
By allowing to see what is happening, those X servers make it easier to debug tests.
