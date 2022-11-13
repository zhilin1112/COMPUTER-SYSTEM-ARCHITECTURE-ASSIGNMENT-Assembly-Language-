.MODEL SMALL
.STACK 
.386
.DATA
;------------------------------GLOBAL: VARIABLES------------------------------;
	NL DB 0DH,0AH,"$"	; New Line
        
	CONTINUE DB "Press any key to continue...$"	; Continue Message

        ;RETURN MAIN MENU
        CONFEXT DB 13,10,"SURE TO QUIT? (Y/N): $" ; Confirmation Selection

        ;Selection on exit action
        SELTEXT DB ?

	RETURN DB "Press any key to return to upper level...$"	; Return Message
	P DB ?
        Q DB ?
        R DB ?
        S DB ?
        TEN1 DB 10
        TEN2 DW 10
        SLASHT DB "            $"
        HUNDRED DB 100

;------------------------------ZHILIN CHOICES -----------------------------------------
	;CHOICES OF DOUBLE CONFIRM (Y/N)
	CHOICES DB ? 
	
	;COMPARE 'Y'
	CHARFORY DB 'Y' 
	CHARFORN DB 'N'


;------------------------------LOGO VARIABLES------------------------------;
	;LOGO DESIGN 
	LOGO DB 13,10,"                                             =  =  =  =  =  =  =  =  =   "
	     DB 13,10,"    = = = =   ||  //   \\   //    = = = = //                           \\" 
	     DB 13,10,"   =          || //     \\ //     =       || =  =  =  =  =  =  =  =  = ||"
	     DB 13,10,"   =          ||//        \/      =  = = =||   //=\\    ||= =  ||= = = ||" 
	     DB 13,10,"   = = = =    |//         ||      =  =    ||  //   \\   ||     ||      ||"
	     DB 13,10,"         =    ||\\        ||      =  =    || // = = \\  ||= =  ||= = = ||"   
	     DB 13,10,"         =    || \\       ||      =  = = =||//       \\ ||     ||= = = ||" 
	     DB 13,10,"   = = = =    ||  \\      ||      = = = = || =  =  =  =  =  =  =  =  = ||"
	     DB 13,10,"                                                                         "
	     DB 13,10,"~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ WELCOME TO SKY CAFE ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~"

;------------------------------MAIN MENU VARIABLES------------------------------;
		;MAINMENU DESIGN
	MAINMENU     DB 13,10,13,10,"     ++===========================================================++"
		     DB 13,10,"     ||                       1. LOGIN                            ||"
		     DB 13,10,"     ||                       2. EXIT                             ||"
		     DB 13,10,"     ++===========================================================++$"

	;THE CHOICE OF THE MAIN MENU
	CHOICEMSG DB 13,10,13,10,"SELECTION: $"
	
	;INPUT FROM THE USER OF THE CHOICES  
	MAINCHOICES DB ? 
		
;------------------------------INVALID MESSAGE VARIABLES------------------------------;
	;MESSAGE WHEN USER KEY IN INVALID NUMBER FROM THE MENU
	ERRORMSG DB "  YOU HAD KEY IN INVALID NUMBER, PLEASE KEY IN AGAIN! $"
	
	;INVALID MESSAGE WHEN LOGIN SUCCESSFUL
	INVALIDMSG DB "  YOU HAD KEY IN INVALID PASSWORD OR USERNAME! PLEASE KEY IN AGAIN. $"
	
	;WHEN OVER 3 TIMES KEY IN WRONG PASS OR USERNAME MESSAGE
	BLOCKLOGIN DB "  YOU HAD KEY IN 3 TIMES INVALID PASSWORD OR USERNAME! $"

	;KEY IN TWO TIMES PASSWORD NOT EAUAL
	PSWNOTEQUAL DB "  YOU HAD KEY IN DIFFERENT NEW PASSWORD! PLEASE KEY IN AGAIN! $"
	
	;USER KEY IN INVALID CURRENT PASSWORD
	ACCINVALIDMSG DB "  YOU HAD KEY IN WRONG PASSWORD !! PLEASE KEY IN AGAIN. $"
		
;------------------------------CONFIRM MESSAGE VARIABLES------------------------------;
	;USER CHOOSE LOGOUT AND DOUBLE CONFIRM MESSAGE
	CONFIRMMSG DB 13,10,13,10,"		DO YOU CONFIRM WANT TO LOGOUT (Y = YES N = NO) ? $"

	;MESSAGE OF USER CHOOSE ACCOUNT SETTING TO RESET PASSWORD 
	CHGPSWTITILE DB 13,10,13,10,"       DO YOU WANT TO RESET YOUR PASSWORD (Y = YES N = NO) ? $"

        DUPCONFIRMSG DB 13,10,"DO YOU CONFIRM WANT TO CHANGE PASSWORD (Y/N)? $"

        RETURN2 DB 13,10,"PRESS ANY KEY TO LOGOUT... $"

;------------------------------SUCCESS MESSAGE VARIABLES------------------------------;
	;VALID MESSAGE WHEN LOGIN SUCCESSFUL
	VALIDMSG DB "        HELLO GAVIN, YOU HAD LOGIN SUCCESSFUL. WELCOME TO SKY CAFE! $"

	;SUCCESS LOGOUT MESSAGE
	LOGOUTMESG DB "            YOU HAD LOGOUT SUCCESSFULLY! $"
	THANKYOUMSG DB "          THANK YOU FOR USING THE SKYCAFE $"

	;SUCCESS CHANGE PASSWORD MESSAGE
	SUCESSCHGPSWMSG DB "  YOU HAD CHANGE THE PASSWORD SUCCESSFULLY !$"		
		
;------------------------------LOGIN MODULE: VARIABLES------------------------------;
	;LOGIN TITILE 
	LOGINTITILE DB "            LOGIN PAGE "
	      DB 13,10,"            ~~~~~~~~~~~ $"
		   
	;GET USERNAME AND PASSWORD TITLE
	USERNAMEMSG DB 13,10,"   USERNAME: $"
	USERPSWMSG DB 13,10,"   PASSWORD: $"
	
	;HARDCODE USERNAME AND PASSWORD
	USERNAME DB "SkyGavin$" 
	USERPSW DB "gavin$" ; password hardcode  DEFAULT  
	
	;INPUT USERNAME AND PASSWORD (USE ARRAY TO STORE THE INPUT)
	INUSERPSW DB 5 DUP(0) 
	NEWINPSW DB 5 DUP(0)
	
	STRUSERNAME LABEL BYTE
	MAXN DB 20
	ACTN DB ?
	INPUTUSERNAME DB 20 DUP ("$")
	;COUNT FOR TIMES LOGIN AND MAXIMUM IS 3 
	COUNT DB 0
	LIMITLOGIN DB 3

;------------------------------MENU VARIABLES------------------------------;
	;MENU OF THE WHOLE CAFE SYSTEM
	MENU DB 13,10,"       ++===========================================================++"
	     DB 13,10,"       ||                         MAIN MENU                         ||"
	     DB 13,10,"       ++===========================================================++"
	     DB 13,10,"       ||               1. PLACE ORDER                              ||"
	     DB 13,10,"       ||               2. GENERATE REPORT                          ||"
	     DB 13,10,"       ||               3. ACCOUNT SETTING                          ||"
	     DB 13,10,"       ||               4. LOGOUT                                   ||"
	     DB 13,10,"       ||               5. BACK TO LOGIN SCREEN                     ||"
	     DB 13,10,"       ++===========================================================++"
	     DB 13,10,13,10,"                WHAT DO YOU WANT TO CHOOSE(1 - 5): $"
			 
	;CHOOSEN OF THE MENU
	CHOOSE DB ?
			 
	;VARIABLE THAT LATER DO COMPARE AND JUMP TO PARTICULAR PLACE
	PLACEORDER DB 1
	REPORT DB 2
	ACCOUNT DB 3
	LOGOUT DB 4
	BACKMAINMENU DB 5

;------------------------------ACCOUNT SETTING MODULE: VARIABLES------------------------------;
	;ACCOUNT SETTING, NEW PASSWORD VARIABLE
	NEWPSW DB 5 DUP(0)

	;ACCOUNT SETTING TITILE 
	ACCSETITILE DB "            ACCOUNT SETTING PAGE "
				DB 13,10,"            ~~~~~~~~~~~~~~~~~~~~~ $"

	;MSG TO KEY IN CURRENT PASSWORD (FOR SECURITY PURPOSE)
	CURPSW DB 13,10,13,10,"PLEASE KEY IN YOUR CURRENT PASSWORD: $" 
	
	;MSG TO KEY IN NEW PASSWORD
	INPUTCHGPSW DB 13,10,13,10,"PLEASE KEY IN WHAT IS YOUR NEW PASSWORD: $"
	
	;MSG TO DOUBLE CONFIRM NEW PASSWORD
	CONFIRNEWPSWMSG DB 13,10,"PLEASE KEY IN NEW PASSWORD AGAIN: $"
					

;------------------------------PLACE ORDER MODULE: VARIABLES------------------------------;
		;Strings for menu
        EMSG DB 13,10,"           INVALID INPUT $"
        GETCHOICE DB 13,10,"           ENTER YOUR CHOICE : $"
        CONFIRMDELETE DB 13,10,"           ARE YOU SURE TO DELETE ? (Y\N) : $"
        itemDeleteSuccess DB 13,10,"           ITEM DELETED SUCCESSFULLY $"
        placeOrderMenu DB 13,10,13,10,"           ---MENU---"
        	       DB 13,10,"           1. DISPLAY DISH MENU"
        	       DB 13,10,"           2. DISPLAY DRINKS MENU"
        	       DB 13,10,"           3. DISPLAY SIDES MENU"
        	       DB 13,10,"           4. CANCEL ORDER "
        	       DB 13,10,"           5. PAYMENT "
        	       DB 13,10,"           6. RETURN TO MAIN MENU $"
        dishMenu       DB 13,10,13,10,"           ---DISH MENU--- "
                       DB 13,10,"           1. SPAGHETTI (RM 4)"
                       DB 13,10,"           2. NASI LEMAK(RM 5)"
                       DB 13,10,"           3. MARRYLAND CHICKEN CHOP(RM 7)"
                       DB 13,10,"           4. BLACK PEPPER STEAK (RM 7)"
                       DB 13,10,"           5. SANDWICH (RM 3)$"
        drinkMenu      DB 13,10,13,10,"           ---DRINK MENU---"
                       DB 13,10,"           1. ESPRESSO (RM 5)"
                       DB 13,10,"           2. MACCHIATO (RM 9)"
                       DB 13,10,"           3. AMERICANO (RM 5)"
                       DB 13,10,"           4. WHITE COFFEE (RM 4)"
                       DB 13,10,"           5. SOFT DRINKS (RM 3)$"
        sideMenu       DB 13,10,13,10,"           ---SIDES MENU---"
                       DB 13,10,"           1. FRENCH FRIES (RM 4)"
                       DB 13,10,"           2. FISH CAKE (RM 7)"
                       DB 13,10,"           3. GRILLED SHRIMP (RM 8)"
                       DB 13,10,"           4. APPLE PIE (RM 5)"
                       DB 13,10,"           5. CHEESE CAKE (RM 6)$"
        cancelOrder    DB 13,10,"           ---CANCEL ORDER--- "
                       DB 13,10,"             NO    ITEM                   QUANTITY      ORDERAMOUNT$"
        ;Input Message
        quantityMSG DB 13,10,"           ENTER THE QUANTITY : $"
        orderAmountMSG DB 13,10,"           ORDER AMOUNT : RM$"
        promptOrderState DB 13,10,"           ADD ANOTHER ITEM FROM THE MENU? (Y/N) $"
        totalOrderAmountMSG DB "               TOTAL ORDER AMOUNT : RM $"
        SPACES DB "             $"
        ;Item Names
        item1 DB "SPAGHETTI              $"
        item2 DB "NASI LEMAK             $"
        item3 DB "MARRYLAND CHICKEN CHOP $"
        item4 DB "BLACK PEPPER STEAK     $"
        item5 DB "SANDWICH               $"
        item6 DB "ESPRESSO               $"
        item7 DB "MACCHIATO              $"
        item8 DB "AMERICANO              $"
        item9 DB "WHITE COFFEE           $"
        item10 DB "SOFT DRINKS            $"
        item11 DB "FRENCH FRIES           $"
        item12 DB "FISH CAKE              $"
        item13 DB "GRILLED SHRIMP         $"
        item14 DB "APPLE PIE              $"
        item15 DB "CHEESE CAKE            $"
        ;Menu Item Price Array
        dishPrice DB 4,5,7,7,3
        drinkPrice DB 5,9,5,4,3
        sidePrice DB 4,7,8,5,6
        itemSelection DB ?
        ;Quantity Parameter List
        quantityParam LABEL BYTE
        MAX_QUAN_LEN DB 3
        ACT_QUAN_LEN DB ?
        quantityInput DB 3 DUP (0)
        ;Order Amount Parameter List
        orderAmountPram LABEL BYTE
        MAX_LEN DB 10
        ACT_LEN DB ?
        orderAmount DB 10 DUP ('$')
        ;orderItemNo Parameterr List
        orderNoParam LABEL BYTE
        MAX_ORDERNO_LEN DB 4
        ACT_ORDERNO_LEN DB ?
        orderNo DB 4 DUP ('$')
        ;Single Variables
        quantity DB 0
        orderState DB ?
        OA DW 0	
        choice DB ? 
        orderNoToDel DB 0
        ;Arrays
        orderCount DB 15 DUP (0)
        ;Arrays : Cancel Order Feature : Track User Inputs to know wut they ordered,
        menuChoiceList DB 20 DUP (0)
        itemChoiceList DB 20 DUP (0)
        quantityList DB 20 DUP (0)
        orderAmountList DW 20 DUP (?)
        ;CVTPARAMTOVAR Parameters
        ;SI <- Offset of the array
        arrSize DB 0
        ;CVTVARTOPARAM Parameters (Limit up to 999)
        ;SI <- Offset of the array u want the var to convert to
        ;varIn <- Variable Input to be converted
        varIn DW 0
        ;Item Price List
        ITEMPRICE DB 10 DUP ('$')
        ;Temporary variable for DW
        tempDW DW ?
        TWO DW 2
        tempIndex DW ?
        tspace DB "    $"
        moneyHeader DB "RM $"
        longline DB "           ----------------------------------------------------------$"
        noItemMsg DB 13,10,"YOU HAVE ORDERED 0 ITEMS UNABLE TO CANCEL!$"
        deleteCancel DB 13,10,"           ITEM DELETION CANCELLED!$"
        beforeOA DB 13,10,"           BEFORE ORDER AMOUNT : $"
        afterOA DB 13,10,"           NEW ORDER AMOUNT : $"
        DPI_OA DW ?	; Decimal Point Index For Order Amount
	listIndex DW 0
        payStatus DB ?
        finalOrderAmount DB 10 DUP ('$')

