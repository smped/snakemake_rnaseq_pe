rule adapter_removal:
    input:
        r1 = "data/raw/fastq/{sample}" + r1 + ext,
        r2 = "data/raw/fastq/{sample}" + r2 + ext
    output:
        r1 = "data/trimmed/fastq/{sample}" + r1 + ext,
        r2 = "data/trimmed/fastq/{sample}" + r2 + ext,
        log = "data/trimmed/logs/{sample}.settings"
    conda:
        "../envs/adapterremoval.yml"
    params:
        adapter1 = config['trimming']['adapter1'],
        adapter2 = config['trimming']['adapter2'],
        minlength = config['trimming']['minlength'],
        minqual = config['trimming']['minqual'],
        maxns = config['trimming']['maxns'],
        extra = config['trimming']['extra'],
        autogit = config['autogit']
    threads: 1
    log:
        "logs/adapterremoval/{sample}.log"
    shell:
        """
        AdapterRemoval \
            --adapter1 {params.adapter1} \
            --adapter2 {params.adapter2} \
            --file1 {input.r1} \
            --file2 {input.r2} \
            {params.extra} \
            --threads {threads} \
            --maxns {params.maxns} \
            --minquality {params.minqual} \
            --minlength {params.minlength} \
            --output1 {output.r1} \
            --output2 {output.r2} \
            --discarded /dev/null \
            --singleton /dev/null \
            --settings {output.log} &> {log}

        ## Add the settings files to the git repo
        if [[ {params.autogit} == "yes" ]]; then
          git add {output.log}
        fi
        """
