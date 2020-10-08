#include <p18F45K50.inc>
    
    CONFIG WDTEN = OFF	    ; Disable the watchdog timer.
    CONFIG MCLRE = ON	    ; MCLEAR pin is on.
    CONFIG DEBUG = ON	    ; Enable debug mode.
    CONFIG LVP = ON	    ; Low-voltage programming is on.
    CONFIG PBADEN = OFF	    ; RB[5:0] will be configured as digital inputs (datasheet, pg. 133)
    CONFIG FOSC = INTOSCIO  ; Internal oscillator (port function on RA6)
    
    org 0   ; Start code at 0.
    
Start:
    CLRF PORTA
    CLRF LATA
    CLRF TRISA	; Use LATA as output (to the LEDs)
    CLRF PORTB
    CLRF LATB
    
    BSF TRISB, 4    ; RB4 (the push button) is being used as input now.
    
Main:
    ; If RB4 is 0 (clear), skip the next instruction.
    ; When RB4 is pressed, it sends a low (0) signal. When not pressed, it sends a high (1) signal.
    BTFSC PORTB, 4  ; BTFSC = "bit test file; skip if clear"
    GOTO Off	; This GOTO will be reached when RB4 isn't being pushed.
    GOTO On	; This GOTO will be reached when RB4 is being pushed.
    
Off:
    CLRF LATA
    GOTO Main
    
On:
    ; LEDs RA[6:5] should turn on.
    BSF LATA, 6
    BSF LATA, 5
    GOTO Main
    
end
