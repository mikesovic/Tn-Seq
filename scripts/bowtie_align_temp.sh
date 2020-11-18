echo "Alignment commands..." >> run_details.txt

for file in `ls temp/TrimmedData/`
do
 base=`echo ${file} | sed -E 's/\.fastq//' | sed -E 's/\.fq//'`
 ./bowtie-1.3.0-linux-x86_64/bowtie -m 1 -v max_mismatches -S -x reference/index_base temp/TrimmedData/${file} aligned/${base}.sam
 echo "./bowtie-1.3.0-linux-x86_64/bowtie -m 1 -v max_mismatches -S -x reference/index_base temp/TrimmedData/"${file}" aligned/"${base}".sam" >> run_details.txt
done
