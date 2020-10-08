/*
 * File:   FinalProject_test1.c
 * Author: Joseph
 *
 * Created on July 13, 2020, 2:17 PM
 */

#include "FinalProject_Header.h"

void main(void) {
    
    // Set a 16 MHz clock frequency.
    asm("MOVLW 0x78");
    asm("MOVWF OSCCON");
    
    // PORTA set up.
    // Column 1 (left-most column) is PORTA[0], ... , and column 3 is PORTA[2].
    asm("CLRF PORTA");
    asm("CLRF LATA");
    asm("CLRF TRISA");
    ANSELA = 0x00;
    
    // PORTB set up.
    // Row 1 (top row) is PORTB[7], row 2 is PORTB[6], ... , and row 4 is PORTB[4].
    asm("CLRF PORTB");
    asm("CLRF LATB");
    asm("CLRF TRISB");
    ANSELB = 0x00;
    TRISBbits.TRISB7 = 1;   // Row 1
    TRISBbits.TRISB6 = 1;   // Row 2
    TRISBbits.TRISB5 = 1;   // Row 3
    TRISBbits.TRISB4 = 1;   // Row 4
    
    // EUSART set up.
    SPBRGH1 = 0x00;
    SPBRG1 = 0x19;          // See 17.4, example 17-1 "Calculating Baud Rate Error"
    TXSTA1bits.BRGH = 0;
    BAUDCON1bits.BRG16 = 0; // Set BRGH and BRG16 to 0 for 9600 baud rate.
    TXSTA1bits.SYNC = 0;    // SYNC = 0 for asynchronous mode.
    RCSTA1bits.SPEN = 1;    // SPEN = 1 for enabling serial port.
    TXSTA1bits.TXEN = 1;    // TXEN = 1 for enabling transmission.
    asm("BSF TRISC, 6");    // TX pin
    asm("BSF TRISC, 7");    // RX pin (both TX and RX TRIS must be set to 1 for EUSART operation)
    
    // Interrupt-on-change set up.
    /*INTCONbits.GIE = 1;     // Enable all unmasked interrupts.
    INTCONbits.IOCIE = 1;   // Enable interrupt-on-change.
    IOCBbits.IOCB5 = 1;
    IOCBbits.IOCB6 = 1;
    IOCBbits.IOCB7 = 1;     // Enable IOC for PORTB[7:5].*/
    
    while(1) {
        // 1st column pulled high.
        PORTAbits.RA0 = 1;
        LATAbits.LATA0 = 1;
        
        if (PORTBbits.RB7) {
            TXREG1 = '1';
            __delay_ms(250);
        }
        
        if (PORTBbits.RB6) {
            TXREG1 = '4';
            __delay_ms(250);
        }
        
        if (PORTBbits.RB5) {
            TXREG1 = '7';
            __delay_ms(250);
        }
        
        // 2nd column pulled high.
        PORTAbits.RA0 = 0;
        LATAbits.LATA0 = 0;
        PORTAbits.RA1 = 1;
        LATAbits.LATA1 = 1;
        
        if (PORTBbits.RB7) {
            TXREG1 = '2';
            __delay_ms(250);
        }
        
        if (PORTBbits.RB6) {
            TXREG1 = '5';
            __delay_ms(250);
        }
        
        if (PORTBbits.RB5) {
            TXREG1 = '8';
            __delay_ms(250);
        }
        
        if (PORTBbits.RB4) {
            TXREG1 = '0';
            __delay_ms(250);
        }
        
        // 3rd column pulled high.
        PORTAbits.RA1 = 0;
        LATAbits.LATA1 = 0;
        PORTAbits.RA2 = 1;
        LATAbits.LATA2 = 1;
        
        if (PORTBbits.RB7) {
            TXREG1 = '3';
            __delay_ms(250);
        }
        
        if (PORTBbits.RB6) {
            TXREG1 = '6';
            __delay_ms(250);
        }
        
        if (PORTBbits.RB5) {
            TXREG1 = '9';
            __delay_ms(250);
        }
        
        // Pull 3rd column low.
        PORTAbits.RA2 = 0;
        LATAbits.LATA2 = 0;
    }
    
    return;
    
}

/*void __interrupt() IntVector(void) {
    if (INTCONbits.IOCIF) {
        
        
        asm("NOP"); // Wait one instruction cycle before clearing IOCIF.
        INTCONbits.IOCIF = 0;
    }
}*/