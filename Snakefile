DATS = [f"results/run_0{i}.txt" for i in range(8)]

# ================== Workflow ==================
rule all:
    input:
        DATS

rule set_path:
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
        run="input/{file}.txt",
        path="results/.gitkeep"
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
        "dag.svg"
    shell:  
        """
        snakemake --forceall --dag | dot -Tsvg > {output}
        """