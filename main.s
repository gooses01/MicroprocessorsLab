	#include <xc.inc>

psect	code, abs
	
	
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	movlw 	0x0
	movwf	0x06, A
	movwf	TRISB, A	    ; Port C all outputs
	
	bra 	test
loop:
	movff 	0x06, PORTB
	incf 	0x06, 1, 0
	movlw   0x03
	movwf	0x20, A
	call    delay1
test:
	;movwf	0x06, A		    ; Test for end of loop condition
	movlw 	0x63
	cpfsgt 	0x06, A
	bra 	loop		    ; Not yet finished goto start of loop again
	goto 	0x0		    ; Re-run program from start

;	end	main                ; delay subrutine

delay1:
	movlw   0x03
	movwf	0x30, A
	call delay2
	decfsz 0x20, 1, 0
	bra delay1
	return 
delay2:
	decfsz 0x30, 1, 0
	bra delay2
	return 
	
	end