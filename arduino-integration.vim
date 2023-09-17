" Vim global plugin for selecting devices and uploading programs to arduino.
" Last Change:  2023 Sep 17
" Mantainer:    Nelson Lima <nelsontlima@gmail.com>
" License:      This file is placed in the public domain.

  echo "Device List:\n"

  let index = 0
  for device in deviceList
    echo index . " - " . device
    let index = index + 1
  endfor

  let device = str2nr(input("Choose device index: "))
  let g:arduinoPort = split(deviceList[device])[0]
  let g:arduinoFbqn = matchstr(deviceList[device], "[0-9A-Za-z_]*:[0-9A-Za-z_]*:[0-9A-Za-z_]*")

  if g:arduinoFbqn == ""
    let g:arduinoFbqn = "Unknown"
  endif
endfunction

function! ArduinoUpload()
  if ! exists("g:arduinoPort") || g:arduinoFbqn == "Unknown"
    call SetArduino()
  endif
  exec "!clear &&printf '\e[3J' ; arduino-cli upload ./ -b". g:arduinoFbqn . " -p" . g:arduinoPort
endfunction
