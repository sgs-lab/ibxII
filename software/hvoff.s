.import __CODE_LOAD__, __BSS_LOAD__ ; Linker generated

.segment "EXEHDR"
.addr __CODE_LOAD__ ; Start address
.word __BSS_LOAD__ - __CODE_LOAD__ ; Size

.segment "RODATA"        
THVOFF:  .ASCIIZ "RAMPING HV DOWN - LEVEL: "

.segment "CODE"
        
.include "configuration.inc"
        hvstatus = $8700
        hvlevel = $8701
        LDA #hvset
        STA hvlevel

RMPOFF:
        LDX #0
        STX $24
        LDX #0
        LDA THVOFF,X ; load initial char
@LP:    ORA #$80
        JSR $FDF0 ; cout
        INX
        LDA THVOFF,X
        BNE @LP
        
        DEC hvlevel
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
        BNE RMPOFF

        LDA hvbaseaddress + 2   ; Disable HV

        ;; pause for a bit after ramping
        LDY #$FF
@LYE:   LDX #$FF
@LXE:   DEX
        BNE @LXE
        DEY
        BNE @LYE

        JMP $03D0 ; warm start
