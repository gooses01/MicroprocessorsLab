	#include <xc.inc>

psect	code, abs
	
	
SPI_MasterInit:	    ; Set Clock edge to negative	
    bcf	    CKE2	; CKE bit in SSP2STAT, 
    ; MSSP enable; CKP=1; SPI master, clock=Fosc/64 (1MHz)
    movlw   (SSP2CON1_SSPEN_MASK)|(SSP2CON1_CKP_MASK)|(SSP2CON1_SSPM1_MASK)	
	; We want to set SSPxCON1 8-bit control register with a value of 
	; 00110010, but this value without comments is quite difficult to 
	; interpret. The compiler has 8-bit numbers defined for each of the bit 
	; flags. For example, for the SSPEN bit in the SSPxCON1 control register 
	; for SPI mode it has SSP2CON1_SSPEN_MASK defined as 00100000. If we 
	; 'or' (|) it with the other the other compiler defined masks we can get 
	; the same number we want to input but in human readable way
    movwf   SSP2CON1, A	
    ; SDO2 output; SCK2 output	
    bcf	    TRISD, PORTD_SDO2_POSN, A	; SDO2 output which is the RD4 bit in the TRISD f
    bcf	    TRISD, PORTD_SCK2_POSN, A	; SCK2 output which is the RD6 bit in the TRISD f. PORTD_SCK2_POSN is just a compiler defined shortcut 
    return

SPI_MasterTransmit:  ; Start transmission of data (held in W)
    movwf   SSP2BUF, A 	; write data to output buffer

Wait_Transmit:	; Wait for transmission to complete
    btfss   SSP2IF		; check interrupt flag to see if data has been sent
    bra	    Wait_Transmit	
    bcf	    SSP2IF		; clear interrupt flag	
    return 
    

