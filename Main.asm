; Main.asm
; Name:
; UTEid: 
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.

               .ORIG x4000
; initialize the stack pointer

	LD R6, Stack

; enable keyboard interrupts
start	
	LD R0, KBIEN
	STI R0, KBSR


; set up the keyboard interrupt vector table entry

	LD R0, Check2600	
	STI R0, KBIVE


; start of actual program
loop
	LDI R0, Get4600	;load whats in R0 to x4600
	BRZ loop
	TRAP X21	;display console
	AND R1, R1, #0	;clear r1
	STI R1, Get4600	;store r1 (0) into x4600
		
	ADD R6, R6, #-1	;decrease stack pointer by one
	STR R0, R6, 0	;store whats in r6 offset 0 into r0  (Creating stack)

STATE_A
	LDR R2, R6, 0
	LD R3, Compliment_A
	ADD R3, R3, R2
	BRZ STATE_AU
	BRNZP loop
STATE_AU
	LDI R0, Get4600
	BRZ STATE_AU
	TRAP X21
	AND R1, R1, #0
	STI R1, Get4600

	ADD R6, R6, #-1
	STR R0, R6, 0

	LDR R2, R6, 0
	LD R3, Compliment_U
	ADD R3, R3, R2
	BRZ STATE_AUG
	
	LD R3, Compliment_A
	ADD R3, R3, R2
	BRZ STATE_A
	BRNZP loop
STATE_AUG
	LDI R0, Get4600
	BRZ STATE_AUG
	TRAP X21
	AND R1, R1, #0
	STI R1, Get4600

	ADD R6, R6, #-1
	STR R0, R6, 0

	LDR R2, R6, 0
	LD R3, Compliment_G
	ADD R3, R3, R2
	BRZ PasteBar
	
	LD R3, Compliment_A
	ADD R3, R3, R2
	BRZ STATE_A
	BRNZP loop
	
PasteBar
	LD R0, Pipe
	TRAP X21
	BRNZP State_U

State_U
	LDI R0, Get4600
	BRZ State_U
	TRAP X21
	AND R1, R1, #0
	STI R1, Get4600

	ADD R6, R6, #-1
	STR R0, R6, 0

	LDR R2, R6, 0
	LD R3, Compliment_U
	ADD R3, R3, R2
	BRZ State_UA
	BRNZP State_U

State_UA
	LDI R0, Get4600
	BRZ State_UA
	TRAP X21
	AND R1, R1, #0
	STI R1, Get4600

	ADD R6, R6, #-1
	STR R0, R6, 0

	LDR R2, R6, 0
	LD R3, Compliment_A
	ADD R3, R3, R2
	BRZ State_UAG

	LD R3, Compliment_G
	ADD R3, R3, R2
	BRZ State_UGA
	BRNZP State_UA	;Check this line
	
State_UAG
	LDI R0, Get4600
	BRZ State_UAG
	TRAP X21
	AND R1, R1, #0
	STI R1, Get4600

	ADD R6, R6, #-1
	STR R0, R6, 0

	LDR R2, R6, 0
	LD R3, Compliment_G
	ADD R3, R3, R2
	BRZ END

	LD R3, Compliment_A
	ADD R3, R3, R2
	BRZ END
	BRNZP State_U

State_UGA
	LDI R0, Get4600
	BRZ State_UGA
	TRAP X21
	AND R1, R1, #0
	STI R1, Get4600

	ADD R6, R6, #-1
	STR R0, R6, 0

	LDR R2, R6, 0
	LD R3, Compliment_A
	ADD R3, R3, R2
	BRZ END
	BRNZP State_UA
END
	TRAP X25
	

Stack	.FILL	x4000
KBIEN	.FILL	X4000
KBSR	.FILL	XFE00
KBIVE	.FILL	X0180
Get4600 .FILL	x4600

Ascii_A .FILL	x41
Ascii_U	.FILL	x55
Ascii_G	.FILL 	x47
Ascii_C	.FILL 	x43

Compliment_A .FILL x-41
Compliment_U .FILL x-55
Compliment_G .FILL x-47
Compliment_C .FILL x-43

Pipe	.FILL x7C

Check2600 .FILL	x2600

		

		.END
