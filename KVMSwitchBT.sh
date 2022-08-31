#!/bin/bash

BTStatus=0
ReconnectAttempts=0

function timeout() { perl -e 'alarm shift; exec @ARGV' "$@"; }

function prompt() {
  osascript <<EOT
    tell app "System Events"
      display dialog "$1" buttons {"OK"} default button 1 with icon caution with title "$(basename $0)" giving up after 10
      return  -- Suppress result
    end tell
EOT
}

function isConnected() {
  BTStatus=$(blueutil --power)
}

function connectBT() {
  blueutil -p 1 2>&1
}

function disconnectBT() {
  blueutil -p 0 2>&1
}

function switchBT(){
  disconnectBT && sleep 1 && connectBT 
}

function reconnectBT() {

  if [ $BTStatus -eq 1 ]
  then
    initKVMSwitchBT
  else
    connectBT
    isConnected
    if [ $BTStatus -eq 1 ]
    then
      initKVMSwitchBT
    elif [[ $ReconnectAttempts -gt 5 ]]
    then
      
      exit 0
    else
      ((ReconnectAttempts=ReconnectAttempts+1))
      reconnectBT
    fi
  fi
}

function reconnectBTDevice(){
  timeout 10 blueutil --unpair ${1} && blueutil --pair ${1}
}
initKVMSwitchBT () {

  switchBT && isConnected

  if [ $BTStatus -eq 1 ]
  then

    # get devices list    
  prompt "Power on and of your devices"
  reconnectBTDevice "2c-33-61-e2-a3-32"
  reconnectBTDevice "98-46-0a-a4-7f-f8"

  else
    echo "reconecting..."
    reconnectBT
  fi

}

initKVMSwitchBT