;------------------------------PAYMENT MODULE: VARIABLES------------------------------;

	ALERT1 DB "NO ORDER FOUND!$"	; Alert Message 1
	ALERT2 DB "INSUFFICIENT PAYMENT! PLEASE TRY AGAIN!$"	; Alert Message 2
	ALERT3 DB "INVALID PAYMENT! PLEASE TRY AGAIN!$"	; Alert Message 3
	ALERT4 DB "PAYMENT TOO LARGE! PLEASE TRY AGAIN!$"	; Alert Message 4
	ALERT5 DB "ONLY 2 DECIMAL PLACES ALLOWED! PLEASE TRY AGAIN!$"	; Alert Message 5
	ALERT6 DB "                              PAYMENT SUCCESSFUL!$"	; Alert Message 6
	MSG1 DB "             ENTER CUSTOMER PAYMENT : RM $"	; Message 1
	OLHEADER DB 13,10,"           *********************************************************"
                 DB 13,10,"                                   Order List                       "
	         DB 13,10,"           *********************************************************"
	         DB 13,10,"             NO    ITEM                 QUANTITY       ORDERAMOUNT  "
	         DB 13,10,"           ---------------------------------------------------------$"
	ENDLINE  DB 13,10,"           ---------------------------------------------------------$"
	SHOWOA   DB 13,10,"             ORDER AMOUNT           : RM $"
	SHOWSST  DB 13,10,"             SALES TAX (SST)        : RM $"
	SHOWSTX  DB 13,10,"             SERVICE TAX            : RM $"
	SHOWTTPY DB 13,10,"             TOTAL PAYMENT          : RM $"
	RECEIPT1  DB 13,10,"           =========================================================="
	          DB 13,10,"                                 ORDER NO: $";XXX
	RECEIPT2  DB 13,10,"           ----------------------------------------------------------"
	          DB 13,10,"                        INVOICE  $";DD/MM/YY
        RECEIPT3  DB "  $";HH:MM:SS
	RECEIPT4  DB 13,10,"           **********************************************************"
                  DB 13,10,"                                   Order List                        "
	          DB 13,10,"           **********************************************************"
	          DB 13,10,"             NO    ITEM                   QUANTITY      ORDERAMOUNT  "
	          DB 13,10,"           ----------------------------------------------------------$"
	ENDLINE1  DB 13,10,"           ----------------------------------------------------------$"
	PRINTOA   DB 13,10,"             ORDER AMOUNT     :                       RM $";     1.50
	PRINTSST  DB 13,10,"             SALES TAX (SST)  :                       RM $";    20.00
	PRINTSTX  DB 13,10,"             SERVICE TAX      :                       RM $";   300.00
	PRINTTTPY DB 13,10,"             TOTAL PAYMENT    :                       RM $";  4000.00
	PRINTCTPY DB 13,10,"             CUSTOMER PAYMENT :                       RM $";  4000.00
	PRINTCHG  DB 13,10,"             CHANGES          :                       RM $"; 50000.00
	RECEIPTF  DB 13,10,"           ----------------------------------------------------------"
	          DB 13,10,"                          THANKS FOR YOUR PURCHASING!                "
                  DB 13,10,"                          PLEASE COME AGAIN NEXT TIME!               "
                  DB 13,10,"           ==========================================================$"
	OVF DB 0	; Overflow Flag
        TWO1 DB 2       ; Two (DB)
        ZERO DB '0'     ; Zero ('0')
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
	CHG_PARA LABEL BYTE	; Changes Parameter List
	MAX_CHG_LEN DB 10	; Maximum Array Length
	ACT_CHG_LEN DB ?	; Actual Array Length
	CHG DB 10 DUP('$')	; Changes
        RECEIPTNO DB 0
	DPCOUNT DB 00D	; Decimal Point Counter
	DPI_TTPY DW ?	; Decimal Point Index For Total Payment
	DPI_CUSTPY DW ?	; Decimal Point Index For Customer Payment

;------------------------------REPORT MODULE: VARIABLES------------------------------;
        ; Report Types Menu
        RPTMENU1 DB       "                -----REPORT TYPES-----$" 
        RPTMENU2 DB 13,10,"           1. DISPLAY DAILY SUMMARY REPORT"
                 DB 13,10,"           2. DISPLAY POPULAR DISHES AND DRINKS REPORT"
                 DB 13,10,"           3. DISPLAY DAILY PROFIT REPORT "
                 DB 13,10,"           4. RETURN TO MAIN MENU"
                 DB 13,10
                 DB 13,10,"           ENTER SELECTION (1-4): $"

        ; Selection on report menu
        SELTRPT DB ? 

		; Label item types
	LAB1    DB 13,10,"           DISHES$"
        LAB2    DB 13,10,"           DRINKS$"
        LAB3    DB 13,10,"           SIDES $"

        ; SELTRPT == 1
        DATE     DB 13,10,"           DATE: $"
        RPTONE1  DB 13,10,"           --------------DAILY SUMMARY REPORT--------------"
                 DB 13,10,"           ================================================"
                 DB 13,10,"            NO.  ITEMS NAME                    QUANTITY"
                 DB 13,10,"           ------------------------------------------------$"
      
        ; Total Quantity
        DSTQTT   DB 0
        DRTQTT   DB 0
        SDTQTT   DB 0

        SPACE1 DB ".  $"
        SPACE2 DB "           $"

        ; Total Quantity
        TQTT DB 13,10,"           -------TOTAL QUANTITY OF 3 TYPES ITEMS-------"    
             DB 13,10,"           ============================================="  
             DB 13,10,"            TYPE                         QUANTITY       "  
             DB 13,10,"           ---------------------------------------------$"

        SPACE3 DB "                          $"

        ; Control item to print
        INDEX DB 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14 ;0-4 DS, 5-9 DR, 10-14 SD

        ;SELTRPT == 2
        RPTTWO  DB 13,10,"           ----POPULAR DISHES AND DRINKS REPORT----$"

        TOP1    DB 13,10,"           TOP 1 > $"
        TOP2    DB 13,10,"           TOP 2 > $"
        TOP3    DB 13,10,"           TOP 3 > $"

        ; Control display Quatity of item and Total Quatity item
        COUNT1 DB 0
        ; Control display Top '?'
        COUNT2 DB 0

        ; Use to sort
        SORTINDEX DB 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14 ;0-4 DS, 5-9 DR, 10-14 SD

        ;INVALID INPUT MESSAGE
        SELTIV  DB "           INVALID INPUT! PLEASE TRY AGAIN. $"

;-------------------------------------EXIT MESSAGE ------------------------------------------
		EXITMSG DB 13,10,"     +*************************************************************+ "
			DB 13,10,"     |  ======  ||     ||      // \\      ||\\    ||  ||  //       | "
			DB 13,10,"     |    ||    ||     ||     //   \\     || \\   ||  || //        | "
			DB 13,10,"     |    ||    || = = ||    // = = \\    ||  \\  ||  ||//         | "
			DB 13,10,"     |    ||    ||     ||   //       \\   ||   \\ ||  ||\\         | "
			DB 13,10,"     |    ||    ||     ||  //         \\  ||    \\||  || \\        | " 
			DB 13,10,"     |                                                             | "
			DB 13,10,"     |                         AND                                 | "
			DB 13,10,"     | --        --     _                                          | "
			DB 13,10,"     | \ \      / /_ _ | | _ _  _ _  _ __ ___    _ _               | "
			DB 13,10,"     |  \ \ /\ / /  _ \| |/ _ _/ _ \| '_ ' _ \ /  _ \              | "
			DB 13,10,"     |   \ \/\/ /_ _ _/| |  (_| (_) | | | | | |_ _ _/              | "
			DB 13,10,"     |    \_/\_/ \_ _ _|_|\_ _ \_ _/|_| |_| |_|\_ _ _              | "
			DB 13,10,"     +*************************************************************+ $"

        ;TITILE OF THE DIALY PROFIT REPORT
        PROFITRPTTIT    DB 13,10,"                   ----------DAILY TOTAL PROFIT--------             "
                        DB 13,10,"           +=================================================+"
                        DB 13,10,"           | NO    ORDER AMOUNT      PROFIT     CLEAN PROFIT |"
                        DB 13,10,"           +=================================================+$"
        ENDLINE2        DB       "           +=================================================+$"

        TOTALPROFITMSG DB 13,10,"           THE TOTAL PROFIT IS: RM $"
        noTransactionMSG DB "           NO TRANSACTION FOR THE DAY",13,10,"$"

        SPACE4 DB ".       $"
        SPACE5 DB "          $"
        SPACE6 DB "        $"
	SPACE7 DB "   $"

        ;ORDER AMOUNT IS NOT INCLUDED TAX JUST TOTAL UP ALL THE ITEM PRICE
        ;PROFIT CALCULATE THE TAX ALDY 
        ;CLEAN PROFIT = PROFIT - ORDERAMOUNT

	;Payment earned from the order(profit) 
        ;ringgit site
	PROFITRINGGIT DW 0    ;VAR1
        ;coin site
	PROFITSYILING DB 0   ;VAR2 
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

        OALIST DW 20 DUP (0)
        transactCountMSG DB 13,10,"          Total Transaction Done : $"

.CODE
MAIN PROC
		MOV AX,@DATA
		MOV DS,AX
                JMP DISPLAYLOGO

invalidQuitProgram:
        MOV AH,09H
        LEA DX,NL
        INT 21H
        
        MOV AH,09H
        MOV BH,0H
        MOV BL,04
        MOV CX,32
        LEA DX,SELTIV
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Display continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H

        ; Back to Report Types Menu
        JMP DISPLAYLOGO

