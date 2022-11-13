;FILENAME: PAY.ASM
;AUTHOR: CHIEW HONG KUANG

.MODEL SMALL
.STACK 100
.386
.DATA
		OA DB 00D	; Order Amount
		OAXH DB ?	; Order Amount (Hundred)
		NL DB 0DH,0AH,"$"	; New Line
		ALERT1 DB "NO ORDER FOUND!$"	; Alert Message 1
		ALERT2 DB "INSUFFICIENT PAYMENT! PLEASE TRY AGAIN!$"	; Alert Message 2
		ALERT3 DB "INVALID PAYMENT! PLEASE TRY AGAIN!$"	; Alert Message 3
		ALERT4 DB "PAYMENT TOO LARGE! PLEASE TRY AGAIN!$"	; Alert Message 4
		ALERT5 DB "ONLY 2 DECIMAL PLACES ALLOWED! PLEASE TRY AGAIN!$"	; Alert Message 5
		ALERT6 DB "PAYMENT SUCCESSFUL!$"	; Alert Message 6
		MSG1 DB "ENTER CUSTOMER PAYMENT: $"	; Message 1
		CONTINUE DB "PRESS ANY KEY TO CONTINUE...$"	; Continue Message
		RETURN DB "PRESS ANY KEY TO RETURN TO LAST STAGE...$"	; Return Message
		TEN DB 10D 	; Ten
		HUNDRED DB 100D	; Hundred
		SSTR DB	05D	; SST Rate
		SSXR DB	10D	; Service Tax Rate
		TWO DB 2	; Two
		OVF DB 0	; Overflow Flag

		SST_PARA LABEL BYTE	; SST Amount Parameter List
		MAX_SST_LEN DB 10	; Maximum Array Length
		ACT_SST_LEN DB ?	; Actual Array Length
		SST DB 10 DUP('$')	; SST Amount

		STX_PARA LABEL BYTE	; Service Tax Parameter List
		MAX_STX_LEN DB 10	; Maximum Array Length
		ACT_STX_LEN DB ?	; Actual Array Length
		STX DB 10 DUP('$')	; Service Tax

        ; Order Amount Calculated Parameter List
        orderAmountCalPram LABEL BYTE
        MAX_OAC_LEN DB 10
        ACT_OAC_LEN DB ?
        orderAmountCal DB 10 DUP ('$')

		TTPY_PARA LABEL BYTE	; Total Payment Parameter List
		MAX_TTPY_LEN DB 10	; Maximum Array Length
		ACT_TTPY_LEN DB ?	; Actual Array Length
		TTPY DB 10 DUP('$')	; Total Payment

		CUSTPY_PARA LABEL BYTE	; Customer Payment Parameter List
		MAX_CUSTPY_LEN DB 10	; Maximum Array Length
		ACT_CUSTPY_LEN DB ?	; Actual Array Length
		CUSTPY DB 10 DUP('$')	; Customer Payment Data

		; BCUSTPY_PARA LABEL BYTE	; Backup Customer Payment Parameter List
		; MAX_BCUSTPY_LEN DB 10	; Maximum Array Length
		; ACT_BCUSTPY_LEN DB ?	; Actual Array Length
		; BCUSTPY DB 10 DUP('$')	; Backup Customer Payment Data

		CHG_PARA LABEL BYTE	; Changes Parameter List
		MAX_CHG_LEN DB 10	; Maximum Array Length
		ACT_CHG_LEN DB ?	; Actual Array Length
		CHG DB 10 DUP('$')	; Changes

		DPCOUNT DB 00D	; Decimal Point Counter
		DPI_TTPY DW ?	; Decimal Point Index For Total Payment
		DPI_CUSTPY DW ?	; Decimal Point Index For Customer Payment
		DPI_OA DW 2	; Decimal Point Index For Order Amount
		DPL DB 1	; Decimal Placement
		CP DB 0	; Customer Payment
		;Strings for menu
		MENU DB  0DH,0AH,13,10,"---Menu---"
			 DB  13,10,"1. Display Dishes Menu"
			 DB  13,10,"2. Display Drinks Menu"
			 DB  0DH,0AH,"3. Display Sides Menu"
			 DB  13,10,"4. Display Event Sets Menu"
			 DB  13,10,"5. Cancel Order "
			 DB  13,10,"6. Payment "
			 DB  13,10,"7. Return To Main Menu$"
        ;Order Amount Parameter List
        orderAmountPram LABEL BYTE
        MAX_LEN DB 10
        ACT_LEN DB ?
        orderAmount DB 10 DUP ('$')

		TITORDERDETAIL DB 13,10,"OrderList                              "
		SEPARATESPACE DB 13,10,"***************************************$"
		ODETAIL DB 13,10,"NO  ITEM    QUANTITY    ORDERAMOUNT$ "
		SEPARATELINE DB 13,10,"---------------------------------------------$"
		
		ORDERAM DB 13,10,"ORDER AMOUNT   : RM $"
		SSTMSG DB 13,10,"SALES TAX (SST) : RM $"
		SRVMSG DB 13,10,"SERVICE TAX     : RM $"
		TOTPAY DB 13,10,"TOTAL PAYMENT   : RM $"
