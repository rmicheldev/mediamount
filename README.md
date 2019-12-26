# mediamount

This script will mount the USB stick in the same folder `/media/usb` every time.
This can be useful for automation

The following scripts can be used to understand the steps performed by a Linux based operating system to mount a WSB stick.

1. When a USB stick will be connected to the computer, the UDEV daemon will look for a rule to mount the device.

We create this rule in the file:
`etc/udev/rules.d/pendrive.rules`

  `ACTION=="add", KERNEL=="sd[b-z][0-9]", SUBSYSTEMS=="usb", ENV{SYSTEMD_WANTS}="pendrive-attach@'$env{DEVNAME}'.service"`

The  event 'add' will call the daemon **pendrive-attach** with the device name as a parameter: **'$env{DEVNAME}'**

2. However, as the device mounting process can take a long time, it cannot simply be called a script, since UDEV does not allow lengthy processes (and '&' at the end of the command does not resolve), so we need to create a new daemon to do the hard work.

Declare the daemon for the Linux systemd in the file:
`mediamount/etc/systemd/system/pendrive-attach@.service`
With the following instruction:
 `ExecStart=/etc/automount/mountdrive.sh %i`
 
 3. This will call the shell script `/etc/automount/mountdrive.sh` with the device name when a new USB stick will be connected.
