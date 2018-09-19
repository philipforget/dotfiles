A collection of my dotfiles, as well as other customization steps to be taken when setting up a new Linux environment.

## Installation

Assume all repos are to be located in `~/workspace`.

```bash
mkdir -p  ~/workspace && cd ~/workspace
git clone git@github.com:cameronhr/dotfiles.git
python dotfiles/setup.py
```
On first use of vim: `:PlugInstall`


## Other

1. Correct vim solarized colour display in Terminal:
    Open a Terminal window and modify the Profile (Terminal -> Preferences -> Profiles in Ubuntu 18.04)
    Select 'Solarized Dark' for both 'Text and Background Color' and 'Palette'
2. Bind `Control_L` to `Caps_Lock`:
    Install _Tweaks_ tool: `sudo apt-get install -yq gnome-tweak-tool && gnome-tweaks`
    Click through: 'Keyboard & Mouse -> Additional Layout Options -> Caps Lock behavior'
3. Use `Caps_Lock` as `Escape` when pressed and released on its own, use normally when pressed in conjunction with another key, using XCAPE
    Install development dependencies: `sudo apt-get install git gcc make pkg-config libx11-dev libxtst-dev libxi-dev`
    Run:
```
git clone https://github.com/alols/xcape.git
cd xcape
make
sudo make install
```
    Followed by `xcape -e 'Caps_Lock=Escape'`
