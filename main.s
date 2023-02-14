	#include <xc.inc>

psect	code, abs
	
	
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	movlw	0x0
	movwf	TRISD, A	    ; Port D all outputs --> control 
	movwf	TRISE, A	    ; Port E all outputs --> data
	movwf	LATD, A
	incf	LATD, F, A
	
	bra 	rout

delay:
	return 
	
rout:
	movlw	0xAE
	movwf	LATE, A
	decf    LATD, F, A
	call	delay
	incf	LATD, F, A
	setf	TRISE, A
	
	goto $
	end main
