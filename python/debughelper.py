##%%
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import Divider, LocatableAxes, Size
import numpy as np
import sys
import pandas as pd
import os
import copy

from mpl_toolkits.axes_grid1 import Divider, LocatableAxes, Size

import intcal

binlist = [0x11, 0x27, 0x3d, 0x53, 0x69, 0x7f, 0x95, 0xab, 0xc1, 0xd7, 0xed, 0xff]
binlist0 = [0] + binlist
binwidth = [binlist0[i] - binlist0[i - 1] for i in range(1, len(binlist0))]

def getunmodifieddata(folder, length, eliminatelower = 0):
    filename = folder
    data = []
    for i in range(1, length + 1):
        f = open(prefix + filename + "/M{:03d}_original.dat".format(i), 'r')
        tdata = f.readlines()
        fdata = [int(n) for n in tdata]
        f.close()
        if eliminatelower > 0:
            for j in range(eliminatelower):
                fdata[j] = 0
        data.append(fdata)
    return data
                                    
calibrationpeak = [2614.511, 226, 8, 218, 240, 5]
lookuppeaks = [[2614.511, 226, 8, 218, 240, 5],
               [238.632, 15, 1, 12, 18, 3],
               [1173.228, 100, 3, 95, 105, 5],
               [1332.492, 114, 3, 109, 119, 5]]


prefix = "./"

# Read Data that is used for lookup table
co1 = getunmodifieddata('Co-WR-1-data', 50)
cocs1 = getunmodifieddata('Co-Cs-WR-1-data', 50)
cocs2 = getunmodifieddata('Co-Cs-WR-2-data', 50)


lowb  = "TESTL:        .BYTE "
highb = "TESTH:        .BYTE "
for i in range(256):
    lowb += "${:02x},".format(int(cocs1[0][i]) &  0xFF)
    highb += "${:02x},".format(int(cocs1[0][i]) >> 8)
lowb = lowb.rstrip(",")
highb = highb.rstrip(",")
print(lowb)
print(highb)