#import multiprocessing
#pool = multiprocessing.Pool(processes=2)

import time
from datetime import timedelta
start_time = time.monotonic()

n = 100
L = 5
p = 0.5
k = 1
m = 1

#def loopa_n(n):
s = update(n, L, "U(0,L)", "Homogeneous", p, k, m)

#if __name__ == '__main__':
 #   s, counter, r = pool.map(loopa_n, [100, 200])

end_time = time.monotonic()
#print(timedelta(seconds=end_time - start_time))
