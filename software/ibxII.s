;;; Information Barrier || (Software)
;;; for template based nuclear warhead verification
;;;
;;; It currently holds many routines to output data and demo
;;; the data acquisition on an Apple II. For actual
;;; verification, these should be removed.
;;; 
;;; Copyright 2017-2019, Moritz Kütt, Alexander Glaser
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

.import __CODE_LOAD__, __BSS_LOAD__ ; Linker generated

;;; Load some useful macros (only used for debugging)
.include        "debugmacros.inc"
        
.segment "EXEHDR"
.addr __CODE_LOAD__ ; Start address
.word __BSS_LOAD__ - __CODE_LOAD__ ; Size
        
.segment "RODATA"
BINBOR:         .BYTE $11, $27, $3D, $53, $69, $7F, $95, $AB, $C1, $D7, $ED, $00
.include        "lookuptable.inc"
;; TESTL:        .BYTE $00,$00,$bc,$0d,$6b,$29,$22,$cf,$e0,$4c,$c2,$d2,$b3,$04,$20,$78,$77,$c9,$2c,$af,$a8,$9d,$37,$83,$6c,$e4,$dd,$cc,$d9,$52,$be,$80,$fd,$66,$6e,$21,$e5,$e4,$2d,$0f,$8f,$15,$9a,$2d,$6e,$bc,$fc,$49,$3d,$65,$e1,$6c,$8e,$4a,$a8,$58,$bd,$0a,$c8,$f5,$bd,$1d,$f0,$d8,$df,$22,$f2,$87,$7b,$ca,$1f,$5e,$d3,$41,$f2,$6a,$4e,$df,$85,$2f,$b0,$54,$31,$b2,$a8,$91,$4b,$58,$0b,$b7,$99,$58,$f2,$11,$69,$ff,$7f,$60,$08,$ed,$0e,$db,$55,$69,$0a,$8e,$67,$76,$f5,$04,$51,$e6,$28,$4f,$4c,$5e,$ea,$ad,$a0,$97,$9c,$9a,$b2,$95,$a0,$93,$92,$84,$c1,$9b,$b1,$c8,$a5,$a8,$a4,$9a,$96,$8e,$7c,$5e,$6f,$79,$5d,$60,$59,$65,$5d,$6c,$5b,$60,$55,$56,$57,$55,$5b,$5b,$66,$51,$60,$57,$48,$4b,$64,$49,$51,$51,$3e,$35,$4a,$52,$45,$3e,$4c,$57,$56,$60,$5b,$7c,$76,$51,$63,$60,$53,$56,$67,$55,$46,$56,$51,$42,$54,$50,$5b,$4d,$4f,$33,$3c,$37,$3d,$2e,$20,$23,$17,$25,$20,$22,$16,$1a,$28,$20,$2a,$2a,$3b,$3c,$48,$4c,$5f,$50,$83,$5f,$6c,$50,$53,$46,$32,$2d,$24,$13,$10,$0e,$0b,$0c,$0d,$0c,$0b,$0b,$0e,$08,$07,$0b,$0b,$0b,$0d,$05,$05,$0a,$0c,$08,$06,$06,$05,$06,$07,$03,$0a,$e2
;; TESTH:        .BYTE $00,$00,$05,$15,$0a,$0b,$0b,$0a,$0a,$0b,$0b,$0c,$0e,$10,$15,$15,$0e,$0c,$0c,$0b,$0b,$0b,$0c,$0c,$0b,$09,$08,$08,$08,$08,$08,$08,$07,$08,$08,$08,$07,$07,$08,$08,$07,$07,$07,$08,$09,$09,$08,$07,$07,$07,$08,$0a,$0a,$09,$07,$07,$06,$07,$06,$06,$06,$07,$06,$06,$06,$07,$06,$07,$07,$07,$08,$08,$08,$09,$08,$08,$07,$06,$06,$06,$05,$05,$05,$04,$04,$04,$04,$04,$04,$03,$03,$04,$05,$0a,$0d,$10,$11,$0e,$0a,$05,$03,$01,$01,$01,$02,$03,$05,$08,$0b,$0e,$0d,$0a,$07,$04,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00      

;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
PROMPT: .ASCIIZ " INFORMATION BARRIER EXPERIMENTAL ][ "
HVON:   .ASCIIZ "1 HV ON "
HVOFF:  .ASCIIZ "1 HV OFF"
THVON:  .ASCIIZ "RAMPING HV UP - LEVEL: "
THVOFF:  .ASCIIZ "RAMPING HV DOWN - LEVEL: "
TEM:    .ASCIIZ "2 TEMPLATE"
INS:    .ASCIIZ "3 INSPECTION"
CHCK:   .ASCIIZ "4 CHECK"
COUNTS: .ASCIIZ "TOTAL COUNTS: 0x"
CHI:    .ASCIIZ "CHI SQUARE STATISTIC: 0x"
PBIG:   .ASCIIZ "####    #   ##### ######   #  # #  #     #    ####  ##### ##### ######     #   #     #     ##     #   # ##### #####"
FBIG:   .ASCIIZ "#####   #     #   #    #      # #    #   #    ####  #####   #   #    #     #   #   #   #    #     #   #   #   #####"
IBX:    .ASCIIZ "#  ####  #   #  ### ####  #   #  # #     # #  #  ####    #      # #  #  #   #  # #     # #  #  ####  #   #  ### ###"
WEL:    .ASCIIZ "WELCOME!"
MSG:    .ASCIIZ "HAVE YOU INSPECTED A WARHEAD TODAY?"
.endif
;;; END: Only for Demo (with screen)

;;; BEGIN: Only for IB with Screen
.ifdef SCREENIB
PROMPT: .ASCIIZ "               IBX II                "
HVON:   .ASCIIZ "1 HV ON "
HVOFF:  .ASCIIZ "1 HV OFF"
THVON:  .ASCIIZ "RAMPING HV UP: "
THVOFF:  .ASCIIZ "RAMPING HV DOWN: "
TEM:    .ASCIIZ "2 TEMPLATE"
INS:    .ASCIIZ "3 INSPECTION"
CHCK:   .ASCIIZ "4 CHECK"
COUNTS: .ASCIIZ "TOTAL COUNTS: 0x"
CHI:    .ASCIIZ "CHI SQUARE STATISTIC: 0x"
PASSST: .ASCIIZ "PASS"
FAILST: .ASCIIZ "FAIL"
.endif
;;; END: Only for IB with Screen

.segment "BSS"
TEMP:    .RES 36                ; 12 * 3
INSP:    .RES 36                ; 12 * 3
SUBR:    .RES 36                ; 12 * 3
MULR:    .RES 3
OSQR:    .RES 8
REMAIND: .RES 8
DIVTMP:  .RES 8
CHIS:    .RES 8

;;; --------------------------------------------------------------------------------
;;; Main routine
;;; --------------------------------------------------------------------------------
        
.segment "CODE"

.include "configuration.inc"
        
        ;; Memory addresses
        ;; --------------------------------------------------------------------------------
        
        ;; Larger Buffers
        
        ;; Measurement data
        memorylowbyte = $8000    
        memoryhighbyte = $8100

        ;; Keep raw measurement
        originalresultlowbyte = $8200
        originalresulthighbyte = $8300

        ;; Calibration result
        calibrationbufferlowbyte = $8400
        calibrationbufferhighbyte = $8500

        ;; one buffer for plot values
        plotbuffer = $8600

        ;; $8700 page is used for some non zero page variables
        hvstatus = $8700
        hvlevel = $8701
        pc = $8702
        limit = $8703             ;limit stored in memory at 8703
        ;; need limit + 2 additional bytes free for plain measurement basic script
        rawlowerchannelpointer = $8706
        resultlowerchannelpointer = $8707
        
        bisect_s = $8710
        bisect_h = $8712        ;h is the half width of current operation
        bisect_c = $8714
        bisect_cc = $8716
        
        ;; Memory in Zero Page
        buffer = $40
        totcount0 = $41
        totcount1 = $42
        totcount2 = $43
        p1 = $44
        p2 = $46
        p3 = $48
        bincount = $4A
        threebyte = $4B
        p4 = $4E
        ;; reuse some memory for multiplication, division etc
        ;; careful, will be scrambled!
        multiplier1 = bincount
        multiplicand2 = p1
        multiplier2 = p2
        product4 = OSQR
        dividend3 = threebyte
        divisor1 = bincount
        remainder3 = REMAIND
        remainder5 = REMAIND
        divisor3 = OSQR

        weightedtotal = CHIS   ; peakfinding
        cc = p3                ;currentchannel
        counts = threebyte
        
        ;; For Calibration
        actualpeak = $30       ;2 bytes

        ;; Start
        ;; --------------------------------------------------------------------------------

        ;; Save HV status and level as off to memory
        LDA #$00
        STA hvstatus
        STA hvlevel

