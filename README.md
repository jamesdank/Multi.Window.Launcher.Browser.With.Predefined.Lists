# Multi.Window.Launcher.Browser.With.Predefined.Lists
This is a bash launcher script to open multiple windows with predefined sites.

How to use:
Download file:
cd ~</br>
wget https://github.com/jamesdank/Multi.Window.Launcher.Browser.With.Predefined.Lists/blob/main/launcher.sh

Edit launcher.sh to pick your browser and create the list you want opened when launched.

Make it executable
chmod +x ~/launcher.sh

(Optional) Create a desktop launcher:
Create a file:
open terminal
nano ~/.local/share/applications/multi.launcher

Edit "yourusername" below

Paste into file:
[Desktop Entry]
Name=Multi-Window Launcher
Exec=/home/yourusername/launcher.sh
Icon=brave-browser
Terminal=false
Type=Application
Categories=Network;WebBrowser;

Save file, then make it executable:

chmod +x ~/.local/share/applications/multi.desktop
