;  Data processing example
;  IDE: ADS 1.2
;  Programmer: robot@ittraining.com.tw

	AREA	Start, CODE, READONLY	; declare the name of the code segment
	CODE32				; ARM code (32-bit mode)

	ENTRY				; mark the entry point of the segment

start
	MOV	r0, #1
	MOV	r1, #2
	MOV	r2, #3
	MOV	r3, #4
	MOV r13,#0x10000	
	BL func1
	ADD	r4,r1,r2
	BL	.			; block here
	
func1
	STMFD r13!,{r0-r3,r14}  
	MOV	r0, #0x10
	MOV	r1, #0x20
	MOV	r2, #0x30
	MOV	r3, #0x40
	BL func2
	LDMFD r13!,{r0-r3,pc}  
	
func2
	STMFD r13!,{r0-r3,r14}  
	MOV	r0, #0x50
	MOV	r1, #0x60
	MOV	r2, #0x70
	MOV	r3, #0x80
	BL func3
	LDMFD r13!,{r0-r3,pc}  

func3
    MOV pc,lr
	END
	
	
	