.CODE
MAIN PROC
		MOV AX,@DATA
		MOV DS,AX

PLACEORDER:
		; Clear Screen
		MOV AX,02H
		INT 10H

		;display order menu by categories
		MOV AH,09H
		LEA DX, MENU
		INT 21H
		; Display Continue Message
		LEA DX,CONTINUE
		INT 21H

		; Read any key
		MOV AH,01H
		INT 21H

; Possible make changes --> depends on how OA (Order Amount) look like
; Check whether Order Amount == 0
PAYMENT:
		; Clear Screen
		MOV AX,02H
		INT 10H

		MOV AH,0AH
		LEA DX,orderAmountPram
		INT 21H

		CMP orderAmount[0],'0'
		; if (Order Amount == 0) --> No Order Found
		JZ NOORDER
		; if (Order Amount != 0) --> Calculate Taxes
		JNZ CALTAXES

; No Order Found
NOORDER:
		; Display Alert Message 1
		MOV AH,09H
		LEA DX,ALERT1
		INT 21H
		; Display New Line
		LEA DX,NL
		INT 21H
		; Display Return Message
		LEA DX,RETURN
		INT 21H

		; Read any key
		MOV AH,01H
		INT 21H

		; Clear Screen
		MOV AX,02H
		INT 10H

		; Return to Order Menu
		JMP PLACEORDER

; Calculate Taxes
CALTAXES:
		MOV AH,0AH
		LEA DX,orderAmountPram
		INT 21H

MOV CH,0
		MOV CL,ACT_LEN
		MOV DI,0
		MOV ACT_OAC_LEN,CL

; Backup Order Amount
BACKUPOA:
		MOV AL,orderAmount[DI]
		MOV orderAmountCal[DI],AL
		INC DI
		LOOP BACKUPOA

		MOV BL,ACT_OAC_LEN
		CMP ACT_OAC_LEN,5
		; if (Actual Length of Order Amount Calculated <= 5) (XX.XX) --> Actual length of SST and STX is fixed to 4
		JBE FIXEDTO4
		DEC BL
		; Jump to Set Actual Length for SST and STX
		JMP SETLENGTH

; Actual length of SST and STX is fixed to 4
FIXEDTO4:
		MOV BL,4

; Set Actual Length for SST and STX
SETLENGTH:
		; Actual Length of SST and STX = BL
		MOV ACT_SST_LEN,BL
		MOV ACT_STX_LEN,BL
		CMP ACT_OAC_LEN,5
		JBE POADIVTEN
		CMP orderAmountCal[0],'2'
		; if (Order Amount Calculated[0] >= '2') --> Prepare Divide Order Amount Calculated by 10
		JAE POADIVTEN
		DEC ACT_SST_LEN

; Prepare Divide Order Amount Calculated by 10
POADIVTEN:
		MOV CH,0
		MOV CL,ACT_LEN
		MOV DI,0