;;; BEGIN: Set limit/lower channel in memory based on configuration
;;; For all modes except measurement
.ifndef MEASUREONLY        
        LDA #templatelimit
        STA limit
        LDA #rawlowerchannel
        STA rawlowerchannelpointer
        LDA #resultlowerchannel
        STA resultlowerchannelpointer
.endif
;;; END: Set limit/lower channel

;; ;;; ----------------------------------------------------------------------------
;; ;;; Routines to debug internal and Python (best used with emulator).
;; ;;; Need a spectrum in TESTL and TESTH read only data

        
;;         LDX #0
;; DEBL:   LDA TESTL, X
;;         STA memorylowbyte, X
;;         LDA TESTH, X
;;         STA memoryhighbyte, X
;;         INX
;;         BNE DEBL

;;         JSR BACKUP
;;         JSR MASKRAWSPECTRUM

;;         LDX #0
;; @MOVECLEAR:      
;;         LDA memorylowbyte, X
;;         STA calibrationbufferlowbyte, X
;;         LDA memoryhighbyte, X
;;         STA calibrationbufferhighbyte, X
;;         INX
;;         BNE @MOVECLEAR

;;         JSR PEAKBISECT
;;         print2bytes actualpeak
;;         newline
;;         waitforkey
        
;;         JSR CALIBRATE

;;         LDX #0
;; DEBL2:  LDA memoryhighbyte, X
;;         JSR $FDDA
;;         LDA memorylowbyte, X
;;         JSR $FDDA
;;         space

;;         CPX #127
;;         BNE NOWAIT
;;         waitforkey
;; NOWAIT: 
;;         INX
;;         BNE DEBL2
        
;;         JMP $03D0 ; warm start
        
;; ;;; End debug internal / python routines
;; ;;; ----------------------------------------------------------------------------
        
        
;;; begin: Only for Measurements
.ifdef MEASUREONLY

        JSR MEASURE
        JSR BACKUP

        JSR MASKRAWSPECTRUM
        JSR CALIBRATE
        JSR LOOKUP
        JSR MASKRESULTSPECTRUM

        JMP $FAA6               ;'cold' start. reboots apple, but does not overwrite memory content
.endif
;;; END: Only for Measurements
        
;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
        ;; Clear screen and display friendly welcome
        JSR $FC58               ;HOME (clear screen)
        JSR WELC
.endif
;;; END: Only for Demo (with screen)

;;; BEGIN: Only for IB with Screen
.ifdef SCREENIB
        ;; Clear screen
        JSR $FC58
.endif     
;;; END: Only for IB with Screen   

OUT:
        
;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
        ;; Output prompt loop
        LDX #0
        STX $24
        LDX #19
        STX $25
        LDA #$8D ; next line
        JSR $FDED

        ;; Main prompt
        LDX #0
        LDA PROMPT,X ; load initial char
@LP:    ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA PROMPT,X
        BNE @LP
        LDA #$8D ; next line
        JSR $FDED

        ;; HV Text
        LDA hvstatus
        BNE DHVOFF
        
        LDX #0
        STX $24
        LDX #0
        LDA HVON,X ; load initial char
@LP2:    ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA HVON,X
        BNE @LP2
        JMP NEXT

DHVOFF: 
        LDX #0
        STX $24
        LDX #0
        LDA HVOFF,X ; load initial char
@LP2:    ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA HVOFF,X
        BNE @LP2

        ;; Template text
NEXT:   
        LDX #9
        STX $24
        LDX #0
        LDA TEM,X ; load initial char
@LP3:   ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA TEM,X
        BNE @LP3

        ;; Inspection text
        LDX #20
        STX $24
        LDX #0
        LDA INS,X ; load initial char
@LP5:   ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA INS,X
        BNE @LP5

        ;; Check text
        LDX #33
        STX $24
        LDX #0
        LDA CHCK,X ; load initial char
@LP6:   ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA CHCK,X
        BNE @LP6
        LDA #$8D ; next line
        JSR $FDED
.endif
;;; END: Only for Demo (with screen)

;;; BEGIN: Only for IB with Screen
.ifdef SCREENIB
        ;; Output prompt loop
        LDX #0
        STX $24
        LDX #19
        STX $25
        LDA #$8D ; next line
        JSR $FDED

        ;; Main prompt
        LDX #0
        LDA PROMPT,X ; load initial char
@LP:    ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA PROMPT,X
        BNE @LP
        LDA #$8D ; next line
        JSR $FDED

        ;; HV Text
        LDA hvstatus
        BNE DHVOFF
        
        LDX #0
        STX $24
        LDX #0
        LDA HVON,X ; load initial char
@LP2:    ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA HVON,X
        BNE @LP2
        JMP NEXT

DHVOFF: 
        LDX #0
        STX $24
        LDX #0
        LDA HVOFF,X ; load initial char
@LP2:    ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA HVOFF,X
        BNE @LP2

        ;; Template text
NEXT:   
        LDX #9
        STX $24
        LDX #0
        LDA TEM,X ; load initial char
@LP3:   ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA TEM,X
        BNE @LP3

        ;; Inspection text
        LDX #20
        STX $24
        LDX #0
        LDA INS,X ; load initial char
@LP5:   ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA INS,X
        BNE @LP5

        ;; Check text
        LDX #33
        STX $24
        LDX #0
        LDA CHCK,X ; load initial char
@LP6:   ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA CHCK,X
        BNE @LP6
        LDA #$8D ; next line
        JSR $FDED

.endif
;;; END: Only for IB with Screen

;;; No need to compile everything for measurement
.ifndef MEASUREONLY        
        ;; Look for key input
@WK:    LDA #$80
        AND $C000
        BEQ @WK
        LDA $C000
        LDX $C010

        ;; switch to right subroutine for 1-4 (beep for other keys)
        SBC #$B0                ; Substract Flag & ASCII Offset
        TAX
        DEX
        BNE N1
        LDA hvstatus
        BEQ NHVON
        JSR TGHVOFF
        JMP OUT
NHVON:  JSR TGHVON
        JMP OUT
N1:     DEX
        BNE N2
        JSR TEMPLATE
        JMP OUT
N2:     DEX
        BNE N3
        JSR INSPECT
        JMP OUT
N3:     DEX
        BNE N4
        JSR SHOWR
        JMP OUT
N4:
;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
	;; in demo mode, pressing 5 shows the individual bin results
        DEX
        BNE N5
        JSR PRIBI
        JMP OUT
.endif
;;; END: Only for Demo (with screen)
N5:     JSR $FBDD               ;Beep
        JMP OUT
.endif 
;;; measureonly
        
;;; --------------------------------------------------------------------------------
;;; SUBROUTINE MEASURE
;;; --------------------------------------------------------------------------------
MEASURE:
        
        ;; Addresses for 12-Bit ADC board
        ledaddress = adcbaseaddress
        resetaddress = adcbaseaddress + 1
        adclowaddress = adcbaseaddress + 2
        adchighaddress = adcbaseaddress + 3
        statusaddress = adcbaseaddress + 4

