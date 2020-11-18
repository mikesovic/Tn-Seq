
mkdir -p temp/FilteredData

for i in `ls RawData`
do
 zcat RawData/${i} | \
 grep -E -A2 -B1 expression | \
 grep -v -E '^--$' | \
 gzip > temp/FilteredData/${i}
done