; Divide Order Amount Calculated by 10 (Move Decimal Point to front once)
OADIVTEN:
		CMP orderAmountCal[DI],'.'
		; if (Order Amount Calculated[i] != '.') --> Next Digit (1)
		JNE NEXTDIGIT1
		; else --> swap Order Amount Calculated[i] with Order Amount Calculated[i - 1]
		MOV SI,DI
		DEC SI
		MOV AL,orderAmountCal[SI]
		MOV orderAmountCal[SI],'.'
		MOV orderAmountCal[DI],AL
		; Prepare Calculate Service Tax Amount
		JMP PCALSTX

; Next Digit (1)
NEXTDIGIT1:
		INC DI
		LOOP OADIVTEN

; Prepare Calculate Service Tax Amount
PCALSTX:
		MOV CH,0
		MOV CL,ACT_STX_LEN
		MOV DI,0

; Calculate Service Tax Amount
CALSTX:
		MOV AH,orderAmountCal[DI]
		MOV STX[DI],AH
		INC DI
		LOOP CALSTX

; Prepare Calculate SST Amount
PCALSST:
		MOV SST[0],'0'
		MOV CH,0
		MOV CL,ACT_SST_LEN
		MOV DI,0

; Calculate SST Amount
CALSST:
		CMP orderAmountCal[DI],'.'
		; if (DI == SI) --> Handle Decimal Point
		JE HANDLEDP
		MOV AH,0
		MOV AL,orderAmountCal[DI]
		SUB AL,30H
		DIV TWO
		MOV BX,AX

		MOV AH,0
		MOV AL,ACT_SST_LEN
		DEC AX
		CMP DI,AX
		; if (DI >= Actual Length of SST Amount - 1) --> Set SST[DI]
		JAE SETSSTDI
		CMP BH,1
		; if (Remainder != 1) --> Set Zero to Next Digit
		JNE SETZERO
		MOV SST[DI + 1],'5'
		; Jump to Set SST[DI]
		JMP SETSSTDI

; Handle Decimal Point
HANDLEDP:
		MOV AL,SST[DI]
		MOV SST[DI],'.'
		MOV SST[DI + 1],AL
		; Jump to Next Digit (2)
		JMP NEXTDIGIT2

; Set Zero to Next Digit
SETZERO:
		MOV SST[DI + 1],'0'

; Set SST[DI]
SETSSTDI:
		ADD SST[DI],BL

; Next Digit (2)
NEXTDIGIT2:
		INC DI
		LOOP CALSST

; Check whether first digit of SST Amount is 0
CHKSSTFSTDIGIT:
		CMP SST[0],'0'
		; if (first digit of SST Amount != '0') --> Calculate Total Payment
		JNE CALTTPY
		CMP SST[1],'.'
		; if(second digit of SST Amount != '.') --> Calculate Total Payment
		JE CALTTPY
		DEC ACT_SST_LEN
		MOV CH,0
		MOV CL,ACT_SST_LEN
		MOV DI,0

; Sort SST Amount
SORTSST:
		MOV AL,SST[DI + 1]
		MOV SST[DI],AL
		INC DI
		LOOP SORTSST

		MOV SST[DI],'$'

; Calculate Total Payment
CALTTPY:
		; Total Payment = Order Amount
		MOV BX,DPI_OA
		MOV DPI_TTPY,BX
		MOV AL,ACT_LEN
		MOV ACT_TTPY_LEN,AL
		MOV CH,0
		MOV CL,ACT_LEN
		MOV DI,0

; Set Total Payment
SETTTPY:
		MOV AL,orderAmount[DI]
		MOV TTPY[DI],AL
		INC DI
		LOOP SETTTPY

		; Total Payment = Total Payment + Service Tax Amount
		MOV OVF,0
		MOV CH,0
		MOV CL,ACT_TTPY_LEN
		MOV DI,0
		MOV SI,0
		MOV AH,0
		MOV AL,ACT_SST_LEN
		SUB AL,3
		CMP DPI_TTPY,AX
		JE SAMEDIGIT1
		INC DI
		DEC CX
		
; Same Digits (1)
SAMEDIGIT1:
		CMP TTPY[DI],'.'
		; if (Total Payment[DI] == '.') --> Next Digit (3)
		JE NEXTDIGIT3
		MOV AL,STX[SI]
		ADD TTPY[DI],AL
		MOV BX,DI
		CMP TTPY[DI],6AH
		; if (Total Payment >= 6AH) --> Round Up (1)
		JAE ROUNDUP1
		SUB TTPY[DI],30H

