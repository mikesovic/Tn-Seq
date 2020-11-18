
mkdir -p temp/FilteredData

for i in `ls RawData`
do
 zcat RawData/${i} | \
 grep -E -A2 -B1 '[ATGCN]{8,10}ACTTATCATCCAACCTGTGT[ATGC]{12,13}$' | \
 grep -v -E '^--$' | \
 gzip > temp/FilteredData/${i}
done
