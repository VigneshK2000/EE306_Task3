; ISR.asm
<<<<<<< HEAD
; Name: Vignesh Krishnamurthy and Franklin Mao
; UTEid: vk5452
=======
; Name: Franklin Mao and Vignesh Krishnamurphy
; UTEid: 
>>>>>>> 16277cc0fe91dc3330ccc470ed9031c204812041
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x4600
               .ORIG x2600
Start		
		LDI R1, KBSR
		BRZP Start
		LDI R0, KBDR
Check_A	
		LD R1, CheckA
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R0, R1
		BRNP Check_U
ECHO		
		STI R0, Addr4600
		BRNZP END

Check_U
		AND R1, R1, #0
		LD R1, CheckU
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R1, R0
		BRNP Check_G
ECHO2		
		STI R0, Addr4600
		BRNZP END

Check_G
		AND R1, R1, #0
		LD R1, CheckG
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R1, R0
		BRNP Check_C
ECHO3		
		STI R0, Addr4600
		BRNZP END
Check_C
		AND R1, R1, #0
		LD R1, CheckC
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R1, R0
		BRNP Invalid
ECHO4		
		STI R0, Addr4600
		BRNZP END
Invalid
		BRNZP Start
		
END
		AND R1, R1, #0
		RTI

KBSR	.FILL xFE00
KBDR	.FILL xFE02
DSR	.FILL XFE04
DDR	.FILL XFE06
CheckA	.FILL x41
CheckU	.FILL x55
CheckG	.FILL x47
CheckC	.FILL x43
Addr4600	.FILL x4600

		.END