;------------------------------LOGIN MODULE: START------------------------------;
CONFIRMEXIT:
        MOV AX, 02
	INT 10H

        ;----Confirm exit----
        ; Display confirmation exit message
        MOV AH,09H
        LEA DX,CONFEXT
        INT 21H
        
        ; Prompt Cormation (Y/N)
        MOV AH,01H
        INT 21H
        MOV SELTEXT,AL

        ;----Compare---
        CMP SELTEXT,"Y"
        JE DISPLAYTHANKYOUMSG

        CMP SELTEXT,"N"
        JNE invalidQuitProgram
        
        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Display return message
        MOV AH,09H
        LEA DX,RETURN
        INT 21H
        
        ; Get any key
        MOV AH,01H
        INT 21H

DISPLAYLOGO:
		;CLEAR SCREEN FIRST 
		MOV AX,02
		INT 10h
		
	;DISLOGO PROC NEAR
		;DISPLAY LOGO WITH BLINKING 
		MOV AX,@DATA

		MOV ES,AX				;ES (EXTRA SEGMENT) is typically used to point to the destination for a string copy (AX) DATA SEGMENT
		MOV AH,13H				;STATEMENT THAT DISPLAY STRING WITH COLOR
		MOV AL,0
		MOV BP,OFFSET LOGO		;STRING TO DISPLAY BY ALLOCATE THE OFFSET OF THE STRING(LOGO)
		MOV BH,0				;MOV THE PAGE TO BE ALWAYS ZERO
		MOV BL,181				;THE COLOR SETTING 
		MOV CX,750				;THE STRING LENGTH
		MOV DL,0				;MOVE THE X-AXIS OF THE SCREEN COORDINATE
		MOV DH,0				;MOVE THE Y-AXIS OF THE SCREEN COORDINATE
		INT 10H
		
		

		;DISPLAY MAIN MENU DESIGN
	
		MOV AH,09H
		LEA DX,NL
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		LEA DX,MAINMENU
		INT 21H 
	
		;DISPLAY THE CHOICE STATEMENT
		MOV AH,09H
		LEA DX,CHOICEMSG
		INT 21H
		
		;ACCEPT THE CHOICE 
		MOV AH,01H
		INT 21H
		SUB AL,30H
		MOV MAINCHOICES,AL 			;STORE THE INPUT CHOICE TO A VARIABLE
		
		;COMPARE IF KEY IN '2' THEN EXIT THE PROGRAM
		MOV AL,MAINCHOICES
		CMP AL,2
		JE CONFIRMEXIT
		
		;COMPARE IF IS '1' THEN GO TO LOGIN 
		CMP AL,1
		JE LOGIN
		
		MOV AH,09H
		LEA DX,NL
		INT 21h
		INT 21H
		
		;IF KEY IN OTHER NUMBER (NOT 1 OR 2 ) DISPLAY ERROR MESSAGE AND JUMP BACK TO MENU TO CHOOSE AGAIN
		MOV AH,09H
		MOV BL,04
		MOV CX,53
		INT 10H
		LEA DX,ERRORMSG
		INT 21H

		MOV AH,09H
		LEA DX,NL
		INT 21H
		LEA DX,CONTINUE
		INT 21H

		MOV AH,01H
		INT 21H
		JMP DISPLAYLOGO
		
		DISPLAYTHANKYOUMSG:
		;CLEAR SCREEN FIRST 
		MOV AX,02
		INT 10h

		MOV AH,09H
		LEA DX,NL
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H
		INT 21H

		
		MOV AH,09H
		MOV BL,03
		MOV CX,42
		INT 10H
		LEA DX,THANKYOUMSG
		INT 21H
                LEA DX,transactCountMSG
                INT 21H
                MOV AH,02H
                MOV DX,orderIndex
                ADD DL,30H
                INT 21H
		JMP DISPLAYEXITMSG
		
		;WHEN CHOOSE TO LOGIN 
		LOGIN:
			;CLEAR SCREEN FIRST 
			MOV AX,02
			INT 10H
		
			MOV AH,09H
			LEA DX,NL
			INT 21H
		
		; Display the LOGIN Titile 
		MOV AH,09H
		MOV BL,06		;CHANGE THE TEXT COLOR
		MOV CX,22		;THE NO OF CHAR THAT I WANT TO CHANGE COLOR 
		INT 10H
		LEA DX,LOGINTITILE
		INT 21H
		
		;LOOP WHEN THE USER KEY IN INVALID PSW 
		PROMPTUSERNAME: 
			;DISPLAY USERNAME LINE
			MOV AH,09H
			LEA DX,USERNAMEMSG
			INT 21H
		
			MOV AH,0AH 
			LEA DX,STRUSERNAME
			INT 21H
		
		;DISPLAY Password LINE
		PROMPTPASSWORD:
			MOV AH,09H
			LEA DX,USERPSWMSG
			INT 21H
		
		MOV CX,5		; FOR LOOPING 5 TIMES 
		MOV SI,0		; FOR THE INDEX START FROM 0
		
		;GET INPUT FROM USER FOR PASSWORD
		GETPSW:
			MOV AH,07H
			INT 21H
			MOV INUSERPSW[SI],AL		;STORE THE INPUT INTO THE VARIABLE
			INC SI

			;DISPLAY BY ASTERIK 
			MOV AH,02H
			MOV DL,42
			INT 21H
		LOOP GETPSW
		
		;CHECK START FROM INDEX '0'
		MOV SI,0
		
		;CHECK USERNAME FIRST
		CHECKUSERNAME:
			MOV AH,0
			MOV AL,ACTN
			CMP SI,AX
			JNE CHECKNEXT ;IF NOT EQUAL GO TO CHECKNEXT
			
			;IF EQUAL THEN GO TO CHECK PASSWORD 
			MOV SI,0 	; MOVE BACK THE INDEX TO 0 FOR CHECKING
		
		
		;CHECK THE NUMBER OF THE PASSWORD
		CHECKPSW: 
			CMP SI,5
			JE CLEARSCREEN			;IF EQUAL THEN GO TO THE PRINT LOOP  --> GO TO CLEAR SCREEN FIRST
		
		;CHECK ONE BY ONE CHAR WITH THE HARDCODE PASSWORD AND THE INPUT PASSWORD
			MOV BL,INUSERPSW[SI]
			CMP BL,USERPSW[SI]
			JNE INVALID		;IF NOT EQUAL THEN PRINT INVALID MESSAGE 
		
			INC SI
			JMP CHECKPSW
		
		CHECKNEXT:
			MOV BL,INPUTUSERNAME[SI]
			CMP BL,USERNAME[SI]
			JNE INVALID
		
			INC SI
			JMP CHECKUSERNAME
		
		;IF USERNAME AND PASSWORD ARE CORRECT THEN PRINT SUCCESS MESSAGE 
		PRINT:
			MOV AH,09H
			LEA DX,NL
			INT 21H
		
			MOV AH,09H
			MOV BL,03
			MOV CX,69
			INT 10H
			LEA DX,VALIDMSG
			INT 21H
			JMP PRINTMENU   	;GO TO DISPLAY MENU 
		
		MOV COUNT,0 
		;PRINT INVALID MESSAGE WHEN INPUT USERNAME OR PASSWORD IS NOT EQUAL TO THE HARDCODE 
		INVALID:
			INC COUNT				;INCREASE THE COUNT THAT KEY IN INVALID INFO
			MOV AH,COUNT
			CMP AH,LIMITLOGIN		;COMPARE THE COUNT IF OVER THE LIMIT THEN WILL PRINT AND BLOCK THE USER KEY IN AGAIN
			JE PRINTBLOCKLOGIN
			
			MOV AH,09H
			LEA DX,NL
			INT 21H
			
			MOV AH,09H
			LEA DX,NL
			INT 21H
			
			MOV AH,09H
			MOV BL,04
			MOV CX,67
			INT 10H
			LEA DX,INVALIDMSG
			INT 21H		
			JMP PROMPTUSERNAME
		
		;DISPLAY MESSAGE THAT OVER LIMIT AND EXIT THE PROGRAM 
		PRINTBLOCKLOGIN:
			;CLEAR SCREEN FIRST 
			MOV AX,02
			INT 10h

			MOV AH,09H
			LEA DX,NL
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			
			MOV AH,09H
			MOV BL,04
			MOV CX,54
			INT 10H
			LEA DX,BLOCKLOGIN
			INT 21H
			
			MOV AH,09H
			LEA DX,NL
			INT 21H
			
			MOV AH,09H
			MOV BL,03
			MOV CX,42
			INT 10H
			LEA DX,THANKYOUMSG
			INT 21H
			JMP DISPLAYEXITMSG
			
		
		CLEARSCREEN:
			MOV AX,02
			INT 10H
			JMP PRINT
		
		;DISPLAY THE MENU OF THE CAFE SYSTEM 
		PRINTMENU:
			MOV AH,09H
			LEA DX,MENU
			INT 21H 
		
		;TO GET THE INPUT 
		GETCHOOSE:
			MOV AH,01H
			INT 21H
			SUB AL,30H
			MOV CHOOSE,AL
		
		MOV AL,CHOOSE
		CMP AL,LOGOUT
		JE GOTOLOGOUT
		
		CMP AL,BACKMAINMENU
		JE DISPLAYLOGO
		
		CMP AL,PLACEORDER
		JE ORDERMENU  			;PARTICULAR PLACEORDER MENU
		
		CMP AL,REPORT
		JE SELTREPORT			;PARTICULAR REPORT MENU
		
		CMP AL,ACCOUNT
		JE GOTOACCOUNT
		
		JMP PRINTINMSG
		
		GOTOACCOUNT:
			;CLEAR SCREEN 
			MOV AX,02
			INT 10H
		
			MOV AH,09H
			LEA DX,NL
			INT 21H

			MOV AH,09H
			MOV BL,06
			MOV CX,33
			INT 10H
			LEA DX,ACCSETITILE
			INT 21H
			
			MOV AH,09H
			LEA DX,CHGPSWTITILE
			INT 21H
		
			MOV AH,01H
			INT 21H
			MOV CHOICES,AL
		
		MOV AL,CHOICES
		CMP AL,CHARFORY
		JE CONTINUECHGPSW
		
		CMP AL,CHARFORN
		JNE DISERRORMSG
		
		MOV AH,09H
		LEA DX,NL
		INT 21H
		
		MOV AH,09H
		LEA DX,CONTINUE
		INT 21H
		
		MOV AH,01H
		INT 21H
		
		;CLEAR SCREEN FIRST 
		MOV AX,02
		INT 10H
		
		JMP PRINTMENU
		
		DISERRORMSG:
			MOV AH,09H
			LEA DX,NL
			INT 21H
		
			MOV AH,09H
			MOV BL,04
			MOV CX,53
			INT 10H
			LEA DX,ERRORMSG
			INT 21H
			JMP GOTOACCOUNT
		
		GOTOLOGOUT:
			MOV AH,09H
			LEA DX,CONFIRMMSG
			INT 21H
		
		GETCONFIRM: 
			MOV AH,01H
			INT 21H
			MOV CHOICES,AL
		
		MOV AL,CHOICES
		CMP AL,CHARFORY  ; COMPARE IS Y OR NOT
		JE LOGOUTMSG
		
		CMP AL,CHARFORN
		JNE DISPLAYERRORMSG

		MOV AH,09H
		LEA DX,NL
		INT 21H
		
		MOV AH,09H
		LEA DX,CONTINUE
		INT 21H
		
		MOV AH,01H
		INT 21H
		
		;CLEAR SCREEN FIRST 
		MOV AX,02
		INT 10H
		JMP PRINTMENU
		
		DISPLAYERRORMSG:
			MOV AH,09H
			LEA DX,NL
			INT 21H

		
			MOV AH,09H
			MOV BL,04
			MOV CX,53
			INT 10H
			LEA DX,ERRORMSG
			INT 21H
			JMP GOTOLOGOUT
		
		LOGOUTMSG: 

			;CLEAR SCREEN FIRST 
			MOV AX,02
			INT 10h

			MOV AH,09H
			LEA DX,NL
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H
			INT 21H

		
			MOV AH,09H
			MOV BL,03
			MOV CX,40
			INT 10H
			LEA DX,LOGOUTMESG
			INT 21H
			
			MOV AH,09H
			LEA DX,NL
			INT 21H
			
			MOV AH,09H
			MOV BL,03
			MOV CX,42
			INT 10H
			LEA DX,THANKYOUMSG
			INT 21H
                        
                        MOV AH,09H
                        LEA DX,transactCountMSG
                        INT 21H
                        MOV AH,02H
                        MOV DX,orderIndex
                        ADD DL,30H
                        INT 21H
			JMP DISPLAYEXITMSG
		
		CONTINUECHGPSW:
			MOV AH,09H
			LEA DX,CURPSW
			INT 21H
		
		MOV CX,5		
		MOV SI,0
		
		GETACCPSW:
			MOV AH,07H
			INT 21H
			MOV INUSERPSW[SI],AL
			INC SI

			;DISPLAY BY ASTERIK 
			MOV AH,02H
			MOV DL,42
			INT 21H
		LOOP GETACCPSW
		
		MOV SI,0
		
		CHECKACCPSW: 
			CMP SI,5
			JE STARTCHGPSW			
			JNE CONTINUEACCCHECK
		
		CONTINUEACCCHECK:
			MOV BL,INUSERPSW[SI]
			CMP BL,USERPSW[SI]
			JNE ACCINVALID
		
			INC SI
			JMP CHECKACCPSW
		
		STARTCHGPSW:
			MOV AH,09H
			LEA DX,INPUTCHGPSW
			INT 21H
		
		MOV SI,0
		MOV CX,5
		
		ACCEPTNEWPSW:
			MOV AH,07H
			INT 21H
			MOV INUSERPSW[SI],AL
			INC SI

			;DISPLAY BY ASTERIK 
			MOV AH,02H
			MOV DL,42
			INT 21H
			LOOP ACCEPTNEWPSW
			
		MOV AH,09H
		LEA DX,CONFIRNEWPSWMSG
		INT 21H
		
		MOV SI,0
		MOV CX,5
		
		AGAINNEWPSW:
			MOV AH,07H
			INT 21H
			MOV NEWINPSW[SI],AL
			INC SI

			;DISPLAY BY ASTERIK 
			MOV AH,02H
			MOV DL,42
			INT 21H
		LOOP AGAINNEWPSW
		
		MOV SI,0
		MOV CX,5
		
		COMPAREPSW:
			MOV AL,INUSERPSW[SI]
			CMP AL,NEWINPSW[SI]
			JNE DISPSWNOTEQUAL
		
			INC SI
		LOOP COMPAREPSW
		MOV SI,0
		MOV CX,5
		
		DUPCONFIRM:
			MOV AH,09H
			LEA DX,DUPCONFIRMSG
			INT 21H
			MOV AH,01H
			INT 21H
			CMP AL,CHARFORY
			JE CHANGEPASSWORD

			CMP AL,CHARFORN
			JE CONTINUEMSG

			MOV AH,09H
			LEA DX,NL
			INT 21H

			MOV AH,09H
			MOV BL,04
			MOV CX,53
			INT 10H
			LEA DX,ERRORMSG
			INT 21H
			JMP DUPCONFIRM

		CONTINUEMSG:
			MOV AH,09H
			LEA DX,NL
			INT 21H

			MOV AH,09H
			LEA DX,CONTINUE
			INT 21H

			MOV AH,01H
			INT 21H

			;CLEAR SCREEN FIRST 
			MOV AX,02
			INT 10H
			JMP PRINTMENU
			
		CHANGEPASSWORD:
		;STORE THE NEW PASSWORD  
			MOV AL,INUSERPSW[SI]
			MOV USERPSW[SI],AL
			INC SI
		LOOP CHANGEPASSWORD
			MOV AH,09H
			LEA DX,NL
			INT 21H
		
			MOV AH,09H
			MOV BL,03
			MOV CX,44
			INT 10H
			LEA DX,SUCESSCHGPSWMSG
			INT 21H

			MOV COUNT,0
			JMP PRINTRERUTNMSG

                PRINTRERUTNMSG:
                        MOV AH,09H
			LEA DX,NL
			INT 21H

                        MOV AH,09H
                        LEA DX,RETURN2
                        INT 21H
                        
                        MOV AH,01H
                        INT 21H

                        JMP DISPLAYLOGO
		
		MOV COUNT,0
		ACCINVALID:
			MOV AH,09H
			LEA DX,NL
			INT 21H
			
			MOV AH,09H
			LEA DX,NL
			INT 21H

			INC COUNT		;INCREASE THE COUNT THAT KEY IN INVALID INFO
			MOV AH,COUNT
			CMP AH,LIMITLOGIN		;COMPARE THE COUNT IF OVER THE LIMIT THEN WILL PRINT AND BLOCK THE USER KEY IN AGAIN
			JE PRINTBLOCKLOGIN
		
			MOV AH,09H
			LEA DX,NL
			INT 21H
		
			MOV AH,09H
			MOV BL,04
			MOV CX,55
			INT 10H
			LEA DX,ACCINVALIDMSG
			INT 21H
			JMP CONTINUECHGPSW
			
		DISPSWNOTEQUAL:
			MOV AH,09H
			LEA DX,NL
			INT 21H
			
			MOV AH,09H
			LEA DX,NL
			INT 21H
		
			MOV AH,09H
			MOV BL,04
			MOV CX,61
			INT 10H
			LEA DX,PSWNOTEQUAL
			INT 21H
			JMP STARTCHGPSW
		
		PRINTINMSG:
			MOV AH,09H
			LEA DX,NL
			INT 21H
		
			MOV AH,09H
			MOV BL,04
			MOV CX,53
			INT 10H
			LEA DX,ERRORMSG
			INT 21H
			JMP PRINTMENU
			
		DISPLAYEXITMSG:
			
			MOV AX,@DATA
			MOV ES,AX				;ES (EXTRA SEGMENT) is typically used to point to the destination for a string copy (AX) DATA SEGMENT
			MOV AH,13H				;STATEMENT THAT DISPLAY STRING WITH COLOR
			MOV AL,0
			LEA BP,EXITMSG		;STRING TO DISPLAY BY ALLOCATE THE OFFSET OF THE STRING(LOGO)
			MOV BH,0				;MOV THE PAGE TO BE ALWAYS ZERO
			MOV BL,181				;THE COLOR SETTING 
			MOV CX,994			;THE STRING LENGTH
			MOV DL,0				;MOVE THE X-AXIS OF THE SCREEN COORDINATE
			MOV DH,0				;MOVE THE Y-AXIS OF THE SCREEN COORDINATE
			INT 10h
			
			JMP EXIT

