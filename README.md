*Bash Script*
`sudo chmod 755 KVMSwitchBT.sh`
`cp KVMSwitchBT.sh /usr/local/bin/KVMSwitchBT`

*Building the stream handler*
`gcc -framework Foundation -o xpc_set_event_stream_handler xpc_set_event_stream_handler.m`
`cp xpc_set_event_stream_handler /usr/local/bin/`

*Launch Agent*
`cp com.KVMSwitchBT.plist ~/Library/LaunchAgents/`
***Activate Agent***
`rm ~/Library/LaunchAgents/com.KVMSwitchBT.plist`

*Launch Daemon*
`sudo cp com.KVMSwitchBT.plist /Library/LaunchDaemons/`
`sudo chown root:wheel /Library/LaunchDaemons/com.KVMSwitchBT.plist`

***Activate Daemon***
`launchctl load /Library/LaunchDaemons/com.KVMSwitchBT.plist`

***To Remove:***
`launchctl remove com.KVMSwitchBT.program`