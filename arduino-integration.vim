" Vim global plugin for selecting devices and uploading programs to arduino.
" Last Change:  2023 Sep 17
" Mantainer:    Nelson Lima <nelsontlima@gmail.com>
" License:      This file is placed in the public domain.

let g:compilingArduinoFbqn = "arduino:avr:uno"

function! GreaterStringLen(array)
let n = 0
for i in a:array
 if len(i) >= n
    let n = len(i)
  endif
endfor
return n
endfunction

function! FormatToLeft(s, n, end = " ")
  let s = a:s
  let i = len(s)
  while i < a:n
    let s = s . a:end
    let i = i + 1
  endwhile
  return s
endfunction

function! ListAllArduino()
  echo "FBQN list:"

  let deviceList = split(system("arduino-cli board listall | grep -o '[0-9A-Za-z_]*:[0-9A-Za-z_]*:[0-9A-Za-z_]*'"), "\n")

  let lengreater = GreaterStringLen(deviceList)
  let index = 0
  let formated_string = "\n"
  for deviceName in deviceList
    let index_string = string(index)

    if index < 10
      let index_string = " " . index_string
    endif

    let section_size = lengreater - len(index_string) + 10
    let formated_string = formated_string . FormatToLeft(index_string . " - " . deviceName, section_size)
    let index = index + 1

    if index % 3 == 0
      let formated_string = formated_string . "\n"
    endif
  endfor

  echo formated_string
  return deviceList
endfunction

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

function! ChangeCompilingFbqn()
  let deviceList =  ListAllArduino()
  let chosen = str2nr(input("\nChoose FBQN: "))

  if chosen <= 0 || chosen >= len(deviceList)
    echo "\nFBQN out of list range."
    return
  endif

  let g:compilingArduinoFbqn = deviceList[chosen]
  echo "\n" . deviceList[chosen]
  let x = input("...")
endfunction

function! CompileArduino()
  if exists("g:arduinoFbqn") && g:arduinoFbqn != "Unknown"
    exec "!clear &&printf '\e[3J' ; arduino-cli compile -b" . g:arduinoFbqn " %"
  else
    exec "!clear &&printf '\e[3J' ; arduino-cli compile -b" . g:compilingArduinoFbqn "%"
  endif
endfunction

function! UploadArduino()
  if ! exists("g:arduinoPort") || g:arduinoFbqn == "Unknown"
    call SetArduino()
  endif
  exec "!clear && printf '\e[3J' ; arduino-cli upload ./ -b". g:arduinoFbqn . " -p" . g:arduinoPort
endfunction

command! ListAllArduino call ListAllArduino()
command! ListArduino call ListArduino()
command! SetArduino call SetArduino()
command! SelectedArduino call SelectedArduino()
command! CompileArduino call CompileArduino()
command! UploadArduino call ArduinoUpload()
command! ChangeCompilingFbqn call ChangeCompilingFbqn()

":echo g:compilingArduinoFbqn - shows wich FBQN the compiler is using in case
"there's no arduino connected.
