# ================== Workflow ==================
rule all:
    input:
        "results/run_00.txt",
        "results/run_01.txt",
        "results/run_02.txt",
        "results/run_03.txt",
        "results/run_04.txt",
        "results/run_05.txt",
        "results/run_06.txt",
        "results/run_07.txt"

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
        script="process.py",
        run="input/{file}.txt"
    output:
        "results/{file}.txt"
    shell:
        "python {input.script} {input.run} {output}"

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