;------------------------------LOGIN MODULE: END------------------------------;


;------------------------------PLACE ORDER MODULE: START------------------------------;
        
orderMenu:
	;Start tracking the input
	MOV DI,listIndex
        ;clear screen
        MOV AX,02
        INT 10H
	;display order menu by categories
	MOV AH,09H
	LEA DX, placeOrderMenu
	INT 21H
        
        ;input message
        MOV AH,09H
        LEA DX,GETCHOICE
        INT 21H
	
	    ;read selection (Digit)
	    MOV AH,01H
	    INT 21H
	    SUB AL, 30H
	    MOV choice, AL

        ;validation
        CMP choice,1
        JGE validate1
        
        MOV AH,09H
        LEA DX,EMSG
        INT 21H
        JMP orderMenu
validate1:
        CMP choice,6
        JLE chk_order_selection
        MOV AH,09H
        LEA DX,EMSG
        INT 21H
        JMP orderMenu
invalidplaceOrderConfirm:
        MOV AH,09H
        LEA DX,NL
        INT 21H
        
        MOV AH,09H
        MOV BH,0H
        MOV BL,04
        MOV CX,32
        LEA DX,SELTIV
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Display continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H

        ; Back to Report Types Menu
        JMP orderMenu
returnMainMenu:
        
        ;Display Return message
        MOV AH,09H
        LEA DX,NL
        INT 21H
        LEA DX,return
        INT 21H
        
        MOV AH,01H
        INT 21H

        MOV AX,2
        INT 10H
        JMP printMenu

placeOrderConfirmBackToMenu:
        ; Clear screen
	MOV AX, 02
	INT 10H

        ;----Confirm exit----
        ; Display confirmation exit message
        MOV AH,09H
        LEA DX,CONFEXT
        INT 21H
        
        ; Prompt Cormation (Y/N)
        MOV AH,01H
        INT 21H
        MOV SELTEXT,AL

        ;----Compare---
        CMP SELTEXT,"Y"
        JE returnmainmenu

        CMP SELTEXT,"N"
        JNE invalidplaceOrderConfirm
        
        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Display continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H
        JMP orderMenu

chk_order_selection:
        ;Assign menu choice that the user inputed
        MOV BL,choice
        MOV menuChoiceList[DI],BL
        ;clear screen
        MOV AX,02
        INT 10H
	;if 6 Go Back To Main Menu
	CMP choice, 6
	JE placeOrderConfirmBackToMenu   
        ; 1 go to Dish_Menu
        CMP choice, 1
        JE dish_menu
        ; 2 go to Drink_Menu
        CMP choice, 2
        JE drink_menu
        ; 3 go to Side_Menu
        CMP choice, 3
        JE side_menu
        CMP choice, 4
        JE cancel_order
        ; 5 go to Payment
        CMP choice, 5
        JE chkpoint_payment1
dish_menu:
        ;display menu
        MOV AH,09H
        LEA DX,dishMenu
        INT 21H
        JMP get_choice
drink_menu:
        MOV AH,09H
        LEA DX,drinkMenu
        INT 21H
        JMP get_choice
side_menu:
        MOV AH,09H
        LEA DX,sideMenu
        INT 21H
        JMP get_choice
cancel_order:

        ;Check is there is items recorded in the list 
        CMP itemChoiceList[0],0
        JE no_items_to_display
        CMP DI,0
        JE no_items_to_display

        MOV payStatus,0 
        ;display header
        MOV AH,09H
        LEA DX,cancelOrder
        INT 21H
        LEA DX,NL
        INT 21H
        LEA DX,longLine
        int 21H
        ;Start displaying the items , DI is the size of the array
        ;[1][][][][] menuChoiceList
        ;[3][][][][] itemChoiceList
        ;[10][][][][] quantityList
        ;DI
        ;listIndex = 1 
        ;length of the ordered item array
        MOV CX,DI
        MOV SI,0
        JMP displayItems
no_items_to_display:
        ;Display No items to display error message
        MOV AH,09H
        LEA DX,noItemMsg
        INT 21H
        LEA DX,NL
        INT 21H
        LEA DX,CONTINUE
        INT 21H
        ;ask user to enter any key
        MOV AH,01H
        INT 21H
        ;go back to menu
        JMP orderMenu
displayItems:

        ;NEW LINE
        MOV AH,09H
        LEA DX,NL
        INT 21H
        LEA DX,SPACES
        INT 21H

        ;Order Number
        MOV AX,SI
        INC AX
        DIV TEN1
        MOV BX,AX
        MOV AH,02H
        MOV DL,BL
        ADD DL,30H
        INT 21H
        MOV DL,BH
        ADD DL,30H
        INT 21H
        MOV AH,09H
        LEA DX,tspace
        INT 21H
        ;Display Product
        CMP menuChoiceList[SI],1
        JE menu1
        CMP menuChoiceList[SI],2
        JE menu2
        CMP menuChoiceList[SI],3
        JE menu3
backToLoop:
        ;Display the price
        MOV AX,SI
        MUL TWO
        MOV BX,AX
        ;Temp store the SI
        MOV DX,SI

        INC SI
        LOOP displayitems

        CMP payStatus,1
        JE DISPLAYDONE
        CMP payStatus,2
        JE DISPLAYFINISH

        MOV AH,09H
        LEA DX,NL
        INT 21H
        LEA DX,longLine
        INT 21H
        LEA DX,NL
        INT 21H

        
        ;Get the total amount
        MOV BX,OA
        MOV varIn,BX
        LEA SI,orderAmount
        call CVTVARTOPARAM
        MOV AH,09H
        LEA DX,SLASHT
        INT 21H
        LEA DX,tspace
        INT 21H
        INT 21H
        LEA DX,totalOrderAmountMSG
        INT 21H
        LEA DX,orderAmount
        INT 21H

        JMP get_delete_choice
