function! SetArduino()
  let deviceList = split(system("arduino-cli board list | grep /dev"), "\n")

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
