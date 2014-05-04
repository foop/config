#!/bin/bash
 
# bindsym Mod4+odiaeresis exec "~/.i3/window-border.sh show"
# bindsym Mod4+adiaeresis exec "~/.i3/window-border.sh hide"
 
function I3_GET_TREE() {
    echo -ne "i3-ipc\x0\x0\x0\x0\x4\x0\x0\x0" |
        socat STDIO UNIX-CLIENT:`i3 --get-socketpath` |
        tail -c +15
}
 
function I3_COMMAND() {
    i3-msg "$1"
}
 
function I3_COMMAND_FORALL() {
    local command=$1
    I3_GET_TREE |
        tr ',' '\n' |
        sed -ne 's/.*id":\([0-9]*\)/\1/p' | while read id; do
            I3_COMMAND "[con_id=$id] $command" > /dev/null
        done
}
 
 
if [ "$#" -gt 0 ]; then
    case "$1" in
        hide)
            I3_COMMAND_FORALL "border 1pixel"
            ;;
        show)
            I3_COMMAND_FORALL "border normal"
            ;;
    esac
fi


