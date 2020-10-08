#include <p18F45K50.inc>
    
    CONFIG WDTEN = OFF	    ; Disable the watchdog timer.
    CONFIG MCLRE = ON	    ; MCLEAR pin is on.
    CONFIG DEBUG = ON	    ; Enable debug mode.
    CONFIG LVP = ON	    ; Low-voltage programming is on.
    CONFIG PBADEN = OFF	    ; RB[5:0] will be configured as digital inputs (datasheet, pg. 133)
    CONFIG FOSC = INTOSCIO  ; Internal oscillator (port function on RA6)

    ; Used for looking up the LED segment configuration.
    VAL0 EQU 0x00
    
    ORG 0x0000
    BCF INTCON, INT0IF
    GOTO Start

    ORG 0x0008		; Interrupt vector.
Int_Vector:
    BTFSC INTCON, INT0IF
    BRA Set_VAL0
    RETFIE		; Return from interrupt enable.
    
Set_VAL0:
    MOVLW 0x06
    SUBWF VAL0, 0
    BNZ Call_Lookup
    CLRF INDF0		; VAL0 indirectly modified (cleared).
    
Call_Lookup:
    MOVF VAL0, 0
    CALL Lookup_LED
    MOVWF PORTD
    BCF INTCON, INT0IF
    INCF INDF0, 1	; VAL0 indirectly modified (incremented).
    BRA Int_Vector

Lookup_LED:
    MULLW 0x02
    MOVF PRODL, 0
    ADDWF PCL, 1
    RETLW b'11001000'	; H
    RETLW b'10110000'	; E
    RETLW b'11110001'	; L
    RETLW b'11110001'	; L
    RETLW b'10000001'	; O

Start:
    CLRF PORTB
    CLRF LATB
    CLRF TRISB
    BSF TRISB, 4	; RB4 (push button) used for input.
    BSF TRISB, 0	; RB0 used to activate interrupt.
    
    CLRF PORTD		; PORTD used for 7-segment LED display.
    CLRF LATD
    CLRF TRISD		; Clear PORTD and use it for output.

    ; Configure interrupts.
    MOVLW b'10010000'	; INT0 enabled.
    MOVWF INTCON
    MOVLW b'10000000'	; INT0's interrupt occurs on falling edge.
    MOVWF INTCON2
    
    ; Setting up indirect addressing.
    LFSR 0, VAL0    ; If VAL0 needs to be modified, it will be done
		    ; through INDF0.
       
    CLRF INDF0
    
    MOVLW 0xFE
    MOVWF PORTD		; LED will show '-' (a hyphen).
    
Main:
    BRA Main

end
