tell application "Firefox Developer Edition"
	
	tell application "System Events" to tell application process "Firefox Developer Edition"
		set previousWindowCount to (count of windows)
		click menu item "New Window" of menu "File" of menu bar 1
		repeat while (count of windows) = previousWindowCount
			delay 0.1
		end repeat
	end tell
	
	set index of window (count of windows) to 1
	activate
	
end tell