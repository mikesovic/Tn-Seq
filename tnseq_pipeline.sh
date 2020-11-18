#SBATCH -t 120
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -o slurm.out
#SBATCH --account=PAS1766

cd $SLURM_SUBMIT_DIR
timestamp=`date +%Y%m%d-%H%M`
mkdir tnseq_${timestamp}

#create report file
touch report_${timestamp}.txt
touch run_details.txt

echo "Parameters for run..."
cat params.txt >> run_details.txt

echo "Counting reads in raw data files"
./scripts/count_raw.sh

echo "Filtering data files"
./scripts/filter_wrapper.sh
./scripts/filter.sh

echo "Counting reads in filtered data files"
./scripts/count_filtered.sh

echo "Trimming filtered reads"
mkdir temp/TrimmedData
./scripts/trim_wrapper.sh
perl scripts/trim.pl

echo "Getting Bowtie"
curl -L -o bowtie_1.3.0.zip https://sourceforge.net/projects/bowtie-bio/files/bowtie/1.3.0/bowtie-1.3.0-linux-x86_64.zip/download
unzip -q bowtie_1.3.0.zip
rm bowtie_1.3.0.zip

echo "Indexing Reference Genome"
./scripts/index_wrapper.sh
./scripts/index.sh

echo "Aligning Reads To Reference"
mkdir aligned
touch alignment_stats.txt
./scripts/align_wrapper.sh
./scripts/bowtie_align.sh

echo "Counting aligned reads"
./scripts/count_aligned.sh

echo "Getting FeatureCounts"
curl -L -o subread_2.0.1.tar.gz https://sourceforge.net/projects/subread/files/subread-2.0.1/subread-2.0.1-Linux-x86_64.tar.gz/download
tar -xzf subread_2.0.1.tar.gz
rm subread_2.0.1.tar.gz

echo "Running FeatureCounts"
mkdir count_data
./scripts/count_wrapper.sh
./scripts/count_reads.sh

mv aligned tnseq_${timestamp}
mv alignment_stats.txt tnseq_${timestamp}
mv count_data tnseq_${timestamp}
mv report.txt tnseq_${timestamp}
mv temp tnseq_${timestamp}
mv slurm.out tnseq_${timestamp}
mv run_details.txt run_details_${timestamp}.txt
mv run_details_${timestamp}.txt tnseq_${timestamp}
mv report_${timestamp}.txt tnseq_${timestamp}

rm -r bowtie-1.3.0-linux-x86_64
rm -r subread-2.0.1-Linux-x86_64
