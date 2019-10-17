# Update positions
import numpy as np
#from plot import *
from update import *
from radius import *
from start import *
    
def update(n, L, dist, model, prop, k, m):
    position = start(n, L, dist)
    position_plus_t1 = np.zeros(n)
    counter = 0
    save_positions = [position]  
    sqrt_machine_epsilon = np.sqrt(np.finfo(np.float64).eps)
    while any(np.around(position_plus_t1,3) != np.around(position,3)):
        counter = counter + 1
        N = np.zeros(n)
        nrN = np.zeros(n)
        if all(position_plus_t1 == np.zeros(n)):
            position = position      
        else:
            position = position_plus_t1
        r = radius(n, L, k, m, model, prop, position)
        if counter == 1:
            r_old = r
        if model == "Proportion open":
            r = r_old
      # Find neighbors to the right  
        for i in range(n):
            if r[i] == 0:
                N[i] = N[i] + position[i]
                nrN[i] = nrN[i] + 1
                continue
            j = i
            while j < n and position[j] - position[i] <= r[i] + sqrt_machine_epsilon:
                N[i] = N[i] + position[j]
                nrN[i] = nrN[i] + 1
                j = j + 1              
      # Find neighbors to the left
        for i in reversed(range(n)):
            if r[i] == 0:
                N[i] = N[i] + position[i]
                nrN[i] = nrN[i] + 1
                continue
            j = i
            while j >= 0 and position[i] - position[j] <= r[i] + sqrt_machine_epsilon:
                N[i] = N[i] + position[j]
                nrN[i] = nrN[i] + 1
                j = j - 1      
      # Update
        N = N - position
        nrN = nrN - 1
        position_plus_t1 = N/nrN
        save_positions.append(position_plus_t1)       
            
  # Output
    save_positions = np.array(save_positions)
    save_positions = np.around(save_positions, 3)
    save_positions = np.delete(save_positions,counter,0)

    return save_positions, counter, r


#update(14, 4, 'U(0,L)', 'Proporition closed')