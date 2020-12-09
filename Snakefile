# ================== Workflow ==================
rule all:
    input:
        "results/res.txt"

rule path:
    output:
        "results/.gitkeep"
    shell:
        """
        mkdir -p $(dirname {output})
        touch {output}
        """

rule get_pi:
    input:
        "input/run_00.txt"
    output:
        "results/res_00.txt"
    shell:
        "python process.py {input} {output}"

rule clean:
    shell:
        """
        rm -rf results/
        rm -f dag.svg
        """

# Make dependency diagram
rule diagram:
    output:
        'dag.svg'
    shell:  
        '''
        snakemake --forceall --dag | dot -Tsvg > {output}
        '''