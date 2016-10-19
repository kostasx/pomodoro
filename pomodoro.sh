# USAGE: pomodoro <TIME_IN_MINUTES> <MESSAGE> <ENABLE_VOICE>
function pomodoro(){  

  if [ ! $1 ]; then
    MINUTES=2700
    REALMIN=45
  else
    MINUTES=$((60*$1))
    REALMIN=$1 
  fi

  local now=$(date +%s)
  minutes=$(($1*60))
  local end=$((now + $MINUTES))
  while (( now < end )); do   
      printf "%s\r" "$(date -u -r $((end - now)) +%T)"  
      sleep 1
      current="$(date -u -r $((end - now)) +%s)"
      if [ "$current" -eq "300" ]; then
        osascript -e 'display notification "Attention: 5 minutes left." with title "POMODORO" subtitle '$REALMIN' sound name "Submarine"'
      fi
      now=$(date +%s)
  done  
  osascript -e 'display notification "Time is up!" with title "POMODORO" subtitle '$REALMIN' sound name ""'
  if [ $3 ]; then
    say -v Petra "Die Zeit ist um. Zeit für eine Pause.";
  fi

}

export -f pomodoro;
