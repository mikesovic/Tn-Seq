seq=`grep -E '^filter_pattern' params.txt | awk '{print $2}'`

sed "s|expression|${seq}|" scripts/filter_temp.sh > scripts/filter.sh

chmod +x scripts/filter.sh
