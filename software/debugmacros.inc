;;; Information Barrier ][ (Software)
;;; for template based nuclear warhead verification
;;;
;;; It currently holds many routines to output data and demo
;;; the data acquisition on an Apple II. For actual
;;; verification, these should be removed.
;;; 
;;; Copyright 2017, Moritz Kütt, Alexander Glaser
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

;;; --------------------------------------------------------------------------------
;;; Debugging Macros (general use)
;;; --------------------------------------------------------------------------------

.macro axy
        PHA
        JSR $FDDA               ; print a
        LDA #$20                ; load <space> char 
        JSR $FDED               ; cout
        TXA
        JSR $FDDA               ; print a
        LDA #$20                ; load <space> char 
        JSR $FDED               ; cout
        TYA
        JSR $FDDA               ; print a
        LDA #$20                ; load <space> char 
        JSR $FDED               ; cout
        LDA #$8D                ; next line
        JSR $FDED               ; cout
        PLA
.endmacro

.macro waitforkey
.scope
        PHA
        TXA
        PHA
@WK:    LDA #$80
        AND $C000
        BEQ @WK
        LDA $C000
        LDX $C010
        PLA
        TAX
        PLA
.endscope
.endmacro

.macro printaddress pointer
        PHA
        LDA #>pointer
        JSR $FDDA
        LDA #<pointer
        JSR $FDDA
        LDA #$8D                ; next line
        JSR $FDED               ; cout
        PLA
.endmacro

.macro print2bytes pointer
        PHA
        LDA pointer + 1
        JSR $FDDA
        LDA pointer
        JSR $FDDA
        PLA
.endmacro        

.macro print3bytes pointer
        PHA
        LDA pointer + 2
        JSR $FDDA
        LDA pointer + 1
        JSR $FDDA
        LDA pointer
        JSR $FDDA
        PLA
.endmacro        
        
.macro printbin pointer
        PHA
        TYA
        PHA
        LDY #2
        LDA (pointer), Y
        JSR $FDDA
        DEY
        LDA (pointer), Y
        JSR $FDDA
        DEY
        LDA (pointer), Y
        JSR $FDDA
        PLA
        TAY
        PLA
.endmacro

.macro newline         
        PHA
        LDA #$8D                ; next line
        JSR $FDED               ; cout
        PLA
.endmacro

.macro space
        PHA
        LDA #$A0                ; space char
        JSR $FDED               ; cout
        PLA
.endmacro
