# ================== Functions ==================
import random

def calc_pi(N):
    M = 0
    for i in range(N):
        # Simulate impact coordinates
        x = random.uniform(-1, 1)
        y = random.uniform(-1, 1)

        # True if impact happens inside the circle
        if x**2 + y**2 < 1.0:
            M += 1
    return 4 * M / N

def parser(file):
    val = open(file, 'r').read()
    
    return(10**int(val))

def writer(val, file='results/res.txt'):
    val_str = f'{val}'
    
    with open(file, 'w') as f:
        f.write(val_str)

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
        "input/run.txt"
    output:
        "results/res.txt"
    run:
        N = parser(input[0])
        pi_approx = calc_pi(N)
        writer(pi_approx, output[0])

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