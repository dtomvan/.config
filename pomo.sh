declare -A pomo_options
pomo_options["work"]="45"
pomo_options["break"]="10"

cycle() {
    pomodoro work && pomodoro break
}

main() {
    if [ -n "$1" ]; then pomo_options["work"]="$1"; fi
    if [ -n "$2" ]; then pomo_options["break"]="$2"; fi
    while gum confirm "next cycle?"; do cycle; done
}

pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
  val=$1
  echo $val | lolcat
  timer ${pomo_options["$val"]}m
  spd-say "'$val' session done"
  fi
}

main $@
