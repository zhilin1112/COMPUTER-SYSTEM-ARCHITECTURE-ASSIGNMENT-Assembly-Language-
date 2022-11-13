.MODEL SMALL
.STACK 100
.386
.DATA
	;TITILE OF THE DIALY PROFIT REPORT
    PROFITRPTTIT DB 13,10,"        ----------DAILY TOTAL PROFIT--------             "
                 DB 13,10,"+=================================================+"
                 DB 13,10,"| NO    ORDER AMOUNT      PROFIT     CLEAN PROFIT |"
                 DB 13,10,"+=================================================+$"

    TOTALPROFITMSG DB 13,10,"THE TOTAL PROFIT IS: RM $"

    SPACE4 DB ".           $"
    SPACE5 DB "           $"
    SPACE6 DB "       $"
	SPACE7 DB "   $"
	

	NL DB 13,10,"$"

;ORDER AMOUNT IS NOT INCLUDED TAX JUST TOTAL UP ALL THE ITEM PRICE
;PROFIT CALCULATE THE TAX ALDY 
;CLEAN PROFIT = PROFIT - ORDERAMOUNT

	;Payment earned from the order(profit) 
    ;ringgit site
	PROFITRINGGIT DW 0    ;VAR1
    ;coin site
	PROFITSYILING DB 0   ;VAR2 

	TWO DW 2

	;Index that stores the size of the values currently in the list
	;MOV THIS TO DI 
	; 1 - Size of the array, 5
	; 2 - track the index for items to add to the array
	ORDERINDEX DW 0

	;OPEN LIST FOR PROFITRINGGIT AND PROFITSYILING (FOR STORING PURPOSE)
    PROFITRINGGITLIST DW 20 DUP (0)    ;PROFITRINGGIT
    PROFITSYILINGLIST DB 20 DUP (0)    ;PROFITSYILING

	;CUMULATIVE Total Profit
	TOTALPRORINGGIT DW 000    ;RINGGIT
	TOTALPROSYILING DB 00   ;SYILING

	;Clean Profit Variable
	cleanRinggit DW 0
	cleanSyilling DB 0

    ;CLEANP ROFIT ARRAY LIST
	CLEANRINGGITLIST DW 20 DUP (0)
	CLEANSYILLINGLIST DB 20 DUP (0)

	;Order Amount
	orderAmountRinggit DW 500	
    ORDERAMOUNTSYILING DB 00

    ;DEBUG TEST DATA
    OALIST DW 10
	 	
	TEN1 DB 10
	TEN2 DW 10
	HUNDRED DB 100
	;TEMPORARY VARIABLE TO STORE THE DIGIT WHILE DIVIDE BY 100 
	P DB ?
	Q DB ?
	R DB ?
	S DB ?
	
	TTPY_PARA LABEL BYTE	; Total Payment Parameter List
	MAX_TTPY_LEN DB 10	; Maximum Array Length
	ACT_TTPY_LEN DB ?	; Actual Array Length
	TTPY DB 10 DUP('$')	; Total Payment


.CODE
MAIN PROC
		MOV AX,@DATA
		MOV DS,AX

;Documentation--------------------------------------------------------- 
;THESE STATEMENT WILL RUN AFTER CUST PAY
;Converting the Payment to Variable
MOV CX,2
CONVERTPAYMENT:		
		CMP CX,0
		JE CONVERTDONE ; (jmp print receipt) 
		;GET TTPY (99.00)   (GET TTPY FROM PAYMENT AMOUNT) 
        MOV AH,0AH
		LEA DX,TTPY_PARA
        INT 21H
        
		;Start tracking
		MOV DI,orderIndex

		;Convert to variable
		MOV SI,0

		;reset PROFITRINGGIT and PROFITSYILING
		MOV PROFITRINGGIT,0
		MOV PROFITSYILING,0
        
		;CHECK LENGTH SEE WHETHER IS 3 DIGIT OR 2 DIGIT 
		CMP ACT_TTPY_LEN,6
        JE THREEDIGITCONVERT
        CMP ACT_TTPY_LEN,5
        JE TWODIGITCONVERT
        JMP ONEDIGITCONVERT
;TTPY --> PAYMENT ARRAYLIST 
; array[0] * 100 + array[1] * 10 + array[2] = 999
THREEDIGITCONVERT:
    ;3 digit convert
	MOV AH,0
	MOV AL,TTPY[SI]
    SUB AL,30H
	MUL HUNDRED
	MOV PROFITRINGGIT,AX
	INC SI
