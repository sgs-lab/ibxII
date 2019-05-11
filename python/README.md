# Python Tools for IBX II Software

A number of python scripts to help with the assembler software:
* intcal.py is a small module that implements calibration and lookup using only integer multiplications (blueprint for assembler)
* createlookup.py can be used to recreate the lookup table for non-linear corrections in spectrum. It currently uses the three sets of measurements also in the folder
* convert.py can be used to convert the binary files from the Apple IIe into text files with the spectrum

The measurements have all been taken on February 25, 2019 using small laboratory sources and thoriated welding rods. Two laboratory test sources (Co-60, Cs-137) were used. The laboratory sources have a nominal strength of 1µCi at production time, and are both approx. 4 years old. The Co-60 source was always placed directly under the scintillator cristal, the Cs-137 source (if present) either 4 or 8 inches away from the center of the Co-60 source. Each setup (no Cs-137, 4 inch, 8 inch) was measured 50 times with 2^18 total counts per measurement.