orderNo_error:
        MOV AH,09H
        LEA DX,EMSG
        INT 21H
get_delete_choice:
        ;Get user input
        MOV AH,09H
        LEA DX,GETCHOICE
        INT 21H

        ;user input(DIGIT),Parameter List
        MOV AH,0AH
        LEA DX,orderNoParam
        INT 21H
        ;Check if the user input 0
        CMP orderNo[0],"0"
        JE orderNo_error

        ;Convert the parameter list to digit
        MOV AL,ACT_ORDERNO_LEN
        MOV arrSize,AL
        LEA SI,orderNo
        CALL CVTPARAMTOVAR
        ;Get Output From AL
        MOV orderNoToDel,AL
        ;Validation Input
        MOV BH,0
        MOV BL,orderNoToDel
        CMP BX,DI
        JA orderno_error

        ;Send confirmation
        MOV AH,09H
        LEA DX,CONFIRMDELETE
        INT 21H
        
        ;Get Confirm(Char)
        MOV AH,01
        INT 21H

        CMP AL,'Y'
        JE deleteOrder
        CMP AL,'N'
        JE cancelDelete

        MOV AH,09H
        LEA DX,NL
        INT 21H
cancelDelete:
        ;Display Cancelled
        MOV AH,09H
        LEA DX,deleteCancel
        INT 21H
        ;Ask input to return back to menu
        LEA DX,NL
        INT 21H
        LEA DX,CONTINUE
        INT 21H
        MOV AH,01H
        INT 21H
        JMP orderMenu
deleteOrder:
        ;Delete Specific Element From The Array
        ;OA Subtraction - Success
        ;Array Shifting - TODO tmr
        ;Remove the records of total item orders - TODO tmr
        MOV BX,OA
        MOV varIn,BX
        LEA SI,orderAmount
        call CVTVARTOPARAM
        MOV AH,09H
        LEA DX,beforeOA
        INT 21H
        LEA DX,moneyHeader
        INT 21H
        ;Display OA (Before)
        MOV AH,09H
        LEA DX,orderAmount
        INT 21H
        ;Subtract the specific element from DW array to the OA 
        ;Convert Choice to index - 1 (1 = 2, 2 = 4, 3 = 6)
        DEC orderNoToDel
        MOV BH,0
        MOV BL,orderNoToDel
        ;BX = indexToDel, 0, Since handling DW arrays
        ;Need to Multiply by 2
        MOV AX,BX
        MUL TWO
        ;move the index to bx
        MOV BX,AX
        ;move oa to a register to do subtraction
        MOV DX,OA
        ;subtract
        SUB DX,orderAmountList[BX]
        ;put it back
        MOV OA,DX

        ;Menu Choice 1, 2, 3
        ;Quantity List a val
        ; if menu choice = 1 , sub orderCount[orderChoice[orderNoToDel]], quantityList[orderNoToDel]
        ; else if menu choice = 2, sub orderCount[5 + orderChoice[orderNoToDel]], quantityList[orderNoToDel]
        ; else sub orderCount[10 + orderChoice[orderNoToDel]], quantityList[orderNoToDel]

        MOV BH,0
        MOV BL,orderNoToDel
        MOV SI,BX
        CMP menuChoiceList[SI], 1
        JE del_orderCount_menu1
        CMP menuChoiceList[SI], 2
        JE del_orderCount_menu2
        ;else is 3
        MOV BL,quantityList[SI]
        SUB orderCount[SI+10],BL
        JMP shift_array_to_left
del_orderCount_menu1:
        MOV BL,quantityList[SI]
        SUB orderCount[SI], BL
        JMP shift_array_to_left 
del_orderCount_menu2:
        MOV BL,quantityList[SI]
        SUB orderCount[SI+5],BL
shift_array_to_left     :
        ;DI = length of the array
        ;orderNoToDel = Starting Index of shifting
        ;length - 1 = length to shift
        MOV BH,0
        MOV BL,orderNoToDel
        MOV SI,BX
        DEC DI
        MOV listIndex,DI
        ;Array Shifting
array_shift_to_left:
        CMP SI,DI
        JE shift_done
        MOV BL,menuChoiceList[SI + 1]
        MOV menuChoiceList[SI],BL
        MOV BL,itemChoiceList[SI + 1]
        MOV itemChoiceList[SI],BL
        MOV BL,quantityList[SI + 1]
        MOV quantityList[SI],BL
        ;Shifting Dw array
        MOV AX,SI
        MUL TWO
        MOV BX,AX
        MOV AX,orderAmountList[BX + 2]
        MOV orderAmountList[BX],AX
        INC SI
        JMP array_shift_to_left
shift_done:
        ;Display the order amount after the subtraction
        ;new line
        MOV AH,09H
        LEA DX,NL
        INT 21H
        LEA DX,afterOA
        INT 21H
        LEA DX,moneyHeader
        INT 21H
        ;Display First Element
        MOV BX,OA
        MOV varIn,BX
        LEA SI,orderAmount
        call CVTVARTOPARAM
        MOV AH,09H
        LEA DX,orderAmount
        INT 21H
        LEA DX,NL
        INT 21H
        LEA DX,itemDeleteSuccess
        INT 21H
        LEA DX,CONTINUE
        INT 21H
        MOV AH,01H
        INT 21H
        JMP orderMenu
chkpoint_exit1:
        JMP chkpoint_exit2
chkpoint_payment1:
        JMP chkpoint_payment2

chkpoint_menu1:
        JMP menu1
chkpoint_menu2:
        JMP menu2
chkpoint_menu3:
        JMP menu3

chkpoint_exit2:
        JMP chkpoint_exit3
chkpoint_payment2:
        JMP chkpoint_payment3
;if menu 1
menu1:  
        ;prepare to display string
        MOV AH,09H
        CMP itemChoiceList[SI], 1
        JE p1
        CMP itemChoiceList[SI], 2
        JE p2
        CMP itemChoiceList[SI], 3
        JE p3
        CMP itemChoiceList[SI], 4
        JE p4
        CMP itemChoiceList[SI], 5
        JE p5
p1:
        LEA DX,item1
        JMP displayquantity
p2:
        LEA DX,item2
        JMP displayquantity
p3:
        LEA DX,item3
        JMP displayquantity
p4:
        LEA DX,item4
        JMP displayquantity
p5:
        LEA DX,item5
        JMP displayquantity
menu2:  
        ;prepare to display string
        MOV AH,09H
        CMP itemChoiceList[SI], 1
        JE p6
        CMP itemChoiceList[SI], 2
        JE p7
        CMP itemChoiceList[SI], 3
        JE p8
        CMP itemChoiceList[SI], 4
        JE p9
        CMP itemChoiceList[SI], 5
        JE p10
p6:
        LEA DX,item6
        JMP displayquantity
p7:
        LEA DX,item7
        JMP displayquantity
p8:
        LEA DX,item8
        JMP displayquantity
p9:
        LEA DX,item9
        JMP displayquantity
p10:
        LEA DX,item10
        JMP displayquantity
menu3:  
        ;prepare to display string
        MOV AH,09H
        CMP itemChoiceList[SI], 1
        JE p11
        CMP itemChoiceList[SI], 2
        JE p12
        CMP itemChoiceList[SI], 3
        JE p13
        CMP itemChoiceList[SI], 4
        JE p14
        CMP itemChoiceList[SI], 5
        JE p15
p11:
        LEA DX,item11
        JMP displayquantity
p12:
        LEA DX,item12
        JMP displayquantity
p13:
        LEA DX,item13
        JMP displayquantity
p14:
        LEA DX,item14
        JMP displayquantity
p15:
        LEA DX,item15
        JMP displayquantity
displayQuantity:
        INT 21H ;interupt the display item statement
        MOV AH,0
        MOV AL,quantityList[SI]
        DIV TEN1
        MOV BX,AX
        MOV AH,02H
        MOV DL,BL
        ADD DL,30H
        INT 21H
        MOV DL,BH
        ADD DL,30H
        INT 21H
display_oa:
        ;Display some space
        MOV AH,09H
        LEA DX,SLASHT
        INT 21H
        ;Move the current index into a temp variable
        MOV tempIndex,SI
        MOV AX,SI
        MUL TWO
        MOV BX,AX
        ;Call the procedure function
        MOV AX,orderAmountList[BX]
        MOV varIn,AX
        LEA SI,orderAmount
        call CVTVARTOPARAM
        MOV AH,09H
        LEA DX,moneyHeader
        INT 21H
        LEA DX,orderAmount
        INT 21H
        MOV SI,tempIndex
        JMP backtoloop
get_choice:        
        ;prompt message
        MOV AH,09H
        LEA DX,GETCHOICE
        INT 21H

        ;get input (digit)       
        MOV AH,01H
        INT 21H
        SUB AL,30H

        MOV itemSelection, AL
        ;Trace the item check input
        MOV itemChoiceList[DI],AL
        SUB AL,1
        ;store the index to BX
        MOV BH,0
        MOV BL,AL
        CMP itemSelection,1
        JGE validate2
        
        MOV AH,09H
        LEA DX,EMSG
        INT 21H
        JMP get_choice
validate2:
        CMP itemSelection,5
        JLE get_quantity

        MOV AH,09H
        LEA DX,EMSG
        INT 21H
        JMP get_choice
chkpoint_exit3:
        JMP chkpoint_exit4
chkpoint_payment3:
        JMP chkpoint_payment4
quantity_error:
        MOV AH,09H
        LEA DX,EMSG
        INT 21H
get_quantity:

        ;display message
        MOV AH,09H
        LEA DX,quantityMSG
        INT 21H 

        ;Get Quantity (Parameter List, Digit)
        MOV AH,0AH
        LEA DX,quantityParam
        INT 21h
        
        CMP ACT_QUAN_LEN, 0
        JE quantity_error

        ;check quantity is 0 or not , if 0 send error message
        CMP quantityInput[0], "0"
        JE quantity_error
        ;Move OFFSET of array input to parameter
        ;Move Active Length to parameter
        LEA SI,quantityInput
        MOV AL,ACT_QUAN_LEN
        MOV arrSize,AL
        call CVTPARAMTOVAR
        ;Output is on AL, directly to multiplication
        JMP calculateorderamount

chkpoint_choiceMenu1: ;checkpoint when the jump is too far
        JMP orderMenu
chkpoint_payment4:
        JMP BEFOREPAYMENT
chkpoint_exit4: ;checkpoint when the jump distance is too far
        JMP EXIT
calculateOrderAmount:
        ;Trace quantity choice from the user
        MOV quantityList[DI],AL   
        ;Check which menu then multiply with which array
        CMP choice, 1
        JE mulDishPrice
        CMP choice,2
        JE mulDrinkPrice
        CMP choice,3
        JE mulSidePrice
mulDishPrice:
        ADD orderCount[BX],AL
        MUL dishPrice[BX]
        JMP displayOA
mulDrinkPrice:
        ADD orderCount[BX+5],AL
        MUL drinkPrice[BX]
        JMP displayOA
mulSidePrice:
        ADD orderCount[BX+10],AL
        MUL sidePrice[BX]
        JMP displayOA
chkpoint_choiceMenu2: ;just for that fucking 1H of distance to JMP :)
        JMP chkpoint_choicemenu1
chkpoint_dishMenu: ;checkpoint when the jump is too far
        JMP dish_menu
chkpoint_drinkMenu:
        JMP drink_menu
chkpoint_sideMenu:
        JMP side_menu
displayOA:
        ;add the result to OA
        ADD OA,AX
        MOV tempDW, AX
        MOV AX,DI
        MUL TWO
        MOV BX,AX
        MOV AX,tempDW
        MOV orderAmountList[BX],AX
        ;cvt to parameter list
        LEA SI,itemPrice
        MOV varIn,AX
        call CVTVARTOPARAM
        ;display order amount to let the user know the amount they have
        MOV AH,09H
        LEA DX,orderAmountMSG
        INT 21H

        MOV AH,09H
        LEA DX,itemPrice
        INT 21H
        JMP chk_order_status
chk_MenuOption: ;jumping back to specific jump point of the menu :)
        INC DI
		MOV listIndex,DI
        MOV BL,choice
        MOV menuChoiceList[DI],BL    
        CMP choice, 1
        JE chkpoint_dishMenu

        CMP choice, 2
        JE chkpoint_drinkMenu
        
        CMP choice, 3
        JE chkpoint_sideMenu
        MOV menuChoiceList[DI], 0
        CMP choice, 7
        JE chkpoint_choicemenu2
