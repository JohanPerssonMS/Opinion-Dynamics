import numpy as np
#from plot import *
#from update import *
#from radius import *
from start import *
  
def radius(n, L, k, m, model, prop_openminded, position):
    r = 0
    r_l = 0
    r_r = 0
    if model == 'Homogeneous':
        r = np.ones(n)
    elif model == 'Proportion open':       
        r = np.zeros(n)
        while sum(r) < np.round(n*prop_openminded, 0):
            index = np.random.choice(n,1)
            r[index] = 1
    elif model == 'Open right':
        position = position/L
        r = k*position + m
    elif model == 'Open center':
        print('in github')
        l_half = [i for i, e in enumerate(position) if e <= L/2]
        r_half = [i for i, e in enumerate(position) if e > L/2]
        r_l = k*position[l_half] + m
        r_r = -k*(position[r_half] - L/2) + k*L/2 + m
        r = np.append(r_l,r_r)
        r = r/L # Scale
    return r
#radius(10, 2, 1, 0, 'Open center', 1, p)