;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
        ;; Prepare output
        JSR $F3E2               ; HGR
        LDX #$05                ; Color 
        JSR $F6F0               ; HCOLOR
        JSR GRIDL
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
.endif
;;; END: Only for Demo (with screen)

        ;; 
        LDA #$00
        STA totcount0
        STA totcount1
        STA totcount2

        ;; Clear some memory
        LDX #$0
LPL:    LDA #$0
        STA memorylowbyte, X
        INX
        BNE LPL

        LDX #$0
LPH:    LDA #$0
        STA memoryhighbyte, X
        INX
        BNE LPH

;;; Begin of main readout loop
        CLC
        LDA resetaddress        ; ADC reset by read specific address
RSADC:  
        ;; Wait for LSB=1 in status (PD&H circuit triggered)
LS:     LDA #$01
        AND statusaddress       
        BEQ LS
        ;; Short delay - after trigger STS is not yet high immediately
        NOP
        NOP
        NOP
        NOP
        NOP                     ;5
        NOP
        NOP
        NOP
        NOP
        NOP                     ;10
        NOP
        NOP
        NOP                     ;13
        ;; Wait for Bit1=0 in status (conversion done)
LI:     LDA #$02
        AND statusaddress       
        BNE LI
        
        LDX adchighaddress
        ;; immediately reset trigger - speed up things
        LDA resetaddress        
        INC memorylowbyte, X
        BNE NOHIGH
        ;; Add something to highbit
        INC memoryhighbyte, X
NOHIGH: 
        INC totcount0
        BNE CTDONE
        ;; Incrementing totcount1, same time check if need to plot
        INC totcount1
        BNE CHPLOT
        INC totcount2
CHPLOT:

;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
        LDA #plotevery
        AND totcount1         ; Plot whenever totcount1 AND plotevery returns zero
        BNE NOPLOT

        JSR MASKRAWSPECTRUM
        
        JSR PLBFS
        JSR DRAWS
NOPLOT:
.endif
;;; END: Only for Demo (with screen)

        ;; check if count limit reached
        LDA limit
        CMP totcount2
        BEQ ENDREC
CTDONE:
        JMP RSADC
ENDREC:
;;; end of main readout loop

        
;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
        ;; one more plot
        
        JSR MASKRAWSPECTRUM
        JSR PLBFS
        JSR DRAWS
        
        ;; clear text output
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
.endif
;;; END: Only for Demo (with screen)
        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE TEMPLATE
;;; carries out measurement, stores big bin data in TEMP
;;; --------------------------------------------------------------------------------
.ifndef MEASUREONLY
TEMPLATE:
        
        JSR MEASURE

;;; set last channel to zero
        LDX #255
        LDA #0
        STA memoryhighbyte, X
        STA memorylowbyte, X

        JSR BACKUP
        JSR MASKRAWSPECTRUM
        JSR CALIBRATE
        JSR LOOKUP
        JSR MASKRESULTSPECTRUM

.ifdef DEMO
        ;; Prepare output
        JSR $F3E2               ; HGR
        LDX #$05                ; Color 
        JSR $F6F0               ; HCOLOR
        JSR GRIDL
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
        JSR PLBFS
        JSR DRAWS
.endif
        
        ;; Set p1 to Template storage
        LDA #<TEMP
        STA p1
        LDA #>TEMP
        STA p1 + 1
        
        JSR ANALY

;;;clear screen lines
.ifdef DEMO
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
.endif
        RTS
.endif
        
;;; --------------------------------------------------------------------------------
;;; SUBROUTINE INSPECT
;;; carries out measurement, stores big bin data in INSP
;;; --------------------------------------------------------------------------------
.ifndef MEASUREONLY
INSPECT:
        JSR MEASURE

;;; set last channel to zero
        LDX #255
        LDA #0
        STA memoryhighbyte, X
        STA memorylowbyte, X

        JSR BACKUP
        JSR MASKRAWSPECTRUM
        JSR CALIBRATE
        JSR LOOKUP
        JSR MASKRESULTSPECTRUM
        
.ifdef DEMO
        ;; Prepare output
        JSR $F3E2               ; HGR
        LDX #$05                ; Color 
        JSR $F6F0               ; HCOLOR
        JSR GRIDL
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
        JSR PLBFS
        JSR DRAWS
.endif

        ;; Set p1 to Inspection result storage
        LDA #<INSP
        STA p1
        LDA #>INSP
        STA p1 + 1

        JSR ANALY

;;;clear screen lines
.ifdef DEMO
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED
.endif
        
        RTS
.endif
;;; measureonly
        
;;; --------------------------------------------------------------------------------
;;; SUBROUTINE TGHVON
;;; (toggle HV on)
;;; --------------------------------------------------------------------------------
.ifndef MEASUREONLY
TGHVON:
RMPON:  LDA #$00
        STA hvbaseaddress
        LDA #$01
        STA hvstatus
        
        LDA hvbaseaddress + 1   ; Enable HV



;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
        ;; output ramping string
        LDX #0
        STX $24
        LDX #0
        LDA THVON,X ; load initial char
@LP:    ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA THVON,X
        BNE @LP
.endif
;;; END: Only for Demo (with screen)

;;; BEGIN: Only for IB with Screen
.ifdef SCREENIB
        ;; output ramping string
        LDX #0
        STX $24
        LDX #0
        LDA THVON,X ; load initial char
@LP:    ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA THVON,X
        BNE @LP
.endif
;;; END: Only for IB with Screen
        
        ;; Ramp HV
        INC hvlevel
        LDA hvlevel
        STA hvbaseaddress

;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
        ;; Output Level (still in Acc.)
        JSR $FDDA
.endif
;;; END: Only for Demo (with screen)

;;; BEGIN: Only for IB with Screen
.ifdef SCREENIB
        ;; Output Level (still in Acc.)
        JSR $FDDA
.endif
;;; END: Only for IB with Screen

        ;; pause for a bit during ramping
        LDY #$20
@LY:    LDX #$FF
@LX:    DEX
        BNE @LX
        DEY
        BNE @LY

        LDA hvlevel
        CMP #hvset
        BNE RMPON

        ;; pause for a bit after ramping
        LDY #$FF
@LYE:   LDX #$FF
@LXE:   DEX
        BNE @LXE
        DEY
        BNE @LYE

;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
        LDX #0
        STX $24
        LDX #$20
@LP7:   LDA #$A0
        JSR $FDF0 ; cout
        DEX
        BNE @LP7
.endif
;;; END: Only for Demo (with screen)

;;; BEGIN: Only for IB with Screen
.ifdef SCREENIB
        LDX #0
        STX $24
        LDX #$20
@LP7:   LDA #$A0
        JSR $FDF0 ; cout
        DEX
        BNE @LP7
.endif
;;; END: Only for IB with Screen
        
        RTS
.endif 
;;; measureonly
        
;;; --------------------------------------------------------------------------------
;;; SUBROUTINE TGHVOFF
;;; (toggle HV off)
;;; --------------------------------------------------------------------------------
.ifndef MEASUREONLY
TGHVOFF:     
RMPOFF:
;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO

        LDX #0
        STX $24
        LDX #0
        LDA THVOFF,X ; load initial char
@LP:    ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA THVOFF,X
        BNE @LP
.endif
;;; END: Only for Demo (with screen)

;;; BEGIN: Only for IB with Screen
.ifdef SCREENIB

        LDX #0
        STX $24
        LDX #0
        LDA THVOFF,X ; load initial char
@LP:    ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA THVOFF,X
        BNE @LP
.endif
;;; END: Only for IB with Screen

        DEC hvlevel
        LDA hvlevel
        STA hvbaseaddress

;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
        ;; Output Level
        JSR $FDDA
.endif
;;; END: Only for Demo (with screen)

;;; BEGIN: Only for IB with Screen
.ifdef SCREENIB
        ;; Output Level
        JSR $FDDA
