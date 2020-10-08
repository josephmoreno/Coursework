#include <p18F45K50.inc>
    
    CONFIG WDTEN = OFF	    ; Disable the watchdog timer.
    CONFIG MCLRE = ON	    ; MCLEAR pin is on.
    CONFIG DEBUG = ON	    ; Enable debug mode.
    CONFIG LVP = ON	    ; Low-voltage programming is on.
    CONFIG PBADEN = OFF	    ; RB[5:0] will be configured as digital inputs (datasheet, pg. 133)
    CONFIG FOSC = INTOSCIO  ; Internal oscillator (port function on RA6)
    
    ; NIB_0 and NIB_1 used for the lower 8 result bits of the ADC.
    NIB_0 EQU 0x00
    NIB_1 EQU 0x01
 
    MS_ADCRES EQU 0x02
    
    ORG 0
    
    GOTO Start
    
Lookup_LED0:
    MULLW 0x02
    MOVF PRODL, 0
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
    RETLW b'10001000'	; A (mix of upper and lower-case hex letters)
    RETLW b'11100000'	; b
    RETLW b'10110001'	; C
    RETLW b'11000010'	; d
    RETLW b'10110000'	; E
    RETLW b'10111000'	; F
    
; Look-up table for MS_ADCRES, specifically for PORTE.
Lookup_LED1:
    MULLW 0x02
    MOVF PRODL, 0
    ADDWF PCL, 1
    RETLW b'00000000'	; 0
    RETLW b'00000001'	; 1
    RETLW b'00000010'	; 2
    RETLW b'00000000'	; 3
    
Start:
    CLRF PORTA
    CLRF LATA
    CLRF TRISA
    
    CLRF PORTB
    CLRF LATB
    CLRF TRISB	; PORTB used for NIB_0 LED.
    
    CLRF PORTC
    CLRF LATC
    CLRF TRISC	; PORTC used for MS_ADCRES LED segments a, e, f, g.
    
    CLRF PORTD
    CLRF LATD
    CLRF TRISD	; PORTD used for NIB_1 LED.
    
    CLRF PORTE
    CLRF LATE
    CLRF TRISE	; PORTE used for MS_ADCRES LED segments b, c, d.
    
    BSF TRISA, 0
    BSF ANSELA, 0
    
    BSF TRISA, 7    ; Using RA7 LED to monitor potentiomenter input.
   
Main:
    MOVLW B'10101100'	; Right-justified, 12 T_AD acq. time, F_OSC / 4
    MOVWF ADCON2
    
    MOVLW B'00000000'	; Internal positive and negative voltage referenced.
    MOVWF ADCON1
    
    MOVLW B'00000001'	; AN0 used as analog input, GO = 0, ADC turned on
    MOVWF ADCON0
    
ADC_Start:
    BSF ADCON0, GO	; GO = 1; start conversion.
    
ADC_Waiting:
    BTFSC ADCON0, GO	    ; Test if GO == 0; if true, skip next instruction.
    BRA ADC_Waiting
    
    MOVFF ADRESH, MS_ADCRES ; Store ADC high result in MS_ADCRES.
    MOVFF ADRESL, NIB_0	    ; Store ADC low result in NIB_0 and NIB_1.
    MOVFF ADRESL, NIB_1
    
    ; Separate high and low nibble in the WREG.
    MOVF NIB_0, 0	    ; Move NIB_0 to WREG.
    ANDLW 0x0F		    ; Mask WREG to extract low nibble.
    MOVWF NIB_0		    ; Move low nibble to NIB_0.
    
    SWAPF NIB_1, 0	    ; Swap nibbles in NIB_1 and move it to WREG.
    ANDLW 0x0F		    ; Mask WREG to extract the high nibble.
    MOVWF NIB_1		    ; Move high nibble to NIB_1
    
    ; Look up the LED equivalent for MS_ADCRES
    MOVF MS_ADCRES, 0
    CALL Lookup_LED0
    MOVWF PORTC		    ; Light a, e, f, g segments in the MS_ADCRES LED.
    
    MOVF MS_ADCRES, 0
    CALL Lookup_LED1
    MOVWF PORTE		    ; Light b, c, d segments in the MS_ADCRES LED.
    
    ; Look up the LED equivalent for NIB_1.
    MOVF NIB_1, 0
    CALL Lookup_LED0
    MOVWF PORTD		    ; Light segments in the NIB_1 LED.
    
    ; Look up the LED equivalent for NIB_0.
    MOVF NIB_0, 0
    CALL Lookup_LED0
    MOVWF PORTB
    
    BRA ADC_Start
    
end