; Next Digit (3)
NEXTDIGIT3:
		INC DI
		INC SI
		LOOP SAMEDIGIT1

		; Prepare Handle Overflow (1)
		JMP PHANDLEOVERFLOW1

; Round Up (1)
ROUNDUP1:
		SUB TTPY[BX],3AH
		DEC BX
		CMP TTPY[BX],'.'
		; if (Total Payment[BX] == '.') --> Decrease BX Again (1)
		JE DECAGAIN1
		; if (Total Payment[BX] != '.') --> Continue Round Up (1)
		JNE CONROUNDUP1

; Decrease BX Again (1)
DECAGAIN1:
		DEC BX

; Continue Round Up (1)
CONROUNDUP1:
		ADD TTPY[BX],31H
		CMP TTPY[BX],6AH
		; if (Total Payment >= 6AH) --> Check Overflow (1)
		JAE CHKOVERFLOW1
		SUB TTPY[BX],30H
		; Jump to Next Digit (3)
		JMP NEXTDIGIT3

; Check Overflow (1)
CHKOVERFLOW1:
		CMP BX,0
		; if (Index of Total Payment == 0) --> Set Overflow Flag (1)
		JE SETOVERFLOWFLAG1
		; if (Index of Total Payment != 0) --> Round Up (1)
		JNE ROUNDUP1

; Set Overflow Flag (1)
SETOVERFLOWFLAG1:
		MOV OVF,1
		; Jump to Next Digit (3)
		JMP NEXTDIGIT3

; Prepare Handle Overflow (1)
PHANDLEOVERFLOW1:
		CMP OVF,0
		; if (Overflow Flag == 0) --> Sum Total Payment with SST Amount
		JE SUMSST
		; Increase Actual Array Length by 1
		INC ACT_TTPY_LEN
		INC DPI_TTPY
		MOV BH,0
		MOV BL,ACT_TTPY_LEN
		MOV CX,BX

; Handle Overflow (1)
HANDLEOVERFLOW1:
		; Move forward every element in the Array
		MOV AL,TTPY[BX - 1]
		MOV TTPY[BX],AL
		DEC BX
		LOOP HANDLEOVERFLOW1

; Add Digit (1)
ADDDIGIT1:
		SUB TTPY[1],3AH
		MOV TTPY[0],'1'

; Sum Total Payment with SST Amount
SUMSST:
		; Total Payment = Total Payment + SST Amount
		MOV OVF,0
		MOV CH,0
		MOV CL,ACT_TTPY_LEN
		MOV DI,0
		MOV SI,0
		MOV AH,0
		MOV AL,ACT_SST_LEN
		SUB AL,3
		CMP DPI_TTPY,AX
		JE SAMEDIGIT2
		MOV BX,DPI_TTPY
		SUB BX,AX
		CMP BX,1
		JE INCDIBYONE
		ADD DI,2
		SUB CX,2
		; Jump to Same Digits (2)
		JMP SAMEDIGIT2

; Increase DI By 1
INCDIBYONE:
		INC DI
		DEC CX
		
; Same Digits (2)
SAMEDIGIT2:
		CMP TTPY[DI],'.'
		; if (Total Payment[DI] == '.') --> Next Digit (4)
		JE NEXTDIGIT4
		MOV AL,SST[SI]
		ADD TTPY[DI],AL
		MOV BX,DI
		CMP TTPY[DI],6AH
		; if (Total Payment >= 6AH) --> Round Up (2)
		JAE ROUNDUP2
		SUB TTPY[DI],30H

; Next Digit (4)
NEXTDIGIT4:
		INC DI
		INC SI
		LOOP SAMEDIGIT2

		; Prepare Handle Overflow (2)
		JMP PHANDLEOVERFLOW2

; Round Up (2)
ROUNDUP2:
		SUB TTPY[BX],3AH
		DEC BX
		CMP TTPY[BX],'.'
		; if (Total Payment[BX] == '.') --> Decrease BX Again (2)
		JE DECAGAIN2
		; if (Total Payment[BX] != '.') --> Continue Round Up (2)
		JNE CONROUNDUP2