backToChoiceMenu:
        MOV choice, 7
        JMP chk_MenuOption
chk_order_status:
        ;display the prompt msg
        MOV AH,09H
        LEA DX,promptOrderState
        INT 21H

        ;get input (CHAR)
        MOV AH,01H
        INT 21h
        MOV orderState, AL

        ;check the Y and N
        CMP orderState, 'Y'
        JE chk_MenuOption
        CMP orderState, 'N'
        JE backToChoiceMenu

        ;display error message
        MOV AH,09H
        LEA DX,EMSG
        INT 21H
        ;loop
        JMP chk_order_status
        
BEFOREPAYMENT:

        MOV DI,ORDERINDEX
        
        MOV AX,DI
        MUL TWO
        MOV BX,AX
        MOV AX,OA
        MOV OALIST[BX],AX 
        CALL CLEANOAPARAM
        LEA SI,orderAmount
        MOV BX,OA
        MOV varIn,BX
        call CVTVARTOPARAM
        LEA SI,finalorderAmount
        MOV BX,OA
        MOV varIn,BX
        CALL CVTVARTOPARAM
        MOV SI,0
getActLen:
        CMP orderAmount[SI], '$'
        JE getActLenDone
        INC SI
        JMP getActLen

getActLenDone:
        DEC SI
        MOV BX,SI
        MOV ACT_LEN,BL
        JMP PAYMENT
;------------------------------PLACE ORDER MODULE: END------------------------------;


;------------------------------PAYMENT MODULE: START------------------------------;

; Check whether Order Amount == 0
PAYMENT:
		; Clear Screen
		MOV AX,02H
		INT 10H

		CMP orderAmount[0],'0'
		; if (Order Amount != 0) --> Calculate Taxes
		JNE CALTAXES

; No Order Found
NOORDER:
		; Display Alert Message 1
		MOV AH,09H
		LEA DX,NL
		INT 21H
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
		JMP ORDERMENU

; Calculate Taxes
CALTAXES:
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
		DIV TWO1
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
		MOV CH,0
		MOV CL,ACT_SST_LEN
                DEC CX
		MOV DI,0

; Sort SST Amount
SORTSST:
		MOV AL,SST[DI + 1]
		MOV SST[DI],AL
		INC DI
		LOOP SORTSST

		MOV SST[DI],'0'
		MOV SST[DI + 1],'$'

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
		JE DISPLAYORDERLIST	; --> JMP ORDERDETAILS
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

; Display Order Detail
DISPLAYORDERLIST:
		;Header
		MOV AH,09H
		LEA DX,OLHEADER
		INT 21H

                MOV payStatus,1
                MOV CX,listIndex
                MOV SI,0
                JMP DISPLAYITEMS

DISPLAYDONE: ;label to go back from cancel order module(display ordered items)
                ;Convert the total OA back
		MOV AH,09H
		LEA DX,NL
		INT 21H
		LEA DX,ENDLINE
		INT 21H
		LEA DX,SHOWOA
		INT 21H
		LEA DX,finalorderAmount
		INT 21H
		LEA DX,SHOWSST
		INT 21H
		LEA DX,SST
		INT 21H
		MOV AH,02H
		MOV DL,ZERO
		INT 21H
		MOV AH,09H
		LEA DX,SHOWSTX
		INT 21H
		LEA DX,STX
		INT 21H
		MOV AH,02H
		MOV DL,ZERO
		INT 21H
		MOV AH,09H
		LEA DX,SHOWTTPY
		INT 21H
		LEA DX,TTPY
		INT 21H

; Prompt for Customer Payment
PROMPTCUSTPY:
		; Display Message 1
		MOV AH,09H
		LEA DX,NL
		INT 21H
		LEA DX,MSG1
		INT 21H

		; Reset Decimal Point Counter to 0 before Read Customer Payment
		MOV DPCOUNT,0
		
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
		LEA DX,NL
		INT 21H
		LEA DX,ALERT3
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

		; Prompt Order Details again
		JMP DISPLAYORDERLIST

; Large Customer Payment
LARGECUSTPY:
		; Display Alert Message 4
		MOV AH,09H
		LEA DX,NL
		INT 21H
		LEA DX,ALERT4
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

		; Prompt Order Details again
		JMP DISPLAYORDERLIST

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

; Sort Customer Payment
SORTCUSTPY:
		; Move forward every element in the Array
		MOV AL,CUSTPY[BX - 1]
		MOV CUSTPY[BX],AL
		DEC BX
		LOOP SORTCUSTPY

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

; Too Much Decimal Point
ONLY2DP:
		; Display Alert Message 5
		MOV AH,09H
		LEA DX,NL
		INT 21H
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

		; Prompt Order Details again
		JMP DISPLAYORDERLIST

; Insufficcient Payment
ISPY:
		; Display Alert Message 2
		MOV AH,09H
		LEA DX,NL
		INT 21H
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

		; Prompt Order Details again
		JMP DISPLAYORDERLIST

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
		; Jump to Display Payment Success
		JMP PAYMENTSUCCESS

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
		MOV AL,ACT_TTPY_LEN
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
                CMP CHG[SI],'0'
		; if (Changes[SI] == '0') --> Jump to When Zero
		JE WHENZERO
                INC SI

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
		MOV DI,0

; Remove Extra Zero
REMOVEEXRTAZERO:
		CMP CHG[DI],'0'
		JNE PAYMENTSUCCESS
		CMP CHG[DI + 1],'.'
		JE PAYMENTSUCCESS
		MOV CH,0
		MOV CL,ACT_CHG_LEN
		MOV SI,0

; Sort Changes
SORTCHG:
		MOV AL,CHG[SI + 1]
		MOV CHG[SI],AL
		INC SI
		LOOP SORTCHG
		INC DI
		JMP REMOVEEXRTAZERO

; Display Payment Success
PAYMENTSUCCESS:
		; Clear Screen
		MOV AX,02H
		INT 10H
                
		; Display Alert Message 6
		MOV AH,09H
		LEA DX,NL
		INT 21H
		LEA DX,ALERT6
		INT 21H
		; Display New Line
		LEA DX,NL
		INT 21H
                
CONVERTPAYMENT:		 
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
        CMP TOTALPROSYILING,100
        ;if true skip to add PROFIT RINGGIT to TOTAL PROFIT RINGGIT
        JL NEXT
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

        MOV AX,DI
        MUL TWO
        MOV BX,AX
        MOV AX,PROFITRINGGIT
        SUB AX,OALIST[BX]
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
        
DISPLAYRECEIPT:
        INC RECEIPTNO

	MOV AH,09H
        LEA DX,RECEIPT1
        INT 21H

        ; Display Receipt No
        MOV BH,0H
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        MOV AH,02H    
        MOV DL,RECEIPTNO
        ADD DL,30H
        INT 21H

        MOV AH,09H
        LEA DX,RECEIPT2
        INT 21H

        ; Display Date DD/MM/YY
        ; Get day
        MOV AH,2AH    ; To get System Date
        INT 21H
        MOV AL,DL     ; Day is in DL
        AAM
        MOV BX,AX

        ; Display day
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H
 
        MOV DL,BL
        ADD DL,30H
        INT 21H

        MOV DL,'/'
        INT 21H

        ; Get month 
        MOV AH,2AH    ; To get System Date
        INT 21H
        MOV AL,DH     ; Month is in DH
        AAM
        MOV BX,AX

        ; Display month
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        MOV DL,BL
        ADD DL,30H
        INT 21H

        MOV DL,'/'
        INT 21H

        ; Get year
        MOV AH,2AH    ; To get System Date
        INT 21H
        ADD CX,0F830H ; To negate the effects of 16bit value,
        MOV AX,CX     ; since AAM is applicable only for AL (YYYY -> YY)
        AAM
        MOV BX,AX
        
        ; Display year
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        MOV DL,BL
        ADD DL,30H
        INT 21H

	MOV AH,09H
        LEA DX,RECEIPT3
        INT 21H

        ; Display Time HH:MM:SS
        ; Get Hours
        MOV AH,2CH    ; To get System Time
        INT 21H
        MOV AL,CH     ;  Hours in CH
        AAM
        MOV BX,AX

        ; Display Hours
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        MOV DL,BL
        ADD DL,30H
        INT 21H

        MOV DL,':'
        INT 21H

        ; Display Minutes
        MOV AH,2CH    ; To get System Time
        INT 21H
        MOV AL,CL     ;  Minutes in CL
        AAM
        MOV BX,AX

        ; Display Minutes
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        MOV DL,BL
        ADD DL,30H
        INT 21H

        MOV DL,':'
        INT 21H

        ; Display Seconds
        MOV AH,2CH    ; To get System Time
        INT 21H
        MOV AL,DH     ;  Seconds in DH
        AAM
        MOV BX,AX

        ; Display Seconds
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        MOV DL,BL
        ADD DL,30H
        INT 21H

        MOV AH,09H
        LEA DX,RECEIPT4
        INT 21H
        
        MOV CX,listIndex
        MOV SI,0
        MOV payStatus,2
        JMP DISPLAYITEMS

DISPLAYFINISH:
        
        MOV CX,20
        MOV SI,0
resetOrder:
        MOV menuChoiceList[SI],0
        MOV itemChoiceList[SI],0
        MOV quantityList[SI],0
        MOV AX,SI
        MUL TWO
        MOV BX,AX
        MOV orderAmountList[BX],0
        INC SI
        LOOP resetOrder
        MOV listIndex, 0
        MOV OA,0

        MOV AH,09H
	LEA DX,ENDLINE1
	INT 21H

        ; Dispaly Order Amount
        LEA DX,PRINTOA
        INT 21H

        MOV CH,0H
        MOV BH,ACT_LEN
        MOV BL,7
        SUB BL,BH
        MOV CL,BL
        MOV AL,0
WHITESPACE1:
        MOV AH,02H
        MOV DL," "
        INT 21H
        LOOP WHITESPACE1

        MOV AH,09H
	LEA DX,finalorderAmount
	INT 21H

        ; Display SST
        LEA DX,PRINTSST
        INT 21H

        MOV CH,0H
        MOV BL,7
        SUB BL,ACT_SST_LEN
        MOV CL,BL
        MOV AL,0
WHITESPACE2:
        MOV AH,02H
        MOV DL," "
        INT 21H
LOOP WHITESPACE2

        MOV AH,09H
	LEA DX,SST
	INT 21H

        ; Display Services Tax
        LEA DX,PRINTSTX
        INT 21H
        
        MOV CH,0H
        MOV BL,7
        SUB BL,ACT_STX_LEN
        MOV CL,BL
        MOV AL,0
WHITESPACE3:
        MOV AH,02H
        MOV DL," "
        INT 21H
LOOP WHITESPACE3

        MOV AH,09H
	LEA DX,STX
	INT 21H

        ; Display Total Payment
	LEA DX,PRINTTTPY
	INT 21H
        
        MOV CH,0H
        MOV BL,7
        SUB BL,ACT_TTPY_LEN
        MOV CL,BL
        MOV AL,0
WHITESPACE4:
        MOV AH,02H
        MOV DL," "
        INT 21H
LOOP WHITESPACE4

        MOV AH,09H
	LEA DX,TTPY
	INT 21H

        ; Display Customer Payment
	LEA DX,PRINTCTPY
	INT 21H

        MOV CH,0H
        MOV BL,7
        SUB BL,ACT_CUSTPY_LEN
        MOV CL,BL
        MOV AL,0
WHITESPACE5:
        MOV AH,02H
        MOV DL," "
        INT 21H
LOOP WHITESPACE5

        MOV AH,09H
	LEA DX,CUSTPY
	INT 21H

        ; Display Charges
	LEA DX,PRINTCHG
	INT 21H
        
        MOV CH,0H
        MOV BL,7
        SUB BL,ACT_SST_LEN
        MOV CL,BL
WHITESPACE6:
        MOV AH,02H
        MOV DL," "
        INT 21H
LOOP WHITESPACE6

        MOV AH,09H
	LEA DX,CHG
	INT 21H

        LEA DX,RECEIPTF
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
	JMP ORDERMENU
                
