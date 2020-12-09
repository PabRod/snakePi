#!/usr/bin/env python
import sys
import random

# ================== Functions ==================


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


if __name__ == '__main__':
    input_file = sys.argv[1]
    output_file = sys.argv[2]

    N = parser(input_file)
    pi_approx = calc_pi(N)
    writer(pi_approx, output_file)
