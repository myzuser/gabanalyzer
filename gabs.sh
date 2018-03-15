#!/bin/bash
while read newline
do
    new=$(date -d "$( echo "$newline" | awk '{sub(/:[0-9]+\|/,"|",$2);print $1}' )" '+%s' )
    echo $new
    if [ "$old" ] && (( $new - $old > 300))
    then
        printf "%4i seconds gap before %s" "$((new - old))" "$newline"
    fi
    old=$new
done <$1
