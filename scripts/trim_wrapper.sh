pattern=`grep -E '^trim_pattern' params.txt | awk '{print $2}'`

sed "s/pattern_to_trim/${pattern}/" scripts/trim_temp.pl > scripts/trim.pl

chmod +x scripts/trim.pl
