# Helper functions for integer calibration

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

def interpolate_i16(data, channel):
    """Interpolate between two channels (8bit) to be able to use 16bit channel
    numbers"""
    lowidx = channel >> 8
    highidx = lowidx + 1
    delta = data[highidx] - data[lowidx]
    deltamul = delta * (channel & 0xFF)
    addy = int(1.0 * deltamul / 256) # 1.0 for python 2 compatibility
    newy = data[lowidx] + addy
    return newy

def findpeak_center_norm_width_i16(data, centerchannel, hwidth, step = 256):
    """Improved peak finding method, calculates average channel around a 
    center channel, using a given half width (hwidth). 
    
    Center channel and hwidth should be 16bit channel values (multiply by 256).
    
    Uses only integer operations."""
    startchannel = centerchannel - hwidth
    currentchannel = startchannel
    weightedtotal = 0
    counts = 0
    while(currentchannel <= centerchannel + hwidth):
        weightedtotal += currentchannel * interpolate_i16(data, currentchannel)
        counts += interpolate_i16(data, currentchannel)
        currentchannel += step
    return weightedtotal // counts    

def findpeak_bisect_i16(data, region, width):
    """Finding peaks by bisection"""
    s = region[0] * 256
    e = region[1] * 256
    h = e - s
    while(h > 1):
        h = h >> 1
        c = s + h
        cc = findpeak_center_norm_width_i16(data, c, width * 256)
        if cc == c:
            break
        if cc > c:
            s = c
    return c


def calibrate(spectrum, peakpos, width, search):
    actualpeak = findpeak_bisect_i16(spectrum, search, width)
    dn = [0] * 256
    x = 0
    y = 0
    while(x <= 255):
        fromchannel = x * actualpeak // peakpos
        y = fromchannel >> 8
        if y > 254:
            break
        dn[x] = interpolate_i16(spectrum, fromchannel)
        dn[x] = ((dn[x] * actualpeak) >> 8) // peakpos
        x += 1
    return dn


    
def total(datalist):
    """Small helper to add all individual measurements from a longer measurement campaign. Requires a 2-dim datalist."""
    res = [0] * 256
    for i in range(len(datalist)):
        for j in range(256):
            res[j] += datalist[i][j]
    return res

def average(datalist):
    """Small helper to build the average of a loger measurement campaign. Requires a 2-dim datalist."""
    res = [0] * 256
    for i in range(len(datalist)):
        for j in range(256):
            res[j] += datalist[i][j] / len(datalist)
    return res

def calibratedtotal(datalist, peakpos, width, search):
    """Small helper to add all individual measurements from a longer measurement campaign. Requires a 2-dim datalist."""
    res = [0] * 256
    for i in range(len(datalist)):
        caldata = calibrate(datalist[i], peakpos, width, search)
        for j in range(256):
            res[j] += caldata[j]
    return res

def calibratedaverage(datalist, peakpos, width, search):
    """Small helper to build the average of a longer measurement campaign. Requires a 2-dim datalist."""
    res = [0] * 256
    for i in range(len(datalist)):
        caldata = calibrate(datalist[i], peakpos, width, search)
        for j in range(256):
            res[j] += caldata[j] / len(datalist)
    return res

def inv(c, val):
    p = c[1]/c[0]
    q = (c[2] - val) / c[0]
    return -(p/2) + np.sqrt((p/2)**2-q)

def createlookupdirect(datalist, calpeakpos, calpeake, peaks):
    linearchannel = [p[0] / calpeake * calpeakpos for p in peaks]
    peakenergies = [p[0] for p in peaks]
    peakchannel = [findpeak_bisect_i16(total(datalist), [p[3], p[4] + 1], p[2]) for p in peaks]
    
    print(peakchannel)
    f = np.polynomial.Polynomial.fit(peakchannel, linearchannel, 2)
    fitparameters = f.convert().coef
    fitparameters = fitparameters[::-1]

    fromchannel = [int(inv(fitparameters, v)) for v in range(256)]
    for i in range(len(fromchannel)):
        if fromchannel[i] < 0 or fromchannel[i] > 255 * 256:
            fromchannel[i] = 0xFFFF
    return(fromchannel)
    
def createlookup(datalist, calpeakpos, width, search, calpeake, peaks):
    linearchannel = [p[0] / calpeake * calpeakpos for p in peaks]
    peakenergies = [p[0] for p in peaks]
    peakchannel = [findpeak_bisect_i16(calibratedaverage(datalist, calpeakpos, width, search), [p[3], p[4] + 1], p[2]) for p in peaks]
    f = np.polynomial.Polynomial.fit(peakchannel, linearchannel, 2)
    fitparameters = f.convert().coef
    fitparameters = fitparameters[::-1]

    fromchannel = [int(inv(fitparameters, v)) for v in range(256)]
    for i in range(len(fromchannel)):
        if fromchannel[i] < 0 or fromchannel[i] > 255 * 256:
            fromchannel[i] = 0xFFFF
    return(fromchannel)

def adjustlookup(data, lookup):
    ret = []
    for lu in lookup:
        if lu == 0xFFFF:
            ret.append(0)
        else:
            ret.append(interpolate_i16(data, lu))
    return ret

def bindata(data, bins):
    ret = []
    start = 0
    for bb in bins:
        ret.append(sum(data[start:bb]))
        start = bb
    return ret
    
def chisquare(binned1, binned2):
    res = 0
    for i in range(0, len(binned1)):
        # if binned1[i] != 0:
        res += 1.0 * ((binned2[i] - binned1[i]) ** 2) / binned1[i]
    return res

def appleout(s):
    """Output any string for 40 char display"""
    ret = ""
    for i in range(len(s)):
        if (i > 0) and (i % 40 == 0):
            ret += "\n"
        ret += s[i:i+1]
    return ret