.endif
;;; END: Only for IB with Screen

        ;; pause for a bit during ramping
        LDY #$20
@LY:    LDX #$FF
@LX:    DEX
        BNE @LX
        DEY
        BNE @LY

        LDA hvlevel
        BNE RMPOFF

        LDA #$00
        STA hvstatus
        
        LDA hvbaseaddress + 2   ; Disable HV

        ;; pause for a bit after ramping
        LDY #$FF
@LYE:   LDX #$FF
@LXE:   DEX
        BNE @LXE
        DEY
        BNE @LYE

;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO        
        LDX #0
        STX $24
        LDX #$20
@LP7:   LDA #$A0
        JSR $FDF0 ; cout
        DEX
        BNE @LP7
.endif
;;; END: Only for Demo (with screen)

;;; BEGIN: Only for IB with Screen
.ifdef SCREENIB
        LDX #0
        STX $24
        LDX #$20
@LP7:   LDA #$A0
        JSR $FDF0 ; cout
        DEX
        BNE @LP7
.endif
;;; END: Only for IB with Screen    
    
        RTS
.endif
;;; measureonly
        
;;; --------------------------------------------------------------------------------
;;; SUBROUTINE PLBFS
;;; prepares plot buffer from last recorded spectrum
;;; (divides count rates by 2^3)
;;; --------------------------------------------------------------------------------
;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO

PLBFS:  
        LDX #$0
LPS:    LDA memoryhighbyte, X
        STA p1 + 1
        LDA memorylowbyte, X
        STA p1
        
        LDY #$3                 ;2^3 division
SHIFTL: 
        LSR p1 + 1
        ROR p1
        DEY
        BNE SHIFTL

        ;; check if result is bigger than (plotoffset - 1)
        LDA #00
        CMP p1 + 1
        BCC ZERO
        BNE SUBS
        LDA #(plotoffset - 1)
        CMP p1
        BCC ZERO
SUBS:                           ;res < (plotoffset  - 1) --> substract plotoffset - res
        LDA #plotoffset
        SEC
        SBC p1
        STA plotbuffer, X
        JMP CLOOP
ZERO:                           ; res > (plotoffset - 1) --> set res to #01
        LDA #01
        STA plotbuffer, X
CLOOP:   
        INX
        BNE LPS
        RTS

.endif
;;; END: Only for Demo (with screen)

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE DRAWS
;;; plot spectrum from plot buffer
;;; --------------------------------------------------------------------------------
;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
DRAWS:
        LDX #0
        STX $24
        LDX #0
        LDA COUNTS,X ; load initial char
@LP3:   ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA COUNTS,X
        BNE @LP3
        LDA totcount2
        JSR $FDDA
        LDA totcount1
        LDX totcount0
        JSR $F941
        
        LDX #$0
DRAWLP: LDA plotbuffer, X
        BEQ ZEROLP
        TXA
        PHA
        
        ;; Point
        LDY #$0                ;Horizontal HI
        ;; X is Horizontal Low (and st)
        LDA #plotoffset         ;V
        JSR $F457               ;HPLOT

        PLA                     ; Load and
        PHA                     ; Store again
        TAX
        LDY plotbuffer, X       ; Vertical
        ;; A is H Low (from store)
        LDX #$0                ; H Hi
        JSR $F53A               ;HLINE

        PLA
        TAX
ZEROLP: INX
        BNE DRAWLP

        RTS
.endif
;;; END: Only for Demo (with screen)

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE GRIDL
;;; draws grid lines
;;; --------------------------------------------------------------------------------
;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO

GRIDL:  LDY #$0                 ;H HI
        LDX #$40                ; X is H Low
        LDA #plotoffset         ;V
        JSR $F457               ;HPLOT

        LDY #$0                 ;V
        LDA #$40                ;H Lo
        LDX #$0                 ; H Hi
        JSR $F53A               ;HLINE

        LDY #$0                 ;H HI
        LDX #$41                ; X is H Low
        LDA #plotoffset         ;V
        JSR $F457               ;HPLOT
        
        LDY #$0                 ;V
        LDA #$41                ;H Lo
        LDX #$0                 ; H Hi
        JSR $F53A               ;HLINE

        LDY #$0                 ;H HI
        LDX #$80                ; X is H Low
        LDA #plotoffset         ;V
        JSR $F457               ;HPLOT

        LDY #$0                 ;V
        LDA #$80                ;H Lo
        LDX #$0                 ; H Hi
        JSR $F53A               ;HLINE

        LDY #$0                 ;H HI
        LDX #$81                ; X is H Low
        LDA #plotoffset         ;V
        JSR $F457               ;HPLOT

        LDY #$0                 ;V
        LDA #$81                ;H Lo
        LDX #$0                 ; H Hi
        JSR $F53A               ;HLINE

        LDY #$0                 ;H HI
        LDX #$C0                ; X is H Low
        LDA #plotoffset         ;V
        JSR $F457               ;HPLOT

        LDY #$0                 ;V
        LDA #$C0               ;H Lo
        LDX #$0                 ; H Hi
        JSR $F53A               ;HLINE        

        LDY #$0                 ;H HI
        LDX #$C1                ; X is H Low
        LDA #plotoffset         ;V
        JSR $F457               ;HPLOT

        LDY #$0                 ;V
        LDA #$C1               ;H Lo
        LDX #$0                 ; H Hi
        JSR $F53A               ;HLINE        

        LDY #$0                 ;H HI
        LDX #$00                ; X is H Low
        LDA #plotoffset         ;V
        JSR $F457               ;HPLOT

        LDY #$0                 ;V
        LDA #$00                ;H Lo
        LDX #$0                 ; H Hi
        JSR $F53A               ;HLINE

        LDY #$0                 ;H HI
        LDX #$01                ; X is H Low
        LDA #plotoffset         ;V
        JSR $F457               ;HPLOT
        
        LDY #$0                 ;V
        LDA #$01                ;H Lo
        LDX #$0                 ; H Hi
        JSR $F53A               ;HLINE        

        LDY #$01                 ;H HI
        LDX #$00                ; X is H Low
        LDA #plotoffset         ;V
        JSR $F457               ;HPLOT

        LDY #$0                 ;V
        LDA #$00                ;H Lo
        LDX #$01                 ; H Hi
        JSR $F53A               ;HLINE

        LDY #$01                 ;H HI
        LDX #$01                ; X is H Low
        LDA #plotoffset         ;V
        JSR $F457               ;HPLOT
        
        LDY #$0                 ;V
        LDA #$01                ;H Lo
        LDX #$01                 ; H Hi
        JSR $F53A               ;HLINE        

        ;; vertical lines
        LDY #$00                 ;H HI
        LDX #$00                ; X is H Low
        LDA #$35                 ;V
        JSR $F457               ;HPLOT
        
        LDY #$35                ;V
        LDA #$01                ;H Lo
        LDX #$01                 ; H Hi
        JSR $F53A               ;HLINE        

        LDY #$00                 ;H HI
        LDX #$00                ; X is H Low
        LDA #$6A                ;V
        JSR $F457               ;HPLOT
        
        LDY #$6A                 ;V
        LDA #$01                ;H Lo
        LDX #$01                 ; H Hi
        JSR $F53A               ;HLINE        

        LDY #$00                 ;H HI
        LDX #$00                ; X is H Low
        LDA #$00                ;V
        JSR $F457               ;HPLOT
        
        LDY #$00                 ;V
        LDA #$01                ;H Lo
        LDX #$01                 ; H Hi
        JSR $F53A               ;HLINE        
        
        RTS
.endif
;;; END: Only for Demo (with screen)

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE ANALY
;;; needs p1 to be set!
;;; 
;;; summarizes last recorded spectrum in memory at the address in p1
;;; --------------------------------------------------------------------------------
ANALY:  LDA #$00                ;reset values
        LDY #$00