; array[0] * 10 + array[1] = 99
TWODIGITCONVERT:
    MOV AH,0
    MOV AL,TTPY[SI]
    SUB AL,30H
    MUL TEN1
	ADD PROFITRINGGIT,AX
	INC SI
ONEDIGITCONVERT:
    MOV AH,0
	MOV AL,TTPY[SI]
    SUB AL,30H
	ADD PROFITRINGGIT,AX
	INC SI

;Usually in this point we will meet decimal
;CONFIRM THAT SI == '.'
	INC SI
	MOV AH,0
    MOV AL,TTPY[SI]
    SUB AL,30H
    MUL TEN1
    ADD PROFITSYILING,AL
    INC SI
	MOV AH,0
    MOV AL,TTPY[SI]
    SUB AL,30H
	ADD PROFITSYILING,AL
;------------------------------------------------------------------------------------------------------------------

;Once done convert MOV THE VALUES TO THE LISTS

;Store the profit to the list
;Get Clean Profit
;	store the clean profit to the list
;
	;DI

	;Addition from Payment to Total Payment (CUMULATIVE PROFIT) 
    MOV BL,PROFITSYILING
    ADD TOTALPROSYILING,BL
    CMP TOTALPROSYILING,99
    ;if true skip to add PROFIT RINGGIT to TOTAL PROFIT RINGGIT
    JLE NEXT
	;else do round up 
    MOV AH,0
    MOV AL,TOTALPROSYILING
    DIV HUNDRED
    MOV TOTALPROSYILING,AH
	MOV BH,0
	MOV BL,AL
	;ALT: MOV AH,0
	;	  MOV RINGGIT,AX
	ADD TOTALPRORINGGIT,BX
	NEXT:
    	MOV BX,PROFITRINGGIT
		ADD TOTALPRORINGGIT,BX

