" Vim global plugin for selecting devices and uploading programs to arduino.
" Last Change:  2023 Sep 17
" Mantainer:    Nelson Lima <nelsontlima@gmail.com>
" License:      This file is placed in the public domain.

function! ListArduino()
  let deviceList = split(system("arduino-cli board list | grep /dev"), "\n")

  echo "    Port                            Protocol Type              Board Name  FQBN            Core"
  let index = 0
  for device in deviceList
    echo index . " - " . device
    let index = index + 1
  endfor
  return deviceList
endfunction

function! SelectedArduino()
  if exists("g:arduinoPort") && exists("g:arduinoFbqn")
    echo "PORT - " . g:arduinoPort
    echo "FBQN - " . g:arduinoFbqn
  else
    echo "There's no device selected."
  endif
endfunction

function! SetArduino()
  let deviceList = ListArduino()

  let device = str2nr(input("Choose device: "))

  if device <= 0 || device >= len(deviceList)
    echo "\nDevice out of list range."
    return
  endif

  let g:arduinoPort = split(deviceList[device])[0]
  let g:arduinoFbqn = matchstr(deviceList[device], "[0-9A-Za-z_]*:[0-9A-Za-z_]*:[0-9A-Za-z_]*")

  if g:arduinoFbqn == ""
    let g:arduinoFbqn = "Unknown"
  endif

  echo "\n\nSelected:"
  call SelectedArduino()
endfunction

function! UploadArduino()
  if ! exists("g:arduinoPort") || g:arduinoFbqn == "Unknown"
    call SetArduino()
  endif
  exec "!clear &&printf '\e[3J' ; arduino-cli upload ./ -b". g:arduinoFbqn . " -p" . g:arduinoPort
endfunction

command! ListArduino call ListArduino()
command! SelectedArduino call SelectedArduino()
command! UploadArduino call ArduinoUpload()
command! SetArduino call SetArduino()
