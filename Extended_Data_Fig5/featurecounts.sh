##featurecounts.sh:

/home/wanlab/apps/subread-2.0.0-Linux-x86_64/bin/featureCounts -T 4 -s 2 \

-a /home/wanlab/RNA_seq/Caenorhabditis_elegans.WBcel235.106.gtf \

-o /public/GW/Y111B2A.3.1_small_RNA_seq/results/counts/N2_WAN611_SR_featurecounts.txt \

/public/GW/Y111B2A.3.1_small_RNA_seq/results/bowtie/*.bam
