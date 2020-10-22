    AREA appcode,CODE,READONLY

    EXPORT __main

	ENTRY 

__main  FUNCTION			

		VLDR.F32 S0,=1.2                ; S0=X in log(1+X)

		MOV R1,#10                      ; NUMBER OF TERMS 

		VLDR.F32 S2,=1.0                ;consider S2 as N

		VLDR.F32 S4,=1.0		;Using this for incrementing N

		VLDR.F32 S3, =0.0               ; Result register

		VLDR.F32 S1,=1.0                ;Temporary Register

		VNMUL.F32 S1,S1,S0              ; Storing -X

		

LOOP	VNMUL.F32 S1,S1,S0                     ;S1 = S1*X  --> This also gives alternate -ve terms

		VDIV.F32 S5,S1,S2               ;S1 = S1/N    --> This gives X,-(X^2)/2,+(X^3)/3

		VADD.F32 S3,S3,S5               ;S3 = S3+X^N/N --> Result Register X - (X^2)/2 + (X^3)/3 + .....

		VADD.F32 S2,S2,S4               ;N++ (producing N(denominator))

		SUB R1,R1,#1                    ;R1 = R1-1

		CMP R1,#0			;If R1 == 0 then the no. of iterations are over come out of LOOP.

		BNE LOOP                        ;BRANCH TO LOOP 

stop    B stop                          ; stop program

       ENDFUNC

	 END