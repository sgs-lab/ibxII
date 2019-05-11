.import __CODE_LOAD__, __BSS_LOAD__ ; Linker generated

.segment "EXEHDR"
.addr __CODE_LOAD__ ; Start address
.word __BSS_LOAD__ - __CODE_LOAD__ ; Size

.segment "RODATA"        
THVON:  .ASCIIZ "RAMPING HV UP - LEVEL: "

.segment "CODE"

.include "configuration.inc"        
        hvstatus = $8700
        hvlevel = $8701
        LDA #0
        STA hvlevel

RMPON:  LDA #$00
        STA hvbaseaddress
        LDA #$01
        STA hvstatus
        
        LDA hvbaseaddress + 1   ; Enable HV

        LDX #0
        STX $24
        LDX #0
        LDA THVON,X ; load initial char
@LP:    ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA THVON,X
        BNE @LP
        
        ;; Ramp HV
        INC hvlevel
        LDA hvlevel
        STA hvbaseaddress
        JSR $FDDA

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

        JMP $03D0 ; warm start
