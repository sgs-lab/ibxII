import sys
import os

if len(sys.argv) != 2:
    print("Please give a file name as argument")

filename = sys.argv[1]
# hcommand = "java -jar ../ac.jar -g ibxII128-demo.dsk H{0:s} > H{0:s}".format(filename)
# lcommand = "java -jar ../ac.jar -g ibxII128-demo.dsk L{0:s} > L{0:s}".format(filename)
# print(hcommand)

# os.system(hcommand)
# os.system(lcommand)

f = open(filename + '.BIN', 'rb')
bdata = [ord(a) for a in f.read()]
f.close()
ldata = bdata[:256]
hdata = bdata[256:512]
lodata = bdata[512:768]
hodata = bdata[768:]


data = [0] * 256

for i in range(256):
    data[i] = hdata[i] * 256 + ldata[i]

f = open(filename + '.dat', 'w')
for i in range(256):
    f.write(str(data[i]) + '\n')
f.close()

data = [0] * 256

for i in range(256):
    data[i] = hodata[i] * 256 + lodata[i]

f = open(filename + '_original.dat', 'w')
for i in range(256):
    f.write(str(data[i]) + '\n')
f.close()
