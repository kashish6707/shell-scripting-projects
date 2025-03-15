################
# write a bash script which will monitor a specific process on linux system. If it stops unexpectedly make sure to restart it
################


#!/bin/bash

#echo "Enter process name"
if [[ -z "$1" ]]; then
  echo "You haven't entered any process name"
  exit 1
fi

is_process_running(){
    if pgrep -x "$1" > /dev/null; then
    return 1
    else
    return 0
    fi

}
	# •	pgrep -x "$1":
	# •	pgrep searches for running processes.
	# •	-x ensures an exact match for the process name.
	# •	"$1" takes the first argument passed to the script (process name).
	# •	>/dev/null:
	# •	Redirects output to hide it.

start_process(){
    if is_process_running; then
      echo "Process is running"
    else
       for((i=0; i < 3; i++)); do
       sudo systemctl restart "$1"
       echo "tried to restart process"
       sleep 5
       done
    fi
      
}