; Decrease BX Again (2)
DECAGAIN2:
		DEC BX

; Continue Round Up (2)
CONROUNDUP2:
		ADD TTPY[BX],31H
		CMP TTPY[BX],6AH
		; if (Total Payment >= 6AH) --> Check Overflow (2)
		JAE CHKOVERFLOW2
		SUB TTPY[BX],30H
		; Jump to Next Digit (4)
		JMP NEXTDIGIT4

; Check Overflow (2)
CHKOVERFLOW2:
		CMP BX,0
		; if (Index of Total Payment == 0) --> Set Overflow Flag (2)
		JE SETOVERFLOWFLAG2
		; if (Index of Total Payment != 0) --> Round Up (2)
		JNE ROUNDUP2

; Set Overflow Flag (2)
SETOVERFLOWFLAG2:
		MOV OVF,1
		; Jump to Next Digit (4)
		JMP NEXTDIGIT4

; Prepare Handle Overflow (2)
PHANDLEOVERFLOW2:
		CMP OVF,0
		; if (Overflow Flag == 0) --> ; Display Order Details // Haven't done for Display Order Details
		JE ORDERDETAILS	; --> JMP ORDERDETAILS
		; Increase Actual Array Length by 1
		INC ACT_TTPY_LEN
		INC DPI_TTPY
		MOV BH,0
		MOV BL,ACT_TTPY_LEN
		MOV CX,BX

; Handle Overflow (2)
HANDLEOVERFLOW2:
		; Move forward every element in the Array
		MOV AL,TTPY[BX - 1]
		MOV TTPY[BX],AL
		DEC BX
		LOOP HANDLEOVERFLOW2

; Add Digit (2)
ADDDIGIT2:
		SUB TTPY[1],3AH
		MOV TTPY[0],'1'

		; Display Order Details // Haven't done for Display Order Details
		;JMP PROMPTCUSTPY	; --> JMP ORDERDETAILS

; Display Order Details
ORDERDETAILS:
		; Pending Construction
		; Clear Screen
		MOV AX,02H
		INT 10H
		
	;Display header
		MOV AH,09H
		LEA DX,TITORDERDETAIL
		INT 21H
		LEA DX,SEPARATESPACE
		INT 21H
		
		MOV AH,09H
		LEA DX,ODETAIL
		INT 21H
		LEA DX,SEPARATELINE

	;display the algorithm (display ordered items)
		;MOV CX,listIndex
		;MOV SI,0
		;JMP displayItem
DISPLAY_payment:
	;display seperate line
		MOV AH,09H
		LEA DX,SEPARATESPACE
		INT 21H

	;display all 4 details 
		;ORDER AMMOUNT TITILE 
		MOV AH,09H
		LEA DX,ORDERAM
		INT 21H

	;AMOUNT
		MOV AH,09H
		LEA DX,orderAmountCal
		INT 21H

		;SST
		MOV AH,09H
		LEA DX,SSTMSG
		INT 21H
	;AMOUNT
		MOV AH,09H
		LEA DX,SST
		INT 21H

		;SERVICE TAX
		MOV AH,09H
		LEA DX,SRVMSG
		INT 21H
		
		;AMOUNT
		MOV AH,09H
		LEA DX,STX
		INT 21H

		MOV AH,09H
		LEA DX,TOTPAY
		INT 21H

		MOV AH,09H
		LEA DX,TTPY
		INT 21H
		
		MOV AH,09H
		LEA DX, CONTINUE
		INT 21H

		MOV AH,01H
		INT 21H

; Prompt for Customer Payment
PROMPTCUSTPY:
		MOV AH,09H
		LEA DX,NL
		INT 21H
		LEA DX,SST
		INT 21H
		LEA DX,NL
		INT 21H
		LEA DX,STX
		INT 21H
		LEA DX,NL
		INT 21H
		LEA DX,TTPY
		INT 21H
		LEA DX,NL
		INT 21H
		; Display Message 1
		MOV AH,09H
		LEA DX,MSG1
		INT 21H

		; Reset Decimal Point Counter to 0 before Read Customer Payment
		MOV DPCOUNT,0
		; Jump to Read Customer Payment
		JMP GETCUSTPY
		
