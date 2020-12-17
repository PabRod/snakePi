import sys
import random

# ================== Functions ==================
def calc_pi(N):
    """ Estimates pi using Monte-Carlo """
    M = 0 # Initialize the counter
    for i in range(N):
        # Simulate impact coordinates
        x = random.uniform(-1, 1)
        y = random.uniform(-1, 1)

        # True if impact happens inside the circle
        if x**2 + y**2 < 1.0:
            M += 1

    return 4 * M / N


def parser(file):
    """ Parses the simulation settings from file """
    # Our file is remarkably simple: it just contains one integer
    #
    # The parser just extracts that number ...
    val = open(file, 'r').read()

    # ... and returns it as an integer
    return(int(val))


def writer(val, file):
    """ Writes a value to a file """
    val_str = f'{val:.8f}' # Keep decimals enough

    with open(file, 'w') as f:
        f.write(val_str)


N = parser(snakemake.input['run'])
pi_approx = calc_pi(N)
writer(pi_approx, snakemake.output[0])
