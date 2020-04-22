# Set keyboard
setxkbmap jaz # If you are not me, remove this line
setxkbmap -option caps:ctrl_modifier # Remap caps lock to ctrl

# Merge .Xresources
xrdb -merge .Xresources

# Set Background
#hsetroot -solid "$(colour -a)"
hsetroot -fill "/home/vibex/Pictures/wallpaper.png"

# Start Redshift
redshift -l 42:-71 & # Set your lattitude and longitude

# Launch Hotkeys
sxhkd &

# Launch Clipboard Manager
# I don't think I like autocutsel, I wanna try something new
#autocutsel &

# Launch mkwm
#bash Documents/Git/mkwm/mkwm.sh -W all -I -L 0 --update 5 &
init.sh

# Start Session
#exec tinywm
exec x-session
#exec berry
