from pyden.connect.encoder import UniversalEncoder
use = UniversalEncoder('0.0.0.0', 8500)
import time
start = time.time()
asdf = []
for i in range(10000): asdf.append("how fast can we encode this sentence?")
use.encode(asdf)
print(time.time() - start)
