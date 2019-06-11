;; Configuration
;; --------------------------------------------------------------------------------
;; Hardware
;; The base addresses of the two cards (depend on slots)
;; usually HV in 2, ADC in 4
adcbaseaddress = 49344
hvbaseaddress = 49312
;; 
;; High Voltage Level
hvset = 233
;; (approx.: Vout = 1000 / 233 * hvset Volts)
;; 
;; Calibration
;; Where should the 2.614 MeV peak be after calibration
peak = 226
;; (226 is in center of 11th bin (215,237))
;;
;; Where should we look for the 2.614 MeV peak?
regionmin = 214
regionmax = 236
;;
;; Assumed half-width of peak
halfwidth = 6
;;
;; Measurement
;; Count limit for template / inspection
templatelimit = $02
;; (reference is totcount2, so total count isi templatelimit * 65536)
;;
;; First Channel of Raw Data that is used, all other channels are discarded
;; except for the storage of original spectra (measurement mode)
rawlowerchannel = 0
;;
;; First Channel of calibrated/lookup data that is used
resultlowerchannel = 13
;; 13 is first channel > 150keV when calibrating for 2614.511 in channel 226
;; 
;; Threshold for pass/fail (pass when chisquare < passthreshold)
passthreshold = $30
;;
;; Plotting
;; Vertical plot offset
plotoffset = $9F
;; How often should we plot?
plotevery = $0F            
;; (bitmask for count b8-b15, plots every (plotevery+1) * 256 counts)

