#!/bin/bash
i=0
#total=$(cat $1 | wc -l)
#echo $1
#total=$(cat $1 | wc -l)
#echo $total
while read newline
do
    new=$(date -d "$( echo "$newline" | awk '{sub(/:[0-9]+\|/,"|",$2);print $1}' )" '+%s' )
#    echo $new
    if [ "$old" ] && (( $new - $old > 300))
    then
        printf "%4i seconds gap before %s" "$((new - old))" "$newline"
    fi
    old=$new
    let "i++"
    echo -ne "`echo $i`\r"
done <$1
