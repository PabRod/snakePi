# ================== Auxiliary ==================

# Generate the filenames of the desired output files
# ["results/run_01.txt", "results/run_02.txt", ...]
DATS = [f"results/run_0{i}.txt" for i in range(8)]

# ================== Workflow ==================
rule gather:
    input:
        DATS
    run:
        import numpy as np

        vals = [float(open(file, 'r').read()) for file in DATS]
        pi_best = np.mean(vals)

        print(f'The value of pi is approximately: {pi_best}')

# Create the folder structure
rule set_path:
    output:
        "results/.gitkeep"
    shell:
        """
        mkdir -p $(dirname {output})
        touch {output}
        """

# Process the files
rule get_pi:
    input:
        script="process.py",
        run="input/{file}.txt",
        path="results/.gitkeep"
    output:
        "results/{file}.txt"
    shell:
        "python {input.script} {input.run} {output}"

# Clean output
rule clean:
    shell:
        """
        rm -rf results/
        """