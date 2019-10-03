import numpy as np
#from plot import *
#from update import *
#from radius import *
#from start import *

# Generate agents starting position
def start(n, L, dist):
    outside = 0
    start_position = 0
    if dist == 'U(0,L)':
        start_position = np.random.uniform(0,L,n)
    elif dist == 'N(mean=L/2, st.d.=L/4) cut tails':
        start_position_l = np.random.normal(L/2, L/4, 2*n)
        outside = [i for i, e in enumerate(start_position_l) if e <= 0 or e >= L]
        start_position = np.delete(start_position_l,outside)
        start_position = start_position[0:n]
    elif dist == 'Equidistant[0,L]':
        start_position = np.linspace(0, L, num = n)
    else:
        print('Wrong distribution input')
    start_position.sort()
    return start_position

start(12,1,'U(0,L)')