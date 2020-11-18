echo '' >> report.txt
echo 'Uniquely aligned reads per sample:' >> report.txt

for i in `ls aligned`
do
 count=`wc -l aligned/${i} | awk '{print $1'}`
 echo ${count}' '${i} >> report.txt
done