;------------------------------PAYMENT MODULE: END------------------------------;


;------------------------------REPORT MODULE: START------------------------------;
        ;--------------Display Report Types Menu--------------
; Select Report        
SELTREPORT:
	; Clear screen
	MOV AX, 02
	INT 10H

        ; Display Report types menu
        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        MOV AH,09H
        MOV BH,0H
        MOV BL,06
        MOV CX,38
        INT 10H
        LEA DX,RPTMENU1
        INT 21H

        MOV AH,09H
        LEA DX,RPTMENU2
        INT 21H

        ; Prompt Selection
        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV SELTRPT,AL

        ;---Compare---
        ; 4 - back to Main Menu
        CMP SELTRPT,4
        JE QUITRPT

        ; 3 - DAILY PROFIT REPORT 
        CMP SELTRPT,3
        JE RPT3

        ; 2 - Popular Dishes and Drinks Report
        CMP SELTRPT,2
        JE RPT2

        MOV count1,0
        MOV DSTQTT,0
        MOV DRTQTT,0
        MOV SDTQTT,0
        ; 1 - Daily Summary Report
        CMP SELTRPT,1
        JE RPT1

        JMP MSGINVALID
        
        ;--------------Selection = 4--------------
; Quit Report   
QUITRPT: 
        ; Clear screen
		MOV AX, 02
		INT 10H

        ;----Confirm exit----
        ; Display confirmation exit message
        MOV AH,09H
        LEA DX,CONFEXT
        INT 21H
        
        ; Prompt Cormation (Y/N)
        MOV AH,01H
        INT 21H
        MOV SELTEXT,AL

        ;----Compare---
        CMP SELTEXT,"Y"
        JE returnMainMenu

        CMP SELTEXT,"N"
        JNE MSGINVALID
        
        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Display continue message
        MOV AH,09H
        LEA DX,continue
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H

        JMP SELTREPORT

        ;--------------Selection = 1, Display "Daily Summary Report"--------------
; Report 1
RPT1:   ;recursive menu to display checking
        ; Clear screen
		MOV AX, 02
		INT 10H

        MOV AH,09H
        LEA DX,DATE
        INT 21H    

        ;---Display Today Date---
        ; Get day
        MOV AH,2AH    ; To get System Date
        INT 21H
        MOV AL,DL     ; Day is in DL
        AAM
        MOV BX,AX

        ; Display day
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        MOV AH,02H    
        MOV DL,BL
        ADD DL,30H
        INT 21H

        MOV AH,02H
        MOV DL,'/'
        INT 21H

        ; Get month 
        MOV AH,2AH    ; To get System Date
        INT 21H
        MOV AL,DH     ; Month is in DH
        AAM
        MOV BX,AX

        ; Display month
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        MOV AH,02H  
        MOV DL,BL
        ADD DL,30H
        INT 21H

        MOV AH,02H
        MOV DL,'/'
        INT 21H

        ; Get year
        MOV AH,2AH    ; To get System Date
        INT 21H
        ADD CX,0F830H ; To negate the effects of 16bit value,
        MOV AX,CX     ; since AAM is applicable only for AL (YYYY -> YY)
        AAM
        MOV BX,AX
        
        ; Display year
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        MOV AH,02H    
        MOV DL,BL
        ADD DL,30H
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ;---Display report 1---
        MOV AH,09H
        LEA DX,RPTONE1
        INT 21H

        INC COUNT1

        CMP COUNT1,2
        JE DR
        CMP COUNT1,3
        JE SD

;---Display Dishes Item Details---
        MOV AH,09H
        LEA DX,LAB1 ; DISHES
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        MOV SI,0
        MOV CX,5
DS_1:
        MOV AH,09H
        LEA DX,SPACE2
        INT 21H

        MOV AH,02H
        MOV DL," "
        INT 21H

        ; No
        MOV AH,0H
        MOV AL,INDEX[SI]
        INC AL
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

        ;SPACE BETWEEN NO AND ITEM NAME
        MOV AH,09H
        LEA DX,SPACE1
        INT 21H

        ; item name
        JMP DSITEM

        DS_1_1:
                ; space
                MOV AH,09H
                LEA DX,SPACE2
                INT 21H

                ; Display quantity of item
                MOV AH,0H
                MOV AL,orderCount[SI]
                ADD DSTQTT,AL
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

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H
                
        INC SI
        CMP SI,5    
        JE DS_1_DONE

LOOP DS_1

DS_1_DONE:
        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Display continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H

        JMP RPT1

        ; Compare index know what item
; Dishes Item
DSITEM:
    DSITEM1:
        CMP SI,0
        JNE DSITEM2

        MOV AH,09H
        LEA DX,item1
        INT 21H
        JMP DS_1_1

    DSITEM2:
        CMP SI,1
        JNE DSITEM3

        MOV AH,09H
        LEA DX,item2
        INT 21H
        JMP DS_1_1

    DSITEM3:
        CMP SI,2
        JNE DSITEM4

        MOV AH,09H
        LEA DX,item3
        INT 21H
        JMP DS_1_1

    DSITEM4:
        CMP SI,3
        JNE DSITEM5

        MOV AH,09H
        LEA DX,item4
        INT 21H
        JMP DS_1_1

    DSITEM5:
        MOV AH,09H
        LEA DX,item5
        INT 21H
        JMP DS_1_1

;---Display Drinks Item Details---
DR:
        MOV AH,09H
        LEA DX,LAB2 ; DRINKS
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        MOV CX,5
DR_1:
        MOV AH,09H
        LEA DX,SPACE2
        INT 21H

        MOV AH,02H
        MOV DL," "
        INT 21H

        ; No
        MOV AH,02H
        MOV AH,0H
        MOV AL,INDEX[SI]
        INC AL
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

        ;SPACE BETWEEN NO AND ITEM NAME
        MOV AH,09H
        LEA DX,SPACE1
        INT 21H

        ; item name
        JMP DRITEM

        DR_1_1:
                ; space
                MOV AH,09H
                LEA DX,SPACE2
                INT 21H

                ; quantity of item
                MOV AH,0H
                MOV AL,orderCount[SI]
                ADD DRTQTT,AL
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
        
        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        INC SI  
        CMP SI,10      
        JE DR_1_DONE

LOOP DR_1

DR_1_DONE:
        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Display continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H

JMP RPT1

        ;compare index know what item
; Print Drinks Item
DRITEM:
    DRITEM1:
        CMP SI,5
        JNE DRITEM2

        MOV AH,09H
        LEA DX,item6
        INT 21H
        JMP DR_1_1

    DRITEM2:
        CMP SI,6
        JNE DRITEM3

        MOV AH,09H
        LEA DX,item7
        INT 21H
       JMP DR_1_1

    DRITEM3:
        CMP SI,7
        JNE DRITEM4

        MOV AH,09H
        LEA DX,item8
        INT 21H
        JMP DR_1_1

    DRITEM4:
        CMP SI,8
        JNE DRITEM5

        MOV AH,09H
        LEA DX,item9
        INT 21H
        JMP DR_1_1

    DRITEM5:
        MOV AH,09H
        LEA DX,item10
        INT 21H
        JMP DR_1_1

;---Display Side Dishes Item Details---

SD:
        MOV AH,09H
        LEA DX,LAB3 ; SIDES
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        MOV CX,5
SD_1:
        MOV AH,09H
        LEA DX,SPACE2
        INT 21H

        MOV AH,02H
        MOV DL," "
        INT 21H

        ; No
        MOV AH,0H
        MOV AL,INDEX[SI]
        INC AL
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

        ;SPACE BETWEEN NO AND ITEM NAME
        MOV AH,09H
        LEA DX,SPACE1
        INT 21H

        ; item name
        JMP SDITEM

        SD_1_1:
                ; space
                MOV AH,09H
                LEA DX,SPACE2
                INT 21H

                ; Display quantity of item
                MOV AH,0H
                MOV AL,orderCount[SI]
                ADD SDTQTT,AL
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

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H
        
        INC SI
        CMP SI,15
        JE SD_1_DONE   
LOOP SD_1

SD_1_DONE:
        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Display continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H

JMP PTQTT

        ;compare index know what item
; Print Sides Dishes Item        
SDITEM:
    SDITEM1:
        CMP SI,10
        JNE SDITEM2

        MOV AH,09H
        LEA DX,item11
        INT 21H
        JMP SD_1_1

    SDITEM2:
        CMP SI,11
        JNE SDITEM3

        MOV AH,09H
        LEA DX,item12
        INT 21H
       JMP SD_1_1

    SDITEM3:
        CMP SI,12
        JNE SDITEM4

        MOV AH,09H
        LEA DX,item13
        INT 21H
        JMP SD_1_1

    SDITEM4:
        CMP SI,13
        JNE SDITEM5

        MOV AH,09H
        LEA DX,item14
        INT 21H
        JMP SD_1_1

    SDITEM5:
        MOV AH,09H
        LEA DX,item15
        INT 21H
        JMP SD_1_1

;---Display Total quantity for all item types---
; Print Total Quantity DB <- 
PTQTT:
        ; Clear screen
	MOV AX, 02
	INT 10H

        MOV AH,09H
        LEA DX,NL
        INT 21H

        ;total quantity
        MOV AH,09H
        LEA DX,TQTT
        INT 21H

        ;---Display Total Quantity of Dishes---
        MOV AH,09H
        LEA DX,LAB1 ; DISHES
        INT 21H

        MOV AH,09H
        LEA DX,SPACE3
        INT 21H

        ;Display quantity (2 Digit Display (DB))
        MOV AH,0H
        MOV AL,DSTQTT
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

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ;---Display Total Quantity of Dishes---
        MOV AH,09H
        LEA DX,LAB2 ; DRINK
        INT 21H

        MOV AH,09H
        LEA DX,SPACE3
        INT 21H

        ;Display quantity (2 Digit Display (DB))
        MOV AH,0H
        MOV AL,DRTQTT
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

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H
        
        ;---Display Total Quantity of Sides Dishes---
        MOV AH,09H
        LEA DX,LAB3 ; SIDES
        INT 21H

        MOV AH,09H
        LEA DX,SPACE3
        INT 21H

        ;Display quantity (2 Digit Display (DB))
        MOV AH,0H
        MOV AL,SDTQTT
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

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H
        INT 21H

        ; Display continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H

        JMP SELTREPORT

        ;--------------Selection = 2, Display "Popular Dishes and Drinks Report"--------------
; Report 2
RPT2:
        ; Clear Screen
	MOV AX,02
	INT 10H

        ; Display report 2
        MOV AH,09H
        LEA DX,RPTTWO
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ;===SORT===
        ;1. Create 2 pointers where i = 0, j = i + 1
        ;2. Nested forloop with condition of i < 5, j < 5
        ;3. if ordercount[j] > ordercount[i] then swap SORTINDEX[j] with SORTINDEX[i]
        ;i = SI, j = DI

        ;Bubble sort until 0 - 4 sorting
        MOV SI,0
        MOV CX,4

        MOV DI,SI
        INC DI ;DI = SI++

        MOV SI,0

        ; Dishes Sort 1
        DSSORT1:
                CMP SI,5
                JE DRSORT1
                MOV DI,SI
                INC DI

                ; Dishes Sort 1_1
                DSSORT1_1:
                        ;Check whether j == 5
                        CMP DI,5
                        JE DSSORT1_1DONE
                        ;Else Check  if ordercount[j] > ordercount[i]
                        MOV BL,orderCount[DI]
                        CMP BL,orderCount[SI]
                        ;if false skip
                        JLE skipDSSORT1_1
                        ;else swap
                        MOV AH,SORTINDEX[SI]
                        MOV AL,SORTINDEX[DI]
                        MOV SORTINDEX[SI],AL
                        MOV SORTINDEX[DI],AH

                        ; Skip Dishes Sort 1_1
                        skipDSSORT1_1:    
                                INC DI
                                JMP DSSORT1_1

                ; Dishes Sort 1_1 Done
                DSSORT1_1DONE:
                        INC SI
                        JMP DSSORT1

        ; Drinks Sort 1
        DRSORT1:
                CMP SI,10
                JE SDSORT1
                MOV DI,SI
                INC DI
                ; Drinks Sort 1_1
                DRSORT1_1:
                        ;Check whether j == 10
                        CMP DI,10
                        JE DRSORT1_1DONE
                        ;Else Check  if ordercount[j] > ordercount[i]
                        MOV BL,orderCount[DI]
                        CMP BL,orderCount[SI]
                        ;if false skip
                        JLE skipDRSORT1_1
                        ;else swap
                        MOV AH,SORTINDEX[SI]
                        MOV AL,SORTINDEX[DI]
                        MOV SORTINDEX[SI],AL
                        MOV SORTINDEX[DI],AH

                        ; Skip Drinks Sort 1_1
                        skipDRSORT1_1:    
                                INC DI
                                JMP DRSORT1_1

                ; Drinks Sort 1_1 Done
                DRSORT1_1DONE:
                        INC SI
                        JMP DRSORT1

        ; Sides Dishes Sort 1
        SDSORT1:
                CMP SI,15
                JE DLPDS
                MOV DI,SI
                INC DI

                ; Sides Dishes Sort 1_1
                SDSORT1_1:
                        ; Check whether j == 15
                        CMP DI,15
                        JE SDSORT1_1DONE
                        ; Else Check  if ordercount[j] > ordercount[i]
                        MOV BL,orderCount[DI]
                        CMP BL,orderCount[SI]
                        ; if false skip
                        JLE skipSDSORT1_1
                        ; else swap
                        MOV AH,SORTINDEX[SI]
                        MOV AL,SORTINDEX[DI]
                        MOV SORTINDEX[SI],AL
                        MOV SORTINDEX[DI],AH

                        ; Skip Sides Dishes Sort 1_1
                        skipSDSORT1_1:    
                                INC DI
                                JMP SDSORT1_1

                ; Sides Dishes Sort 1_1 Done                
                SDSORT1_1DONE:
                        INC SI
                        JMP SDSORT1