;Get clean profit
;CLEAN PROFIT ( RINGGIT OF PROFIT - ORDER AMOUNT'S RINGGIT)

    MOV AX,PROFITRINGGIT
    SUB AX,OALIST
	MOV cleanRinggit,AX
    MOV AL,PROFITSYILING
	MOV cleanSyilling,AL

	;store dw, db

	;store the profit to the list
    MOV AH,0
	MOV AL,PROFITSYILING
    MOV PROFITSYILINGLIST[DI],AL
	MOV AH,0
    MOV AL,cleanSyilling
    MOV CLEANSYILLINGLIST[DI],AL
	MOV AX,DI
	;SINCE THE ORDERLIST IS DW SO MUL 2 
	MUL TWO
	MOV BX,AX
	MOV AX,PROFITRINGGIT	
    MOV PROFITRINGGITLIST[BX],AX
    MOV AX,cleanRinggit
    MOV CLEANRINGGITLIST[BX],AX

	INC DI
	MOV ORDERINDEX,DI
	DEC CX
	JMP CONVERTPAYMENT
CONVERTDONE:
	;Display the contents of the array (DEBUG)
    
	;DISPLAY THE REPORT HEADER
	RPT3:
		CALL PROFITREPORT
	;print profit list
	MOV CX,2
	MOV SI,0
DISPLAYITEM:
    CALL DISPLAYCONTENT
    
    INC SI
LOOP DISPLAYITEM
		

;----------------------------------------------------------
;DISPLAY THE TOTAL PROFIT 
	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,TOTALPROFITMSG
	INT 21H

	 MOV DX,0
	 MOV AX,TOTALPRORINGGIT
	 MOV BX,0						;123
	 DIV TEN2 ;first remainder in dl ;PQR
	 MOV R,DL ;1
	 DIV TEN1
	 MOV Q,AH ;2
	 MOV P,AL ;1
     MOV AH,02H
     MOV DL,P
     ADD DL,30H
     INT 21H
     MOV AH,02H
     MOV DL,Q
     ADD DL,30H
     INT 21H

	 MOV AH,02H
	 MOV DL,R
	 ADD DL,30H
	 INT 21H
     MOV AH,02H
	 MOV DL,'.'
     INT 21H

	 ;var2 01 - 99
	 MOV AH,0
	 MOV AL,TOTALPROSYILING
	 DIV TEN1
	 MOV BX,AX
     MOV AH,02H
     MOV DL,BL
     ADD DL,30H
     INT 21H

     MOV AH,02H
     MOV DL,BH
     ADD DL,30H
     INT 21H

		EXIT:
		MOV AX,4C00H
		INT 21H
		
MAIN ENDP

;-------------------------------------------------
;REPORT TITILE FUNCTION
PROFITREPORT PROC
	MOV AH,09H
	LEA DX,PROFITRPTTIT
	INT 21H

	MOV AH,09H
	LEA DX,NL
	INT 21H
	
	RET
PROFITREPORT ENDP 

;------------------------------------------------
;FUNCTION WHICH DISPLAY ALL THE CONTENT OF THE REPORT
DISPLAYCONTENT PROC
;-----------------------------------------------------------------------
	MOV AH,02H
	MOV DL,"|"
	INT 21H

    ;START DISPLAY NO (PROBLEM CAN'T PRINT THE INDEX ) 
	MOV DL,0
	MOV DI,SI
    INC DI
	MOV AX,DI
	DIV TEN1
    MOV BX,AX

    MOV AH,02H
    MOV DL,BL
    ADD DL,30H
    INT 21H

    MOV AH,02H
    MOV DL,BH
    ADD DL,30H
    INT 21H

;--------------------------------------------------------------------------
    ;SPACE4 
    MOV AH,09H
    LEA DX,SPACE4
    ;MOV AH,02H
    ;MOV DL," "
    INT 21H

;--------------------------------------------------------------------------
    ;ORDERLIST
    ;PRINT ORDER AMOUNT FROM KS PLACE ORDER

;--------------------------------------------------------------------------
    ;SPACE5
  	MOV AH,09H
	LEA DX,SPACE5
	INT 21H

;--------------------------------------------------------------------------
    ;PRINT PROFIT
    ;MOV AH,09H
	;LEA DX,NL
	;INT 21H
	MOV AX,SI
	MUL TWO
	MOV BX,AX
	MOV DX,0
	MOV AX,PROFITRINGGITLIST[BX]
	MOV BX,0						;123
	DIV TEN2 ;first remainder in dl ;PQR
	MOV R,DL ;3
	DIV TEN1
	MOV Q,AH ;2
	MOV P,AL ;1

    MOV AH,02H
    MOV DL,P
    ADD DL,30H
    INT 21H

    MOV AH,02H
    MOV DL,Q
    ADD DL,30H
    INT 21H
	
	MOV AH,02H
	MOV DL,R
	ADD DL,30H
	INT 21H

    MOV AH,02H
	MOV DL,'.'
    INT 21H

	;var2 01 - 99
	MOV AH,0
	MOV AL,PROFITSYILINGLIST[SI]
	DIV TEN1
	MOV BX,AX
    MOV AH,02H
    MOV DL,BL
    ADD DL,30H
    INT 21H
   
    MOV AH,02H
    MOV DL,BH
    ADD DL,30H
    INT 21H
;--------------------------------------------------------------------------
    ;SPACE6 
    MOV AH,09H
    LEA DX,SPACE6
    INT 21H
    ;Display Output
    ;DISPLAY THE CLEAN PROFIT 
	;MOV AH,09H
	;LEA DX,NL
	;INT 21H
	MOV AX,SI
	MUL TWO
	MOV BX,AX
	MOV DX,0
	MOV AX,CLEANRINGGITLIST[BX]
	MOV BX,0						;099
	DIV TEN2 ;first remainder in dl ;PQR
	MOV R,DL
	DIV TEN1
	MOV Q,AH
	MOV P,AL ;0

   MOV AH,02H
   MOV DL,P
   ADD DL,30H
   INT 21H

   MOV AH,02H
   MOV DL,Q
   ADD DL,30H
   INT 21H
	
	MOV AH,02H
	MOV DL,R
	ADD DL,30H
	INT 21H

   MOV AH,02H
	MOV DL,'.'
   INT 21H

	;var2 01 - 99
	MOV AH,0
	MOV AL,CLEANSYILLINGLIST[SI]
	DIV TEN1
	MOV BX,AX
   MOV AH,02H
   MOV DL,BL
   ADD DL,30H
   INT 21H
   
   MOV AH,02H
   MOV DL,BH
   ADD DL,30H
   INT 21H

   ;SPACE6 
   MOV AH,09H
   LEA DX,SPACE7
   INT 21H

	;PRINT END COL
   MOV AH,02H
   MOV DL,"|"
   INT 21H

   MOV AH,09H
   LEA DX,NL
   INT 21H

   

   RET 
DISPLAYCONTENT ENDP

END MAIN