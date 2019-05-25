## Keyboard
1. To use Filco bluetooth mechanical keyboards in Arch on a Dell laptop, `hid2hci` might be needed.
2. Use `localectl` to set keyboard layout and options.
3. Change typematic delay in `/etc/X11/xinit/xserverrc` by passing options to `/usr/bin/X`. However, LightDM does not read this file.
4. After figuring out how to let LightDM read xserver options, `btkbcon` will no longer need to call `kbconfig` to manually set typematic delay.

## Display
1. If encounter black screen after installing nvidia proprietary driver, blacklist the kernel module `nvidia_drm`.
2. Module files added for bbswitch: 
  a. `/etc/modules-load.d/bbswitch`: load `bbswitch` on boot
  b. `/etc/modprobe.d/bbswitch.conf`: disable nvidia GPU on boot
  c. `/usr/lib/modprobe.d/nvidia-xrun.conf`: blacklist nvidia kernel modules
3. To use `~/.xinitrc` as a session in LightDM, create a custom session file in `/usr/share/xsessions/xinitrc.desktop` and symlink `~/.xsession` to `~/.xinitrc`.
4. TeamViewer 14 require a login manager.

## Misc
1. Make sure `~/.*sh_profile` sources `~/.profile`.
2. `buku` bookmarks need to be transferred manually.
3. The following packages need services to be enabled: greenclip, betterlockscreen
