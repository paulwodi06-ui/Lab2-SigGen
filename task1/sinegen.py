import math
import string
f = open("sinerom.mem","w")
for i in range(256):
    v = int(math.cos(2*3.1416*i/256)*127+127) // This calculates the value of a cosine wave at 256 equally spaced points over one complete cycle. Adding 127 shifts the waveform upwards, so its values are suitable for an unsigned 8-bit ROM
    if (i+1)%16 == 0:
        s = "{hex:2X}\n"
    else:
        s = "{hex:2X} "
    f.write(s.format(hex=v))

f.close()