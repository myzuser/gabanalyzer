#!/bin/bash
i=0
units=`cut -d' ' -f1 </proc/uptime`
sec=`date +%s`

while read newline
do
   mynew=$(echo "$newline" | grep -Eo '[0-9]+\.[0-9]+')
   newnew=$(echo $mynew | awk '{print $1}') 
   conv1=$(date -d"70-1-1 + $sec sec - $units sec - $newnew sec" +"%F %T")
   new=$(date -d "$( echo "$conv1" | awk '{sub(/:[0-9]+\|/,"|",$2);print $1}' )" '+%s' )
    if [ "$old" ] && (( $new - $old > 300))
    then
        printf "%4i seconds gap before %s\n" "$((new - old))" "$newline"
        echo @$conv1
        echo $newnew
    fi
    old=$new
    let "i++"
    echo -ne "`echo $i`\r"
done <$1
