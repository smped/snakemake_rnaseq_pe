rule star_pe:
    input:
        fq1 = "data/trimmed/fastq/{sample}" + r1 + ext,
        fq2 = "data/trimmed/fastq/{sample}" + r2 + ext,
        index = rules.star_index.output
    output:
        "data/aligned/bam/{sample}/Aligned.sortedByCoord.out.bam"
    conda:
        "../envs/star.yml"
    log:
        "logs/star/{sample}.log"
    params:
        extra = "--outSAMtype BAM SortedByCoordinate"
    threads: 4
    script:
        "../scripts/star_alignment.py"

rule index_bam:
    input:
        rules.star_pe.output
    output:
        "data/aligned/bam/{sample}/Aligned.sortedByCoord.out.bam.bai"
    conda:
        "../envs/samtools.yml"
    threads: 1
    shell:
        """
        samtools index {input} {output}
        """

