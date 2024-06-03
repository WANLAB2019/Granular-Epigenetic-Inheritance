### #N2,WT; WAN611, herd-1(ths351)

##fastqc

fastqc -o /public/GW/Y111B2A.3.1_small_RNA_seq/results/fastqc /public/GW/Y111B2A.3.1_small_RNA_seq/data/N2_SR_rep1.fq

fastqc -o /public/GW/Y111B2A.3.1_small_RNA_seq/results/fastqc /public/GW/Y111B2A.3.1_small_RNA_seq/data/N2_SR_rep2.fq

fastqc -o /public/GW/Y111B2A.3.1_small_RNA_seq/results/fastqc /public/GW/Y111B2A.3.1_small_RNA_seq/data/WAN611_SR_rep1.fq

fastqc -o /public/GW/Y111B2A.3.1_small_RNA_seq/results/fastqc /public/GW/Y111B2A.3.1_small_RNA_seq/data/WAN611_SR_rep2.fq

##Bowtie

/home/wanlab/apps/bowtie-1.2.2-linux-x86_64/bowtie -q -n 0 -p 4 /home/wanlab/reference_genome/ce_bowtie_index/ce11 /public/GW/Y111B2A.3.1_small_RNA_seq/data/N2_SR_rep1.fq /public/GW/Y111B2A.3.1_small_RNA_seq/results/bowtie/N2_SR_rep1.sam -S

/home/wanlab/apps/bowtie-1.2.2-linux-x86_64/bowtie -q -n 0 -p 4 /home/wanlab/reference_genome/ce_bowtie_index/ce11 /public/GW/Y111B2A.3.1_small_RNA_seq/data/N2_SR_rep2.fq /public/GW/Y111B2A.3.1_small_RNA_seq/results/bowtie/N2_SR_rep2.sam -S

/home/wanlab/apps/bowtie-1.2.2-linux-x86_64/bowtie -q -n 0 -p 4 /home/wanlab/reference_genome/ce_bowtie_index/ce11 /public/GW/Y111B2A.3.1_small_RNA_seq/data/WAN611_SR_rep1.fq /public/GW/Y111B2A.3.1_small_RNA_seq/results/bowtie/WAN611_SR_rep1.sam -S

/home/wanlab/apps/bowtie-1.2.2-linux-x86_64/bowtie -q -n 0 -p 4 /home/wanlab/reference_genome/ce_bowtie_index/ce11 /public/GW/Y111B2A.3.1_small_RNA_seq/data/WAN611_SR_rep2.fq /public/GW/Y111B2A.3.1_small_RNA_seq/results/bowtie/WAN611_SR_rep2.sam -S

##samtools

/home/wanlab/apps/samtools-1.14/samtools view -bS /public/GW/Y111B2A.3.1_small_RNA_seq/results/bowtie/N2_SR_rep1.sam >/public/GW/Y111B2A.3.1_small_RNA_seq/results/bowtie/N2_SR_rep1.bam

/home/wanlab/apps/samtools-1.14/samtools view -bS /public/GW/Y111B2A.3.1_small_RNA_seq/results/bowtie/N2_SR_rep2.sam > /public/GW/Y111B2A.3.1_small_RNA_seq/results/bowtie/N2_SR_rep2.bam

/home/wanlab/apps/samtools-1.14/samtools view -bS /public/GW/Y111B2A.3.1_small_RNA_seq/results/bowtie/WAN611_SR_rep1.sam > /public/GW/Y111B2A.3.1_small_RNA_seq/results/bowtie/WAN611_SR_rep1.bam

/home/wanlab/apps/samtools-1.14/samtools view -bS /public/GW/Y111B2A.3.1_small_RNA_seq/results/bowtie/WAN611_SR_rep2.sam > /public/GW/Y111B2A.3.1_small_RNA_seq/results/bowtie/WAN611_SR_rep2.bam

 ##featurecounts:

sh /public/GW/Y111B2A.3.1_small_RNA_seq/scripts/featurecounts.sh
