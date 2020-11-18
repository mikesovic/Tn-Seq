echo 'Raw reads per sample:' >> report.txt

for i in `ls RawData`
do
 count=`zcat RawData/${i} | wc -l | awk '{print $1'}`
 reads=`echo $(( ${count} / 4 ))`
 echo ${reads}' '${i} >> report.txt
done
