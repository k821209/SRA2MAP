./ncbi_download.py ${1}
fastq-dump  --origfmt -I  --split-files --gzip ${1}.sra
mkdir ${1}
/program/hisat2-2.0.3-beta/hisat2 --rna-strandness RF --max-intronlen 30000  -p 5 -x ../../../ref/Creinhardtii_281_v5.0 -1 ${1}_1.fastq.gz -2 ${1}_2.fastq.gz | sambamba view -f bam -o ${1}/${1}.bam -S /dev/stdin
sambamba sort -t 10 ${1}/${1}.bam
rm ${1}.sra
rm ${1}_1.fastq.gz
rm ${1}_2.fastq.gz
#/program/stringtie-1.2.2.Linux_x86_64/stringtie -p 5 -o ${1}/${1}.sorted.bam.stringtie.gff  ${1}/${1}.sorted.bam
#/program/TransDecoder-2.1.0/util/cufflinks_gtf_genome_to_cdna_fasta.pl ${1}/${1}.sorted.bam.stringtie.gff ../../../ref/Creinhardtii_281_v5.0.fa > ${1}/transcripts.fasta
#/program/TransDecoder-2.1.0/TransDecoder.LongOrfs -t ${1}/transcripts.fasta
#/program/TransDecoder-2.1.0/TransDecoder.Predict -t ${1}/transcripts.fasta --cpu 5
#mv transcripts.fasta.transdecoder* ${1}/
#rm ${1}.sra
#rm ${1}_1.fastq.gz
#rm ${1}_2.fastq.gz