@RLP:   STA (p1), Y
        INY
        CPY #$24
        BNE @RLP
        
        
        LDX #$00                ;X counts channels
        LDA #$00
        STA bincount             ; counts big bins


@LP:    LDY #$00
        LDA (p1), Y
        CLC
        ADC memorylowbyte, X
        STA (p1), Y
        INY
        LDA (p1), Y
        ADC memoryhighbyte, X
        STA (p1), Y
        INY
        LDA (p1), Y
        ADC #$00                ;only add carry if necessary
        STA (p1), Y

        LDY bincount
        INX
        TXA
        CMP BINBOR, Y
        BNE @LP
        ;; move pointer to next 24bit value
        LDA #$03
        CLC
        ADC p1
        STA p1
        LDA #$00
        ADC p1 + 1
        STA p1 + 1
        LDY bincount
        INY
        STY bincount
        CPY #$0C
        BNE @LP
        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE SHOWR
;;; calculates result and shows it
;;; --------------------------------------------------------------------------------

.ifndef MEASUREONLY        
SHOWR:
;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
        JSR $FB2F               ;TEXT Mode
        JSR $FC58               ;HOME (clear screen)
.endif
;;; END: Only for Demo (with screen)

;;; BEGIN: Only for IB with Screen
.ifdef SCREENIB
        JSR $FC58               ;HOME (clear screen)
.endif
;;; END: Only for IB with Screen
        
        ;; Reset chi square result memory
        LDA #$00
        LDX #$07
@LP:    STA CHIS, X
        DEX
        BPL @LP

        ;; Set p1 to Template storage
        LDA #<TEMP
        STA p1
        LDA #>TEMP
        STA p1 + 1

        ;; Set p2 to inspection storage
        LDA #<INSP
        STA p2
        LDA #>INSP
        STA p2 + 1

        ;; substraction 24bit
        ;; Set p3 to inspection storage
        LDA #<SUBR
        STA p3
        LDA #>SUBR
        STA p3 + 1

        LDX #$00
        TXA
        PHA
BLP:    JSR OBINA


        ;; only add when template count in this channel not zero
        LDY #$02
        LDA (p1), Y
        BNE ADD
        DEY
        LDA (p1), Y
        BNE ADD
        DEY
        LDA (p1), Y
        BEQ NOADD

ADD:    
        LDX #$00
        CLC
@SLP:   LDA CHIS, X
        ADC OSQR, X
        STA CHIS, X
        INX
        TXA
        EOR #$08
        BNE @SLP

NOADD:  
        ;; move pointers to next 24bit value
        LDA #$03
        CLC
        ADC p1
        STA p1
        LDA #$00
        ADC p1 + 1
        STA p1 + 1
        LDA #$03
        CLC
        ADC p2
        STA p2
        LDA #$00
        ADC p2 + 1
        STA p2 + 1
        LDA #$03
        CLC
        ADC p3
        STA p3
        LDA #$00
        ADC p3 + 1
        STA p3 + 1

        PLA
        TAX
        INX
        TXA
        PHA
        CPX #$0C
        BNE BLP
        PLA

        ;; check higher bytes. should be zero - otherwise fail
        LDX #$07                
@LP:    LDA CHIS, X
        BNE FAIL
        DEX
        CPX #$02
        BNE @LP

        ;;byte 02 needs to be compared to passthreshold - lowest significant integer value
        LDA CHIS, X             
        CMP #passthreshold
        BCS FAIL

        ;; PASS
;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
        ;; set p1 to pass string address
        LDA #<PBIG
        STA p1
        LDA #>PBIG
        STA p1 + 1
.endif
;;; END: Only for Demo (with screen)

;;; BEGIN: Only for IB with Screen
.ifdef SCREENIB
        ;; set p1 to pass string address
        LDA #<PASSST
        STA p1
        LDA #>PASSST
        STA p1 + 1
.endif
;;; END: Only for IB with Screen     
   
        ;; In case LED would be used to display results, 
	;; it would need to be set to green here (PASS)
        
        JMP SEND
        
        ;; FAIL
FAIL:
        
;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
        ;; set p1 to fail string address
        LDA #<FBIG
        STA p1
        LDA #>FBIG
        STA p1 + 1
.endif
;;; END: Only for Demo (with screen)

;;; BEGIN: Only for IB with Screen
.ifdef SCREENIB
        ;; set p1 to fail string address
        LDA #<FAILST
        STA p1
        LDA #>FAILST
        STA p1 + 1
.endif
;;; END: Only for IB with Screen
  
        ;; In case LED would be used to display results, 
	;; it would need to be set to red here (FAIL)

SEND:   

;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
        ;; Output string
        LDX #$17
        STX bincount
        LDX #7
        STX $25
        LDA #$8D ; next line (somehow $25 is only active after another output?)
        JSR $FDED
        LDX #8
        STX $24
        LDY #0
        LDA (p1),Y ; load initial char
BL:     ORA #$80
        JSR $FDF0 ; cout
        INY
        CPY bincount
        BNE NL
        LDA #$16
        ADC bincount
        STA bincount
        LDA #$8D ; next line
        JSR $FDED
        LDA #8
        STA $24
NL:     LDA (p1),Y
        BNE BL
        LDA #$8D ; next line
        JSR $FDED

        ;; Output chi text header
        LDX #4
        STX $24
        LDX #0
        LDA CHI,X ; load initial char
@LP4:   ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA CHI,X
        BNE @LP4

        ;; output chi result
        LDX #$07
CSHLP:  LDA CHIS, X
        BEQ CNSH
        JSR $FDDA
CNSH:   DEX
        CPX #$01
        BNE CSHLP
        LDA #$AE ; period
        JSR $FDED
        LDA CHIS, X
        JSR $FDDA
        DEX
        LDA CHIS, X
        JSR $FDDA
        
        LDA #19
        STA $25
        LDA #$8D ; next line (somehow $25 is only active after another output?)
        JSR $FDED
.endif
;;; END: Only for Demo (with screen)

;;; BEGIN: Only for IB with Screen
.ifdef SCREENIB
        LDX #7
        STX $25
        LDA #$8D ; next line (somehow $25 is only active after another output?)
        JSR $FDED


        LDY #0
        LDA (p1),Y ; load initial char
@LP3:   ORA #$80
        JSR $FDF0 ; cout
        INY
        LDA (p1),Y
        BNE @LP3
        LDA #$8D ; next line 
        JSR $FDED
        
        ;; Output chi text header
        LDX #0
        LDA CHI,X ; load initial char
@LP4:   ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA CHI,X
        BNE @LP4

        ;; output chi result
        LDX #$07
CSHLP:  LDA CHIS, X
        BEQ CNSH
        JSR $FDDA
CNSH:   DEX
        CPX #$01
        BNE CSHLP
        LDA #$AE ; period
        JSR $FDED
        LDA CHIS, X
        JSR $FDDA
        DEX
        LDA CHIS, X
        JSR $FDDA
        
        LDA #19
        STA $25
        LDA #$8D ; next line (somehow $25 is only active after another output?)
        JSR $FDED
.endif
;;; END: Only for IB with Screen
        
        RTS
.endif
;;; Measureonly
        
;;; --------------------------------------------------------------------------------
;;; SUBROUTINE OBINA
;;; "OneBINAnalysis"
;;; calculates (t_x - i_x)^2 / t_x for bin x with t_x being template value and
;;; i_x inspection value.
;;; --------------------------------------------------------------------------------

.ifndef MEASUREONLY        
OBINA:
        ;; Substraction
        LDY #$00
        SEC
        LDA (p1), Y
        SBC (p2), Y
        STA (p3), Y
        INY
        LDA (p1), Y
        SBC (p2), Y
        STA (p3), Y
        INY
        LDA (p1), Y
        SBC (p2), Y
        STA (p3), Y

        ;; absolute of value if negative
        LDY #$02
        LDA (p3), Y
        BPL ISPOS
        LDA #$FF
        EOR (p3), Y
        STA (p3), Y
        DEY
        LDA #$FF
        EOR (p3), Y
        STA (p3), Y
        DEY
        LDA #$FF
        EOR (p3), Y
        SEC
        SBC #$FF
        STA (p3), Y
