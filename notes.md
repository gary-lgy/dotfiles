1. Make sure `~/.*sh_profile` sources `~/.profile`.
2. To use Filco bluetooth mechanical keyboards in Arch on a Dell laptop, install
   the `hid2hci` package and reboot.
3. Turn off beeping: stick `xset -b b off` in `~/.xinitrc`.
4. buku bookmarks need to be transferred manually.
5. Currently unable to make keyboard config defined in xinitrc persistent after
   a keyboard reboot. I would like it to automatically execute the xset commands
   I want(by defining the udev rules and giving root the permission to connect
   to X with xhost +local:. The commands can execute successfully, but the
   effects are not reflected.
6. If encounter black screen after installing nvidia proprietary driver,
   blacklist the kernel module `nvidia_drm`.
7. Module files added for bbswitch: 
  a. `/etc/modules-load.d/bbswitch`: load `bbswitch` on boot
  b. `/etc/modprobe.d/bbswitch.conf`: disable nvidia GPU on boot
  c. `/usr/lib/modprobe.d/nvidia-xrun.conf`: blacklist nvidia kernel modules
8. To use `~/.xinitrc` as a session in LightDM, create a custom session file in
   `/usr/share/xsessions/xinitrc.desktop` and symlink `~/.xsession` to
   `~/.xinitrc`.
9. TeamViewer require a login manager.
