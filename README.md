# RNA-Seq Workflow

This is an RNA-Seq workflow written in `snakemake`, and tested on the University of Adelaide HPC (phoenix).
This has been written for paired-end reads and will not behave correctly for single end reads.
If you have single end reads, please use the `single_end` branch.


## Outline

The steps currently implemented are

1. Download the DNA reference, GTF file
2. Generate the STAR index for the reference
3. Trim files using `AdapterRemoval`
4. Align Trimmed files using STAR
5. Count reads using `featureCounts`

Additional tasks performed are

1. Initialising a `workflowr` directory structure
2. FastQC reports are also generated for both raw and trimmed reads

## Essential Files

In order to run this workflow, please ensure that you have

1. Placed unprocessed fastq files in the directory `data/raw/fastq`
2. Placed a `tsv` file (usually called `samples.tsv`) in the `config` folder
    + This file **must** contain a column called `sample`
    + Each sample need only be listed once, i.e. there is no need to list samples separately for R1 & R2 files
3. Edited `config.yml` in the `config` folder to ensure all parameters are correct