; Read Customer Payment
GETCUSTPY:
		; Get user input
		MOV AH,0AH
		LEA DX,CUSTPY_PARA
		INT 21H

		CMP CUSTPY[0],0DH
		; if (first user input == 0DH) --> Invalid Customer Payment
		JE IVCUSTPY

		CMP CUSTPY[0],'0'
		; if (first user input == '0') --> Invalid Customer Payment
		JE IVCUSTPY

		CMP ACT_CUSTPY_LEN,8
		; if (Actual Array Length > 8) --> Large Customer Payment
		JA LARGECUSTPY

		; Prepare for Index Count
		MOV SI,0
		; if (first user input != 0DH) --> Validate Customer Payment
		JNE CHKPAY

; Invalid Customer Payment
IVCUSTPY:
		; Display Alert Message 3
		MOV AH,09H
		LEA DX,ALERT3
		INT 21H
		; Display New Line
		LEA DX,NL
		INT 21H
		; Display Continue Message
		LEA DX,RETURN
		INT 21H

		; Read any key
		MOV AH,01H
		INT 21H

		; Clear Screen
		MOV AX,02H
		INT 10H

		; Prompt Order Details again // Haven't done for Display Order Details
		JMP PROMPTCUSTPY	; --> JMP ORDERDETAILS

; Large Customer Payment
LARGECUSTPY:
		; Display Alert Message 4
		MOV AH,09H
		LEA DX,ALERT4
		INT 21H
		; Display New Line
		LEA DX,NL
		INT 21H
		; Display Continue Message
		LEA DX,RETURN
		INT 21H

		; Read any key
		MOV AH,01H
		INT 21H

		; Clear Screen
		MOV AX,02H
		INT 10H

		; Prompt Order Details again // Haven't done for Display Order Details
		JMP PROMPTCUSTPY	; --> JMP ORDERDETAILS

; Validate Customer Payment
CHKPAY:
		CMP CUSTPY[SI],'.'
		; if (AL == '.') --> Found Decimal Point
		JE DPFOUND

		CMP CUSTPY[SI],'0'
		; if (user input < '0') --> Invalid Customere Payment
		JB IVCUSTPY

		CMP CUSTPY[SI],'9'
		; if (user input <= '9') --> Valid Customere Payment
		JBE VCUSTPY
		; if (user input > '9') --> Invalid Customere Payment
		JA IVCUSTPY

; Found Decimal Point
DPFOUND:
		; Save Decimal Point Index For Customer Payment
		MOV DPI_CUSTPY,SI

		; Increase Decimal Point Counter by 1
		INC DPCOUNT
		CMP DPCOUNT,1
		; if (Decimal Point Counter == 1) --> Check Decimal Point Index For Customer Payment
		JE CHKDPI_CUSTPY
		; if (Decimal Point Counter != 1) --> Invalid Customere Payment (more than 1 decimal point)
		JNE IVCUSTPY

; Check Decimal Point Index For Customer Payment
CHKDPI_CUSTPY:
		CMP DPI_CUSTPY,5
		; if (Decimal Point Index For Customer Payment > 5) --> Large Customer Payment
		JA LARGECUSTPY

		CMP DPI_CUSTPY,0
		; if (Decimal Point Index For Customer Payment == 0) --> Adjust Actual Array Length
		JE ADJACTLEN
		; if (Decimal Point Index For Customer Payment != 0) --> Validate Customer Payment
		INC SI
		JNE CHKPAY

; Adjust Actual Array Length
ADJACTLEN:
		; Increase Actual Array Length by 1
		INC ACT_CUSTPY_LEN
		MOV BH,0
		MOV BL,ACT_CUSTPY_LEN
		MOV CX,BX
		JMP SORTCUSTPY

; Sort Customer Payment
SORTCUSTPY:
		; Move forward every element in the Array
		MOV AL,CUSTPY[BX - 1]
		MOV CUSTPY[BX],AL
		DEC BX
		LOOP SORTCUSTPY

		; Jump to Add '0'
		JMP ADDZERO

