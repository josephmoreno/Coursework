#include <p18F45K50.inc>
    
    CONFIG WDTEN = OFF	    ; Disable the watchdog timer.
    CONFIG MCLRE = ON	    ; MCLEAR pin is on.
    CONFIG DEBUG = ON	    ; Enable debug mode.
    CONFIG LVP = ON	    ; Low-voltage programming is on.
    CONFIG PBADEN = OFF	    ; RB[5:0] will be configured as digital inputs (datasheet, pg. 133)
    CONFIG FOSC = INTOSCIO  ; Internal oscillator (port function on RA6)
    
    ; Using 16 MHz oscillator, which means 4,000,000 instruction cycles / sec
    ; I use three counters in total: TIMER0, COUNT1, and COUNT2.
    ; Since 1 second == 4,000,000 instruction cycles and TIMER0 uses 1 instruction cycle to
    ; increment itself, a counter with at minimum 22 bits is needed to count up to 4,000,000.
    
    ; The 24-bit counter I'm using is as follows:
    ; [23:16] == COUNT2, [15:8] == COUNT1, [7:0] == TIMER0
    COUNT1 EQU 0x00
    COUNT2 EQU 0x01
 
    ONES_DIGIT EQU 0x02
    TENS_DIGIT EQU 0x03
    
    org 0   ; Start code at 0.

    GOTO Start
    
Lookup_ONES:
    ADDWF PCL, 1
    RETLW b'10000001'	; 0
    RETLW b'11001111'	; 1
    RETLW b'10010010'	; 2
    RETLW b'10000110'	; 3
    RETLW b'11001100'	; 4
    RETLW b'10100100'	; 5
    RETLW b'10100000'	; 6
    RETLW b'10001111'	; 7
    RETLW b'10000000'	; 8
    RETLW b'10000100'	; 9

Lookup_TENS:
    ADDWF PCL
    RETLW b'10000001'	; 0
    RETLW b'11001111'	; 1
    RETLW b'10010010'	; 2
    RETLW b'10000110'	; 3
    RETLW b'11001100'	; 4
    RETLW b'10100100'	; 5
    RETLW b'10100000'	; 6

Start:
    MOVLB 0xF	    ; Move low nibble to the bank select register.

    CLRF PORTB	    ; PORTB is the ones digit.
    CLRF LATB
    CLRF TRISB	    ; Clear PORTB and use it for output.
    
    CLRF PORTD	    ; PORTD is the tens digit.
    CLRF LATD
    CLRF TRISD	    ; Clear PORTD and use it for output.

    MOVLW 0x08
    MOVWF T0CON	    ; T0CON = b"0000_1000"

    MOVLW 0x78
    MOVWF OSCCON    ; OSCCON = b"0111_1000"
    
    CLRF COUNT1
    CLRF COUNT2
    
    CLRF ONES_DIGIT
    CLRF TENS_DIGIT
    
Main:
    CLRF TMR0L
    CLRF TMR0H		; Set the timer/counter to 0; range of 0x00 through 0xFF.
    
    BCF INTCON, TMR0IF
    BSF T0CON, TMR0ON
    
    MOVLW 0xC3
    MOVWF COUNT2	; COUNT2 starts at 0xC3 since only 61 increments are needed.
    
    MOVLW 0x81
    MOVWF PORTB
    MOVWF PORTD
    
Loop:
    BTFSS INTCON, TMR0IF
    BRA Loop
    INCF COUNT1, 1
    
    ; Reset timer/counter overflow flag.
    BCF T0CON, TMR0ON
    CLRF TMR0L
    CLRF TMR0H
    BCF INTCON, TMR0IF
    BSF T0CON, TMR0ON
    
    BNZ Loop
    
    BCF STATUS, Z
    INCF COUNT2, 1
    
    BNZ Loop
    
    BCF STATUS, Z
    INCF ONES_DIGIT, 1	; Increment the ones digit for the lookup table.
    INCF ONES_DIGIT, 1
    BRA Set_COUNT2

Set_COUNT2:    
    MOVLW 0xC3
    MOVWF COUNT2
    MOVLW 0x14
    CPFSEQ ONES_DIGIT
    BRA Set_ONES
    BRA Reset_ONES
    
Set_ONES:
    MOVFF ONES_DIGIT, WREG
    CALL Lookup_ONES
    MOVWF PORTB
    BRA Loop
    
Reset_ONES:
    CLRF ONES_DIGIT
    MOVLW 0x00
    CALL Lookup_ONES
    MOVWF PORTB
    INCF TENS_DIGIT, 1	; Increment the tens digit for the lookup table.
    INCF TENS_DIGIT, 1
    MOVLW 0x0C
    CPFSEQ TENS_DIGIT
    BRA Set_TENS
    BRA Reset_TENS
    
Set_TENS:
    MOVFF TENS_DIGIT, WREG
    CALL Lookup_TENS
    MOVWF PORTD
    BRA Loop
    
Reset_TENS:
    CLRF TENS_DIGIT
    MOVLW 0x00
    CALL Lookup_TENS
    MOVWF PORTD
    BRA Loop

end
