name=`grep -E '^ref_genome_file' params.txt | awk '{print $2}'`
base=`echo ${name} | sed 's/.gz//'`

num=`grep -E '^max_alignment_mismatches' params.txt | awk '{print $2}'`

sed "s|max_mismatches|${num}|" scripts/bowtie_align_temp.sh | \
sed "s|index_base|${base}|" > scripts/bowtie_align.sh

chmod +x scripts/bowtie_align.sh