ISPOS:   

        LDA #$00                ; use bincount again
        STA bincount

        ;; Square the difference
        LDY #$00
        LDA (p3), Y
        STA MULR, Y
        INY
        LDA (p3), Y
        STA MULR, Y
        INY
        LDA (p3), Y
        STA MULR, Y

        LDA #$00
        STA OSQR+3              ;clear upper half of product
        STA OSQR+4
        STA OSQR+5
        LDX #$18                ;set binary count to 24
SHIR:   LSR MULR + 2
        ROR MULR + 1
        ROR MULR
        BCC ROTR
        LDA OSQR + 3
        CLC
        LDY #$00
        ADC (p3), Y
        STA OSQR + 3
        LDA OSQR + 4
        INY
        ADC (p3), Y
        STA OSQR + 4
        LDA OSQR + 5
        INY
        ADC (p3), Y
ROTR:   ROR
        STA OSQR + 5
        ROR OSQR + 4
        ROR OSQR + 3
        ROR OSQR + 2
        ROR OSQR + 1
        ROR OSQR
        DEX
        BNE SHIR

        ;; Multiply OSQR by $10000 for integer division
        LDX #$07
        LDY #$05
BMUL:   LDA OSQR, Y
        STA OSQR, X
        DEX
        DEY
        BPL BMUL
        LDA #$00
        STA OSQR, X
        DEX
        STA OSQR, X

        ;; Division
	lda #0	        ;preset REMAIND to 0
        LDY #$08
@LP1:	STA REMAIND, Y
        DEY
        BPL @LP1
	ldx #(8 * 8)    ;repeat for each bit
        stx bincount    ;use additional register (ZP) for bitcount

DIL:    ASL OSQR	;dividend lb & hb*2, msb -> Carry
        LDX #$01
@LP:    ROL OSQR, X
        INX
        TXA
        EOR #$08        ;loop includes 1-6
        BNE @LP
        LDX #$00
@LP2:   ROL REMAIND, X
        INX
        TXA
        EOR #$08
        BNE @LP2

        
        LDY #$00        ;Only divide at maximum by three significant
	LDA REMAIND, Y  ;bytes, loop with 00 for others
	SEC                     
        SBC (p1), Y     
        STA DIVTMP, Y   ;we might need result later
        INY             ;Y = 1
	LDA REMAIND, Y
        SBC (p1), Y
        STA DIVTMP, Y
        INY             ;Y = 2
	LDA REMAIND, Y
        SBC (p1), Y
        BCC skip
        STA DIVTMP, Y
        INY             ;
@LP3:	LDA REMAIND, Y
        SBC #$00
        STA DIVTMP, Y
        INY
        TYA
        EOR #$08 - 1
        BNE @LP3
	LDA REMAIND, Y
        SBC #$00
        BCC skip
        

DSL:    STA REMAIND, Y	;else save substraction result as new REMAIND,
        DEY             ;Y goes down again
	lda DIVTMP, Y
	sta REMAIND, Y
        CPY #$00
        BNE DSL
	inc OSQR 	;and INCrement result cause divisor fit in 1 times

skip:   dec bincount
	bne DIL

        RTS
.endif
;;; measureonly
        
;;; --------------------------------------------------------------------------------
;;; SUBROUTINE WELC
;;; Displays welcome screen
;;; --------------------------------------------------------------------------------
;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO

WELC:   LDA #<IBX
        STA p1
        LDA #>IBX
        STA p1 + 1

        LDX #$17
        STX bincount
        LDX #7
        STX $25
        LDA #$8D ; next line (somehow $25 is only active after another output?)
        JSR $FDED
        LDX #8
        STX $24
        LDY #0
        LDA (p1),Y ; load initial char
WBL:    ORA #$80
        JSR $FDF0 ; cout
        INY
        CPY bincount
        BNE WNL
        LDA #$16
        ADC bincount
        STA bincount
        LDA #$8D ; next line
        JSR $FDED
        LDA #8
        STA $24
WNL:    LDA (p1),Y
        BNE WBL
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED

        LDX #15
        STX $24
        LDX #0
        LDA WEL,X ; load initial char
@LP:    ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA WEL,X
        BNE @LP
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED

        LDX #3
        STX $24
        LDX #0
        LDA MSG,X ; load initial char
@LP2:   ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA MSG,X
        BNE @LP2
        LDA #$8D ; next line
        JSR $FDED
        LDA #$8D ; next line
        JSR $FDED

        RTS
.endif
;;; END: Only for Demo (with screen)

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE PRIBI (Print Bins)
;;; --------------------------------------------------------------------------------
;;; BEGIN: Only for Demo (with screen)
.ifdef DEMO
PRIBI:
        JSR $FB2F               ;TEXT Mode
        JSR $FC58               ;HOME (clear screen)

        ;; set p1 to template
        LDA #<TEMP
        STA p1
        LDA #>TEMP
        STA p1 + 1

        ;; set p2 to inspection result
        LDA #<INSP
        STA p2
        LDA #>INSP
        STA p2 + 1

        LDY #0
ploop:  space
        LDA #$B0
        JSR $FDF0
        LDA #$F8
        JSR $FDF0

        LDA #$B0
        JSR $FDF0
        LDA #$F8
        JSR $FDF0

        LDA #$03
        CLC
        ADC p1
        STA p1
        LDA #$00
        ADC p1 + 1
        STA p1 + 1

        LDA #$03
        CLC
        ADC p2
        STA p2
        LDA #$00
        ADC p2 + 1
        STA p2 + 1
        
        INY
        CPY #$0C
        BNE ploop
        
        RTS
.endif
;;; END: Only for Demo (with screen)

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE MASKRAWSPECTRUM
;;; sets last channel to zero --> collects all pulses >= last channel energy
;;; sets an adjustable number of low channels to zero
;;; --------------------------------------------------------------------------------
MASKRAWSPECTRUM:
                
;;; set last channel to zero
        LDX #255
        LDA #0
        STA memoryhighbyte, X
        STA memorylowbyte, X

;;; set channels up to rawlowerchannel to zero
        LDX rawlowerchannelpointer
        
        LDA #0
        DEX
FIRSTZ: 
        STA memoryhighbyte, X
        STA memorylowbyte, X
        DEX
        BPL FIRSTZ              ; Loop for X >= 0

        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE MASKRESULTSPECTRUM
;;; sets an adjustable number of low channels to zero
;;; --------------------------------------------------------------------------------
MASKRESULTSPECTRUM:
;;; set last channel to zero
        LDX #255
        LDA #0
        STA memoryhighbyte, X
        STA memorylowbyte, X

;;; set channels up to rawlowerchannel to zero
        LDX resultlowerchannelpointer
        
        LDA #0
        DEX
@RESFIR:
        STA memoryhighbyte, X
        STA memorylowbyte, X
        DEX
        BPL @RESFIR              ; Loop for X >= 0

        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE CALIBRATE
;;; adjusts spectrum so that the peak found in actualpeak will be in the channel
;;; number stored in 'peak'
;;; --------------------------------------------------------------------------------

CALIBRATE:

        
;;;     Move data to calibrationbuffer and set data to 0
        LDX #0
MOVECLEAR:      
        LDA memorylowbyte, X
        STA calibrationbufferlowbyte, X
        LDA memoryhighbyte, X
        STA calibrationbufferhighbyte, X
        LDA #0
        STA memorylowbyte, X
        STA memoryhighbyte, X
        INX
        BNE MOVECLEAR

;;;     Find peak and store 16bit location
        JSR PEAKBISECT
        
;;; loop until i_8 is 255 (or interpol_end 255)
        LDX #$00
        STX pc                  ; variable to check for double loop
