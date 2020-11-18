./subread-2.0.1-Linux-x86_64/bin/featureCounts -T 1 -a annotation/Pstew.gff -t gene \
-f -g Name -o count_data/read_counts.txt aligned/*.sam
