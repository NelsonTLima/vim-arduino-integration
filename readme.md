# VIM-HTML-BOILERPLATE

## HOW TO INSTALL

You just need to clone this repository and then, execute the instalation bash file

```
git clone https://github.com/NelsonTLima/vim-arduino-integration.git
cd vim-arduino-integration
./install.sh
```

# HOW TO USE

When you want to choose the device you're going to work, you can put vim on the normal mode and:

```vim
:call SetArduino()
```

If you want to upload directly, just put:

```vim
:call ArduinoUpload
```

Now you cand upload programs into your arduino without the necessity of using Arduino IDE.
