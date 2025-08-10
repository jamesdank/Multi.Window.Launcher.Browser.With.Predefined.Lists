# Multi.Window.Launcher.Browser.With.Predefined.Lists
This is a bash launcher script to open multiple windows with predefined sites.

How to use:</br>
open terminal</br>
Download file:</br>
cd ~</br>
wget https://github.com/jamesdank/Multi.Window.Launcher.Browser.With.Predefined.Lists/blob/main/launcher.sh

Edit launcher.sh to pick your browser and create the list you want opened when launched.

Make it executable</br>
chmod +x ~/launcher.sh

(Optional) Create a desktop launcher:</br>
Create a file:</br>
open terminal</br>
nano ~/.local/share/applications/multi.launcher

Edit "yourusername" below

Paste into file:</br>
[Desktop Entry]</br>
Name=Multi-Window Launcher</br>
Exec=/home/yourusername/launcher.sh</br>
Icon=brave-browser</br>
Terminal=false</br>
Type=Application</br>
Categories=Network;WebBrowser;

Save file, then make it executable:

chmod +x ~/.local/share/applications/multi.desktop
