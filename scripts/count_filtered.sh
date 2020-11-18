echo '' >> report.txt
echo 'Filtered reads per sample:' >> report.txt

for i in `ls temp/FilteredData`
do
 count=`zcat temp/FilteredData/${i} | wc -l | awk '{print $1'}`
 reads=`echo $(( ${count} / 4 ))`
 echo ${reads}' '${i} >> report.txt
done
