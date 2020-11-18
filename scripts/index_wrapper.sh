name=`grep -E '^ref_genome_file' params.txt | awk '{print $2}'`
base=`echo ${name} | sed 's/.gz//'`

sed "s|ref_genome_name|${name}|" scripts/index_temp.sh | 
sed "s|base_name|${base}|" > scripts/index.sh

chmod +x scripts/index.sh