; Add '0'
ADDZERO:
		; Add '0' to the integer part of the Customer Payment (Index 0)
		MOV CUSTPY[0],'0'

		; Reset Decimal Point Counter to 0 before Validate Customer Payment again
		MOV DPCOUNT,0
		; Validate Customer Payment again to make sure the Customer Payment is correct
		JMP CHKPAY

; Valid Customer Payment
VCUSTPY:
		MOV BH,0
		MOV BL,ACT_CUSTPY_LEN
		DEC BX
		CMP SI,BX
		; if (SI == Actual Array Length) --> Check Decimal Point Count
		JE CHKDPCOUNT
		; if (SI != Actual Array Length) --> Validate Customer Payment
		INC SI
		JNE CHKPAY

; Check Decimal Point Count
CHKDPCOUNT:
		CMP DPCOUNT,0
		; If no Decimal Point Found --> Add Decimal Point
		JE ADDDP
		; If Decimal Point Found --> Validate whether Customer Payment is 2 Decimal Places
		JNE V2DP

; Add Decimal Point
ADDDP:
		CMP ACT_CUSTPY_LEN,5
		; if (Actuall Array Length >= 5) --> Invalid Customer Payment
		JA IVCUSTPY

		; Add '.00'
		MOV BH,0
		MOV BL,ACT_CUSTPY_LEN
		ADD ACT_CUSTPY_LEN,3
		; Save Decimal Point Index For Customer Payment
		MOV DPI_CUSTPY,BX
		MOV CUSTPY[BX],'.'

ADD2DP:
		MOV CUSTPY[BX + 1],'0'

ADD1DP:
		MOV CUSTPY[BX + 2],'0'
		
		; Jump to Calculate Payment
		JMP CALPY

; Validate whether Customer Payment is 2 Decimal Places
V2DP:
		MOV AH,0
		MOV AL,ACT_CUSTPY_LEN
		DEC AX
		MOV BX,DPI_CUSTPY
		CMP BX,AX
		; if (Decimal Point Index For Customer Payment == Actual Array Length - 1) --> Add 2 Decimal Places
		JE ADD2DP
		INC BX
		CMP BX,AX
		; if (Decimal Point Index For Customer Payment + 1 == Actual Array Length - 1) --> Add 2 Decimal Places
		JE ADD1DP
		INC BX
		CMP BX,AX
		; if (Decimal Point Index For Customer Payment + 2 == Actual Array Length - 1) --> Calculate Payment
		JE CALPY
		; else --> Too Much Decimal Places
		JMP ONLY2DP

; Too Much Decimal Point
ONLY2DP:
		; Display Alert Message 5
		MOV AH,09H
		LEA DX,ALERT5
		INT 21H
		; Display New Line
		LEA DX,NL
		INT 21H
		; Display Continue Message
		LEA DX,CONTINUE
		INT 21H

		; Read any key
		MOV AH,01H
		INT 21H

		; Clear Screen
		MOV AX,02H
		INT 10H

		; Prompt Order Details again // Haven't done for Display Order Details
		JMP PROMPTCUSTPY	; --> JMP ORDERDETAILS

; Insufficcient Payment
ISPY:
		; Display Alert Message 2
		MOV AH,09H
		LEA DX,ALERT2
		INT 21H
		; Display New Line
		LEA DX,NL
		INT 21H
		; Display Continue Message
		LEA DX,CONTINUE
		INT 21H

		; Read any key
		MOV AH,01H
		INT 21H

		; Clear Screen
		MOV AX,02H
		INT 10H

		; Prompt Order Details again // Haven't done for Display Order Details
		JMP PROMPTCUSTPY	; --> JMP ORDERDETAILS

; Calculate Payment
CALPY:
		MOV AL,ACT_CUSTPY_LEN
		CMP AL,ACT_TTPY_LEN
		; if (Customer Amount Length < Order Amount Length) --> Insufficcient Payment
		JB ISPY
		; if (Customer Amount Length > Order Amount Length) --> Sufficcient Payment
		JA SPY
		MOV CH,0
		MOV CL,ACT_CUSTPY_LEN
		MOV DI,0

