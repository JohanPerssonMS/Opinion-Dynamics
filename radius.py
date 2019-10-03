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
        r = k*position + m
    elif model == 'Open center':
        l_half = [i for i, e in enumerate(position) if e <= L/2]
        if l_half == []:
            r = -k*(position - L/2) + k*L/2 + m
        elif len(l_half) == len(position):
            r = k*position + m
        else:    
            r_l = k*position[0:max(l_half) + 1] + m
            r_r = -k*(position[max(l_half)+1:] - L/2) + k*L/2 + m
            r = np.append(r_l,r_r) 
    return r
#radius(10, 0, 1, 3, 'homo', 1, 1)
