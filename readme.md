# ARDUINO INTEGRATION FOR VIM

## HOW TO INSTALL

### The arduino-cli interface:

First you have to install the arduino-cli.
The Arduino CLI is available as a Homebrew formula since version 0.5.0:

```bash
brew update
brew install arduino-cli
```

If you're not using Brew, you can also use install scripts.
This script will install the latest version of Arduino CLI to $PWD/bin:

```bash
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
```

If you want to target a different directory, for example ~/local/bin, set the BINDIR environment variable like this:

```bash
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=~/local/bin sh
```

If you would like to use the arduino-cli command from any location, install Arduino CLI to a directory already in your PATH or add the Arduino CLI installation path to your PATH environment variable.

If you want to download a specific Arduino CLI version, for example 0.9.0 or nightly-latest, pass the version number as a parameter like this:

```bash
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=~/local/bin sh
```

Acess https://arduino.github.io/arduino-cli/0.34/installation/ for more arduino-cli installation information.


### The actual plugin:

You just need to clone this repository and then, execute the instalation file

```bash
git clone https://github.com/NelsonTLima/vim-arduino-integration.git
cd vim-arduino-integration
./install.sh
```

# HOW TO USE

Put your Vim in the normal mode and you can use one of the following commands.

|Commands           |Description                                        |
|:---               |:---                                               |
|:ListArduino       |Lists all the devices connected to your computer   |
|:SelectedArduino   |Show wich Port and FBQN you are using              |
|:SetArduino        |Selects wich arduino you are going to work on      |
|:UploadArduino     |Uploads the source code to the selected arduino    |

Now you can upload programs to your arduino directly on VIM. without the necessity of using Arduino IDE.