; Check whether Customer Payment is equal to Total Payment
CHKEQUAL:
		MOV AL,CUSTPY[DI]
		CMP AL,TTPY[DI]
		; if (Customer Payment[DI] < Total Payment[DI]) --> Insufficcient Payment
		JB ISPY
		; if (Customer Payment[DI] > Total Payment[DI]) --> Sufficcient Payment
		JA SPY
		INC DI
		LOOP CHKEQUAL

; Changes is Zero (Customer Payment == Total Payment)
ZEROCHANGES:
		MOV ACT_CHG_LEN,4
		MOV CHG[0],'0'
		MOV CHG[1],'.'
		MOV CHG[2],'0'
		MOV CHG[3],'0'
		; Jump to Display Receipt
		JMP DISPLAYRECEIPT

; Sufficcient Payment
SPY:
		MOV BH,0
		MOV BL,ACT_CUSTPY_LEN

; Prepare Calculate Changes
PCALCHG:
		MOV CH,0
		MOV CL,ACT_CUSTPY_LEN
		MOV ACT_CHG_LEN,CL
		MOV DI,0

; Backup Customer Payment
BKCUSTPY:
		MOV AL,CUSTPY[DI]
		MOV CHG[DI],AL
		INC DI
		LOOP BKCUSTPY

		MOV CX,BX
		MOV AL,ACT_CUSTPY_LEN
		SUB AL,ACT_TTPY_LEN
		SUB CL,AL
		DEC BX
		MOV AH,0
		MOV AL,ACT_CUSTPY_LEN
		MOV DI,AX
		DEC DI

; Calculate Changes
CALCHG:
		CMP CHG[BX],'.'
		; if (Changes[DI] == '.') --> Skip Digit
		JE SKIPDIGIT
		MOV SI,BX
		MOV AL,TTPY[DI]
		CMP CHG[BX],AL
		; if (Changes[DI] == Total Payment) --> Set Changes[DI] = '0'
		JE CHGDIZERO
		; if (Changes[DI] > Total Payment) --> Next Digit (6)
		JA NEXTDIGIT6

; Check Decimal Point
CHKDP:
		DEC SI
		CMP CHG[SI],'.'
		; if (Changes[SI] == '.') --> Skip Decimal Point
		JE SKIPDP

; Check Zero
CHKZERO:
		CMP CHG[SI],'0'
		; if (Changes[SI] == '0') --> When Zero
		JE WHENZERO
		SUB CHG[SI],1
		; Jump to Next Digit (5)
		JMP NEXTDIGIT5

; When Zero
WHENZERO:
		MOV CHG[SI],'9'
		CMP CHG[SI - 1],'.'
		; if (Changes[SI - 1] == '.') --> When Decimal Point
		JE WHENDP
		CMP CHG[SI - 1],'0'
		; if (Changes[SI - 1] != '0') --> Substract Changes[SI - 1] by 1
		JNE SUBONE
		DEC SI
		; Jump to When Zero
		JMP WHENZERO

; When Decimal Point
WHENDP:
		SUB SI,2
		; Jump to When Zero
		JMP WHENZERO

; Substract Changes[SI - 1] by 1
SUBONE:
		SUB CHG[SI - 1],1
		; Jump to Next Digit (5)
		JMP NEXTDIGIT5

; Skip Decimal Point
SKIPDP:
		JMP CHKDP

; Set Changes[DI] = '0'
CHGDIZERO:
		MOV CHG[DI],'0'
		; Jump to Skip Digit
		JMP SKIPDIGIT

; Next Digit (5)
NEXTDIGIT5:
		ADD CHG[BX],0AH

; Next Digit (6)
NEXTDIGIT6:
		SUB CHG[BX],AL
		ADD CHG[BX],30H
		
; Skip Digit
SKIPDIGIT:
		DEC BX
		DEC DI
		LOOP CALCHG
		; Jump to Display Receipt
		JMP DISPLAYRECEIPT
		; MOV CX,BX
		; MOV SI,BX
		; MOV DI,0



		; MOV CHG[DI],


; Display Receipt
DISPLAYRECEIPT:
		MOV AH,09H
		LEA DX,NL
		INT 21H
		LEA DX,CHG
		INT 21H
		LEA DX,NL
		INT 21H

EXIT:	
		MOV AX,4C00H
		INT 21H
MAIN ENDP
END MAIN