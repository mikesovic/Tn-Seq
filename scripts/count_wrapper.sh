name=`grep -E '^anno_file' params.txt | awk '{print $2}'`
num=`grep -E '^num_threads' params.txt | awk '{print $2}'`
type=`grep -E '^feature_type' params.txt | awk '{print $2}'`
id=`grep -E '^feature_ID' params.txt | awk '{print $2}'`

sed "s|anno_name|${name}|" scripts/count_reads_temp.sh | \
sed "s|feature_type|${type}|" | \
sed "s|feature_ID|${id}|" | \
sed "s|num_threads|${num}|" > scripts/count_reads.sh

chmod +x scripts/count_reads.sh