;---Display TOP3 Dishes---

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

; Display Dishes     
DLPDS:        
        MOV AH,09H
        LEA DX,LAB1
        INT 21H

; Display Dishes Top 1          
DSTOP1:
        MOV AH,09H
        LEA DX,TOP1
        INT 21H

        MOV BL,SORTINDEX[0]
        JMP PDSITEM ;check which item

; Display Dishes Top 2 
DSTOP2:
        MOV AH,09H
        LEA DX,TOP2
        INT 21H

        MOV BL,SORTINDEX[1]
        JMP PDSITEM

; Display Dishes Top 3
DSTOP3:
        MOV AH,09H
        LEA DX,TOP3
        INT 21H

        MOV BL,SORTINDEX[2]
        JMP PDSITEM

        ; Compare SORTINDEX know what item
; Print Dishes Item        
PDSITEM:
    PDSITEM1:
        CMP BL,0
        JNE PDSITEM2

        MOV AH,09H
        LEA DX,item1
        INT 21H
        JMP NEXTPDS

    PDSITEM2:
        CMP BL,1
        JNE PDSITEM3

        MOV AH,09H
        LEA DX,item2
        INT 21H
       JMP NEXTPDS

    PDSITEM3:
        CMP BL,2
        JNE PDSITEM4

        MOV AH,09H
        LEA DX,item3
        INT 21H
        JMP NEXTPDS

    PDSITEM4:
        CMP BL,3
        JNE PDSITEM5

        MOV AH,09H
        LEA DX,item4
        INT 21H
        JMP NEXTPDS

    PDSITEM5:
        MOV AH,09H
        LEA DX,item5
        INT 21H

    ; Next Dishes Item       
    NEXTPDS:
        INC COUNT2

        CMP COUNT2,1
        JE DSTOP2
        CMP COUNT2,2
        JE DSTOP3

;---Display Top3 Drinks---

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        MOV COUNT2,0

; Display Drinks 
DLPDR:
        MOV AH,09H
        LEA DX,LAB2
        INT 21H
; Display Drinks Top 1        
DRTOP1:
        MOV AH,09H
        LEA DX,TOP1
        INT 21H

        MOV BL,SORTINDEX[5]
        JMP PDRITEM
; Display Drinks Top 2
DRTOP2:
        MOV AH,09H
        LEA DX,TOP2
        INT 21H

        MOV BL,SORTINDEX[6]
        JMP PDRITEM
; Display Drinks Top 3
DRTOP3:
        MOV AH,09H
        LEA DX,TOP3
        INT 21H

        MOV BL,SORTINDEX[7]
        JMP PDRITEM

        ;compare SORTINDEX know what item
; Print Drinks Item
PDRITEM:
    PDRITEM1:
        CMP BL,5
        JNE PDRITEM2

        MOV AH,09H
        LEA DX,item6
        INT 21H
        JMP NEXTPDR

    PDRITEM2:
        CMP BL,6
        JNE PDRITEM3

        MOV AH,09H
        LEA DX,item7
        INT 21H
       JMP NEXTPDR

    PDRITEM3:
        CMP BL,7
        JNE PDRITEM4

        MOV AH,09H
        LEA DX,item8
        INT 21H
        JMP NEXTPDR

    PDRITEM4:
        CMP BL,8
        JNE PDRITEM5

        MOV AH,09H
        LEA DX,item9
        INT 21H
        JMP NEXTPDR

    PDRITEM5:
        MOV AH,09H
        LEA DX,item10
        INT 21H
        
    ; Next Drinks Item    
    NEXTPDR:
        INC COUNT2

        CMP COUNT2,1
        JE DRTOP2
        CMP COUNT2,2
        JE DRTOP3

;---Display Top3 Sides Dishes----

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; display TOP3 Side
        MOV COUNT2,0

; Display Sides Dishes       
DLPSD:
        MOV AH,09H
        LEA DX,LAB3
        INT 21H
; Display Sides Dishes Top 1
SDTOP1:
        MOV AH,09H
        LEA DX,TOP1
        INT 21H

        MOV BL,SORTINDEX[10]
        JMP PSDITEM
; Display Sides Dishes Top 2
SDTOP2:
        MOV AH,09H
        LEA DX,TOP2
        INT 21H

        MOV BL,SORTINDEX[11]
        JMP PSDITEM
; Display Sides Dishes Top 3
SDTOP3:
        MOV AH,09H
        LEA DX,TOP3
        INT 21H

        MOV BL,SORTINDEX[12]
        JMP PSDITEM

        ;compare SORTINDEX know what item
; Print Sides Dishes Item        
PSDITEM:
    PSDITEM1:
        CMP BL,10
        JNE PSDITEM2

        MOV AH,09H
        LEA DX,item11
        INT 21H
        JMP NEXTPSD

    PSDITEM2:
        CMP BL,11
        JNE PSDITEM3

        MOV AH,09H
        LEA DX,item12
        INT 21H
       JMP NEXTPSD

    PSDITEM3:
        CMP BL,12
        JNE PSDITEM4

        MOV AH,09H
        LEA DX,item13
        INT 21H
        JMP NEXTPSD

    PSDITEM4:
        CMP BL,13
        JNE PSDITEM5

        MOV AH,09H
        LEA DX,item14
        INT 21H
        JMP NEXTPSD

    PSDITEM5:
        MOV AH,09H
        LEA DX,item15
        INT 21H

    ; Next Sides Dishes Item    
    NEXTPSD:
        INC COUNT2

        CMP COUNT2,1
        JE SDTOP2
        CMP COUNT2,2
        JE SDTOP3

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Display continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H
        
        ; Back to Report Types Menu
        JMP SELTREPORT

        ;--------------Selection = 3, Display "Daily Profit Report"--------------
; Report 3
noTransaction:
        MOV AH,09H
        LEA DX,noTransactionMSG
        INT 21H
        LEA DX,CONTINUE
        INT 21H
        MOV AH,01H
        INT 21H
        JMP SELTREPORT
RPT3:   
        MOV AX,2
        INT 10H

        CMP orderIndex,0
        JE noTransaction

	CALL PROFITREPORT
	;print profit list
	MOV CX,orderIndex
	MOV SI,0
DISPLAYITEM:
    CALL DISPLAYCONTENT
    INC SI
LOOP DISPLAYITEM

        MOV AH,09H
        LEA DX,ENDLINE2
        INT 21H
;DISPLAY THE TOTAL PROFIT 
	MOV AH,09H
	LEA DX,NL
	INT 21H

	MOV AH,09H
	LEA DX,TOTALPROFITMSG
	INT 21H

	 MOV DX,0
	 MOV AX,TOTALPRORINGGIT
	 MOV BX,0			 ;123
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

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Display continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H
        
        ; Back to Report Types Menu
        JMP SELTREPORT

     
        ;--------------Invalid Input--------------	
MSGINVALID:
        ; Display invalid msssage
        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H
        
        MOV AH,09H
        MOV BH,0H
        MOV BL,04
        MOV CX,43
        INT 10H
        LEA DX,SELTIV
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H
        INT 21H

        ; Display continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H

        ; Back to Report Types Menu
        JMP SELTREPORT

;------------------------------REPORT MODULE: END------------------------------;


;------------------------------ACCOUNT SETTING MODULE: START------------------------------;


;------------------------------ACCOUNT SETTING MODULE: END------------------------------;

EXIT:
		MOV AX,4C00H
		INT 21H
MAIN ENDP

CVTPARAMTOVAR PROC
        ;Check Size
        CMP arrSize, 2
        JE TWODIGITCVT
        ;Case 1
        SUB [SI],30H
        MOV AL,[SI]
        RET
TWODIGITCVT:
        ;Case 2
        SUB [SI],30H
        MOV AL,[SI]
        MUL TEN1
        INC SI
        SUB [SI],30H
        ADD AL,[SI]
        RET
CVTPARAMTOVAR ENDP
;Procedure the convert 3 digit values to parameter list
CVTVARTOPARAM PROC
       ;doing 16-bit division, 126 / 10 -> 6 store to DX(DL), 12 store to AX, AX DIV TEN1 , 1 to AL, 2 to AH
	MOV DX,0
        MOV AX,varIn
        MOV BX,0
	DIV TEN2
	MOV R,DL
	DIV TEN1
	MOV Q,AH
	MOV P,AL
	;check if it is 3 digit, if yes display most left digit
	CMP varIn,100
	JL DIGIT2
	;Move P to a register
	MOV DL,P
        ADD DL,30H
	MOV [SI],DL
        INC SI
        INC BX
DIGIT2:
        ;check if it is 2 digit, if yes display last 2 digit
        CMP varIn,10
        JL DIGIT1
	MOV DL,Q
        ADD DL,30H
	MOV [SI],DL
        INC SI
        INC BX
DIGIT1:	       
	MOV DL,R
        ADD DL,30H
	MOV [SI],DL
        INC SI
        INC BX
        MOV [SI],'.'
        MOV DPI_OA,BX
        INC SI
        MOV [SI],'0'
        INC SI
        MOV [SI],'0'
        RET
CVTVARTOPARAM ENDP
CLEANOAPARAM PROC
        MOV CX,10
        MOV SI,0
        cleanLoop:
                MOV orderAmount[SI],'$'
                INC SI
                LOOP cleanLoop
        
        RET
CLEANOAPARAM ENDP

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
        INT 21H

;--------------------------------------------------------------------------
    ;ORDERLIST
    ;PRINT ORDER AMOUNT FROM KS PLACE ORDER
	MOV AX,SI
	MUL TWO
	MOV BX,AX
	MOV DX,0
	MOV AX,OALIST[BX]
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

	MOV AH,02H
        MOV DL,'0'
        INT 21H
        INT 21H
;--------------------------------------------------------------------------
;SPACE5
  	MOV AH,09H
	LEA DX,SPACE5
	INT 21H

;--------------------------------------------------------------------------
    ;PRINT PROFIT
    
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

	;PROFITSYILING 01 - 99
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
        MOV AX,0

        ;Display Output
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

;to clear screen paste these statement
;
;	MOV AX, 02
;	INT 10H

;to make your input invisible use this statement
;	MOV AH, 07H
;	INT 21H
; the input will still store in AL

;comments from the last push
; just remember try to separate the segment with something like this
;--------------get user login---------------------
;apa pun boleh bla bla bla
;
;------------------------------------------------- block down with this comment
;so other won't confused when coding in this collabaration git repository.
;noted and gambateh on the assignment simida
;sincerly from Chiew Hong Kuang :)

;^above comments totally not from me
;sincerly from the real Chiew Hong Kuang :)