CHL:

;;;     fromchannel = x * actualpeak // peakpos
        JSR FROMCHANNEL         ;leaves result in dividend3
        ;; y = fromchannel >> 8
        ;; if y > 254:
        ;;     break
        LDY dividend3 + 1       ; second byte is lower channel
        CPY #255
        BEQ ENDC
        CPY pc                  ; extra checks to avoid second cycle
        BCC ENDC
        STY pc

        STY p1 + 1
        LDA dividend3
        STA p1
        JSR INTERPOLATE         ; takes valx in p1, y in p1 + 1, leaves result in p1
        
        ;; dn[x] = ((interpol * actualpeak) >> 8) // peakpos 
        ;; p1 is same address as multiplicand2, no need to move things
        ;; interpol * actualpeak
        LDA actualpeak
        STA multiplier2
        LDA actualpeak + 1
        STA multiplier2 + 1
        JSR MUL2BY2

        ;; (() >> 8) // peakpos
        LDA product4 + 1
        STA dividend3
        LDA product4 + 2
        STA dividend3 + 1
        LDA product4 + 3
        STA dividend3 + 2
        LDA #peak
        STA divisor1

        JSR DIV3BY1

        LDA dividend3
        STA memorylowbyte, X
        LDA dividend3 + 1
        STA memoryhighbyte, X

        ;; newline
        INX
        CPX #$00
        BNE CHL
ENDC:
        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE INTERPOLATE
;;; interpolate between two 8bit channel values using a 16bit channel value
;;; --------------------------------------------------------------------------------
        
INTERPOLATE:
        ;; topy = spectrum[y + 1] - spectrum[y]
        PHA
        TXA
        PHA
        TYA
        PHA
        LDX #0

        ;; store valx / lower channel byte in multiplier for later
        LDA p1
        STA multiplier1

        ;; load Y from p1 + 1
        LDY p1 + 1

        INY
        LDA calibrationbufferlowbyte, Y ; Y + 1
        DEY
        SEC
        SBC calibrationbufferlowbyte, Y
        STA multiplicand2
        INY
        LDA calibrationbufferhighbyte, Y ; Y + 1
        DEY
        SBC calibrationbufferhighbyte, Y
        STA multiplicand2 + 1

        BPL NOTC                ; check if negative, build two's complement
        LDX #1
        EOR #$FF
        STA multiplicand2 + 1
        LDA multiplicand2
        EOR #$FF
        CLC
        ADC #$01
        STA multiplicand2
        LDA multiplicand2 + 1
        ADC #$00
        STA multiplicand2 + 1
NOTC:
        ;; valx = fromchannel & 0xFF
        ;; multiplier should be loaded already

        ;; delta = (topy * valx) >> 8
        JSR MUL2BY1
        LDA MULR + 1
        STA multiplicand2
        LDA MULR + 2
        STA multiplicand2 + 1

        ;; if it was negative, build two's complement again
        DEX
        BNE NOTC2

        LDA multiplicand2 + 1
        EOR #$FF
        STA multiplicand2 + 1
        LDA multiplicand2
        EOR #$FF
        CLC
        ADC #$01
        STA multiplicand2
        LDA multiplicand2 + 1
        ADC #$00
        STA multiplicand2 + 1
NOTC2:  
        CLC
        LDA calibrationbufferlowbyte, Y
        ADC multiplicand2
        STA p1
        LDA calibrationbufferhighbyte, Y
        ADC multiplicand2 + 1
        STA p1 + 1
        
        PLA
        TAY
        PLA
        TAX
        PLA
        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE FROMCHANNEL
;;; simply calculates x * actualpeak / peakpos
;;; --------------------------------------------------------------------------------
        
FROMCHANNEL:
;;;     x * actualpeak
;;;     multiplication uses MULR 
;;;     peakl in p[0], peakh in p[1], 0 in p[2]
        LDA actualpeak
        STA multiplicand2
        LDA actualpeak + 1
        STA multiplicand2 + 1
        STX multiplier1
        JSR MUL2BY1             ; stores result in MULR

        ;; divide by peakpos
        LDA #peak
        STA divisor1
        LDA MULR + 2
        STA dividend3 + 2
        LDA MULR + 1
        STA dividend3 + 1
        LDA MULR
        STA dividend3
        JSR DIV3BY1
        RTS


;;; --------------------------------------------------------------------------------
;;; SUBROUTINE mul3by1
;;; multiplication of 3 bytes by 1 bytes (yields 4 byte result)
;;; --------------------------------------------------------------------------------

MUL2BY1:
        ;; using multiplier1 (1) and multiplicand2 (2)
        ;; and MULR (3) for result
        PHA
        TXA
        PHA
        
        LDA #0
	STA MULR + 2            ; clear product
	STA MULR + 1
        STA MULR  
	LDX #$08		; set binary count to 08
SHIFTR: LSR multiplier1         ; divide multiplier by 2
        BCC ROTR2               ; if zero, just rotate product
	LDA MULR + 1     	; get upper part of product and add multiplicand
        CLC
        ADC multiplicand2
	STA MULR + 1
        LDA MULR + 2
        ADC multiplicand2 + 1
ROTR2:  ROR                     ; rotate partial product
        STA MULR + 2
        ROR MULR + 1
        ROR MULR
        DEX
        BNE SHIFTR
        PLA
        TAX
        PLA
        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE mul2by2
;;; multiplication of 2 bytes by 2 bytes (yields 4 byte result)
;;; --------------------------------------------------------------------------------
        
MUL2BY2:
        ;; using multiplier2 and multiplicand2
        ;; and product4 for result
        PHA
        TXA
        PHA
        LDA #0
	STA product4 + 3        ; clear product
	STA product4 + 2
        STA product4 + 1
        STA product4 
	LDX #$10		; set binary count to 16
SHIFT3: LSR multiplier2 + 1     ; divide multiplier by 2
        ROR multiplier2
        BCC ROTR3               ; if zero, just rotate product
	LDA product4 + 2     	; get upper part of product and add multiplicand
        CLC
        ADC multiplicand2
        STA product4 + 2
        LDA product4 + 3
        ADC multiplicand2 + 1
ROTR3:  ROR                     ; rotate partial product
        STA product4 + 3
        ROR product4 + 2
        ROR product4 + 1
        ROR product4
        DEX
        BNE SHIFT3
        PLA
        TAX
        PLA
        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE div3by1
;;; division of 3 bytes by 1 byte
;;; --------------------------------------------------------------------------------
        
DIV3BY1:
        PHA
        TXA
        PHA
        TYA
        PHA
        
        LDA #0                  ; set remainder to 0
        STA remainder3
        STA remainder3 + 1
        STA remainder3 + 2
        
        LDX #24
DIVL:   ASL dividend3
        ROL dividend3 + 1
        ROL dividend3 + 2
        ROL remainder3
        ROL remainder3 + 1
        ROL remainder3 + 2
        LDA remainder3
        SEC
        SBC divisor1
        TAY
        LDA remainder3 + 1
        SBC #$00
        STA buffer
        LDA remainder3 + 2
        SBC #$00
        BCC SKIP
        STA remainder3 + 2
        LDA buffer
        STA remainder3 + 1
        STY remainder3
        INC dividend3
SKIP:
        DEX
        BNE DIVL
        
        PLA
        TAY
        PLA
        TAX
        PLA
        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE DIV5BY3
;;; division of 5 bytes by 3 bytes
;;; --------------------------------------------------------------------------------
DIV5BY3:
        LDA #0                  ; set remainder to 0
        STA remainder5
        STA remainder5 + 1
        STA remainder5 + 2
        STA remainder5 + 3
        STA remainder5 + 4

        LDX #40
@DIVL:  ASL dividend5
        ROL dividend5 + 1
        ROL dividend5 + 2
        ROL dividend5 + 3
        ROL dividend5 + 4
        ROL remainder5
        ROL remainder5 + 1
        ROL remainder5 + 2
        ROL remainder5 + 3
        ROL remainder5 + 4
        LDA remainder5
        SEC
        SBC divisor3
        STA DIVTMP
        LDA remainder5 + 1
        SBC divisor3 + 1
        STA DIVTMP + 1
        LDA remainder5 + 2
        SBC divisor3 + 2
        STA DIVTMP + 2
        LDA remainder5 + 3
        SBC #$00
        STA DIVTMP + 3
        LDA remainder5 + 4
        SBC #$00
        BCC @SKIP
        STA remainder5 + 4
        LDA DIVTMP + 3
        STA remainder5 + 3
        LDA DIVTMP + 2
        STA remainder5 + 2
        LDA DIVTMP + 1
        STA remainder5 + 1
        LDA DIVTMP
        STA remainder5
        INC dividend5
@SKIP:
        DEX
        BNE @DIVL

        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE PEAKCENTER
;;; calculates the average channel of a distribution
;;; around a centerchannel +/- halfwidth
;;; --------------------------------------------------------------------------------
        
PEAKCENTER:
        TXA
        PHA
        TYA
        PHA
        
        ;; p2 centerchannel

        LDA #0
        STA threebyte
        STA threebyte + 1
        STA threebyte + 2
        STA weightedtotal
        STA weightedtotal + 1
        STA weightedtotal + 2
        STA weightedtotal + 3
        STA weightedtotal + 4
        
        LDA p2 + 1
        SEC
        SBC #halfwidth        ; substract searchwidth * 256
        STA cc + 1
        LDA p2
        STA cc

        LDX #(halfwidth * 2 + 1)

NORML:  
        LDA cc
        STA p1
        LDA cc + 1
        STA p1 + 1
        JSR INTERPOLATE
        
        ;; counts += interpolate_i16(data, currentchannel)
        CLC
        LDA threebyte
        ADC p1
        STA threebyte
        LDA threebyte + 1
        ADC p1 + 1
        STA threebyte + 1
        LDA threebyte + 2
        ADC #0
        STA threebyte + 2

        LDA cc
        STA multiplier2
        LDA cc + 1
        STA multiplier2 + 1
        JSR MUL2BY2

        CLC
        LDA weightedtotal
        ADC product4
        STA weightedtotal
        LDA weightedtotal + 1
        ADC product4 + 1
        STA weightedtotal + 1
        LDA weightedtotal + 2
        ADC product4 + 2
        STA weightedtotal + 2
        LDA weightedtotal + 3
        ADC product4 + 3
        STA weightedtotal + 3
        LDA weightedtotal + 4
        ADC #00
        STA weightedtotal + 4
        
        
        LDA cc + 1
        ADC #$01
        STA cc + 1

        DEX
        BNE NORML

        dividend5 = weightedtotal
        LDA threebyte
        STA divisor3
        LDA threebyte + 1
        STA divisor3 + 1
        LDA threebyte + 2
        STA divisor3 + 2
        
        JSR DIV5BY3
        LDA dividend5
        STA threebyte
        LDA dividend5 + 1
        STA threebyte + 1
        LDA dividend5 + 2
        STA threebyte + 2

        PLA
        TAY
        PLA
        TAX
        
        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE PEAKBISECT
;;; does a binary search in an area for an area that has the average channel
;;; matching its center channel
;;; --------------------------------------------------------------------------------
        
PEAKBISECT:
        ;; needs 0x8750-8760 memory (bisect_s, bisec_h, bisec_c, bisec_cc)
        
        ;; s = region[0] * 256
        LDA #0
        STA bisect_s            ; set low bytes to 0. 
        STA bisect_h
        LDA #regionmin
        STA bisect_s + 1        ; store in high byte
        ;; h = e - s
        LDA #regionmax + 1
        SEC
        SBC bisect_s + 1
        STA bisect_h + 1        ; only need to substract high bytes. low bytes are 0

BISECTLOOP:
        ;; h = h >> 1
        LSR bisect_h + 1
        ROR bisect_h
        ;; c = s + h
        CLC
        LDA bisect_s
        ADC bisect_h
        STA bisect_c
        STA p2
        LDA bisect_s + 1
        ADC bisect_h + 1
        STA bisect_c + 1
        STA p2 + 1
        ;; cc = findpeak_center_norm_width_i16(data, c, width * 256)
        JSR PEAKCENTER          ; uses p1, threebytes, p2, weightedtotal, cc
        ;; compare cc to c
        LDA threebyte + 1       ;cc
        CMP bisect_c + 1        ;c
        BNE CCNOTEQUALC
        LDA threebyte           ;cc
        CMP bisect_c            ;c
        BNE CCNOTEQUALC
        ;; if we get here, cc = c
        ;; and we are done with bisecting
        JMP CCEQUALC
CCNOTEQUALC:
        ;; if we get here, either high or low byte of cc != c
        BCC CCLESSC
        ;; if we get here, cc > c
        ;; s = c
        LDA bisect_c
        STA bisect_s
        LDA bisect_c + 1
        STA bisect_s + 1
CCLESSC:
        ;; h > 1 --> continue
        LDA #0
        CMP bisect_h + 1
        BNE BISECTLOOP
        LDA #1
        CMP bisect_h
        BCC BISECTLOOP          ; 1 < bisect_h
CCEQUALC:
        ;; copy result
        LDA bisect_c + 1
        STA actualpeak + 1
        LDA bisect_c
        STA actualpeak
        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE LOOKUP
;;; adjusts spectrum according to lookup table
;;; --------------------------------------------------------------------------------
        
LOOKUP:
        LDX #0
MOVELU:      
        LDA memorylowbyte, X
        STA calibrationbufferlowbyte, X
        LDA memoryhighbyte, X
        STA calibrationbufferhighbyte, X
        LDA #0
        STA memorylowbyte, X
        STA memoryhighbyte, X
        INX
        BNE MOVELU

        LDX #0
LOOKUPLOOP:
        
        LDA LOOKUPL, X
        STA p1
        LDY LOOKUPH, X
        STY p1 + 1
        CPY #$FF
        BNE DOINTERPOLATION
        CMP #$FF
        BNE DOINTERPOLATION
        ;; if both are ff, we just keep zero in channel and go to next
        JMP INCX

DOINTERPOLATION:        

        JSR INTERPOLATE

        LDA p1
        STA memorylowbyte, X
        LDA p1 + 1
        STA memoryhighbyte, X

INCX:   
        INX
        BNE LOOKUPLOOP
        
        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINE BACKUP
;;; makes a "backup", just copies data to originalresultlowbyte & highbyte
;;; --------------------------------------------------------------------------------
        
BACKUP:
        LDX #0
BACKUPL:        
        LDA memorylowbyte, X
        STA originalresultlowbyte, X
        LDA memoryhighbyte, X
        STA originalresulthighbyte, X

        INX
        BNE BACKUPL

        RTS

;;; --------------------------------------------------------------------------------
;;; SUBROUTINES for Debugging
;;; debugging routines for substraction, multiplication, division
;;; --------------------------------------------------------------------------------
;;; uncomment if needed
;; SUBPRINT:
;;         PHA
;;         PHP
;;         LDA multiplicand2 + 1
;;         JSR $FDDA
;;         LDA multiplicand2
;; 	JSR $FDDA
;;         space
;;         PLP
;;         PLA
;;         RTS
        
;; MULPRINT:
;;         LDA MULR + 2
;;         JSR $FDDA
;;         LDA MULR + 1
;;         JSR $FDDA
;;         LDA MULR
;;         JSR $FDDA
;;         space
;;         RTS

;; MUL2BY2PRINT:
;;         LDA product4 + 3
;;         JSR $FDDA
;;         LDA product4 + 2
;;         JSR $FDDA
;;         LDA product4 + 1
;;         JSR $FDDA
;;         LDA product4
;;         JSR $FDDA
;;         space
;;         RTS
