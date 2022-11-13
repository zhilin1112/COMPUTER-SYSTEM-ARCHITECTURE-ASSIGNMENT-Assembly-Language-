.MODEL LARGE
.STACK 100
.386
.DATA
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
		
		;MAINMENU DESIGN
		MAINMENU DB 13,10,13,10,"+*************************************************************+"
				 DB 13,10,"|                      MAIN MENU                              |"
				 DB 13,10,"+*************************************************************+"
				 DB 13,10,"|                 1. LOGIN                                    |"
				 DB 13,10,"|                 2. EXIT                                     |"
				 DB 13,10,"+*************************************************************+$"
				 
		;THE CHOICE OF THE MAIN MENU
		CHOICEMSG DB 13,10,13,10,"CHOICES : $"
		
		;INPUT FROM THE USER OF THE CHOICES  
	    MAINCHOICES DB ? 
		
		;MESSAGE WHEN USER KEY IN INVALID NUMBER FROM THE MENU
		ERRORMSG DB "  YOU HAD KEY IN INVALID NUMBER, PLEASE KEY IN AGAIN! $"
		
		;PRINT NEW LINE
		NL DB 0DH,0AH,"$"
		
		;LOGIN TITILE 
		LOGINTITILE DB "            LOGIN PAGE "
		       DB 13,10,"            ~~~~~~~~~~~ $"
			   
		;GET USERNAME AND PASSWORD TITLE
		USERNAMEMSG DB 13,10,"   USERNAME: $"
		USERPSWMSG DB 13,10,"   PASSWORD: $"
		
		;HARDCODE USERNAME AND PASSWORD
		USERNAME DB "SkyGavin$" 
		USERPSW DB "gavin$" ; password hardcode  DEFAULT   ;MIX CHAR AND NUM I DONT KNOW DO 
		
		;INPUT USERNAME AND PASSWORD (USE ARRAY TO STORE THE INPUT)
		INUSERPSW DB 5 DUP(0) 
		NEWINPSW DB 5 DUP(0)
		
		STRUSERNAME LABEL BYTE
		MAXN DB 20
		ACTN DB ?
		INPUTUSERNAME DB 20 DUP ("$")
		
		;ACCOUNT SETTING, NEW PASSWORD VARIABLE
		NEWPSW DB 5 DUP(0)
		
		;VALID MESSAGE WHEN LOGIN SUCCESSFUL
		VALIDMSG DB "  HELLO GAVIN, YOU HAD LOGIN SUCCESSFUL.WELCOME TO SKY CAFE ! $"
		
		;INVALID MESSAGE WHEN LOGIN SUCCESSFUL
		INVALIDMSG DB "  YOU HAD KEY IN INVALID PASSWORD OR USERNAME! PLEASE KEY IN AGAIN. $"
		
		;WHEN OVER 3 TIMES KEY IN WRONG PASS OR USERNAME MESSAGE
		BLOCKLOGIN DB "  YOU HAD KEY IN 3 TIMES INVALID PASSWORD OR USERNAME! $"
		
		;COUNT FOR TIMES LOGIN AND MAXIMUM IS 3 
		COUNT DB 0
		LIMITLOGIN DB 3
		
		;MENU OF THE WHOLE CAFE SYSTEM
		MENU DB 13,10,"+*************************************************************+"
		     DB 13,10,"|                          MENU                               |"
	         DB 13,10,"+*************************************************************+"
		     DB 13,10,"|                1. PLACE ORDER                               |"
		     DB 13,10,"|                2. GENERATE REPORT                           |"
	         DB 13,10,"|                3. ACCOUNT SETTING                           |"
	         DB 13,10,"|                4. LOGOUT                                    |"
			 DB 13,10,"|                5. BACK TO MAIN MENU                         |"
	         DB 13,10,"+*************************************************************+"
	         DB 13,10,13,10,"         WHAT DO YOU WANT TO CHOOSE(1 - 5): $"    ;---------------------------------------------changed
			 
		;CHOOSEN OF THE MENU
		CHOOSE DB ?
			 
	    ;VARIABLE THAT LATER DO COMPARE AND JUMP TO PARTICULAR PLACE
	    PLACEORDER DB 1
	    REPORT DB 2
	    ACCOUNT DB 3
	    LOGOUT DB 4
		BACKMAINMENU DB 5
		
		;USER CHOOSE LOGOUT AND DOUBLE CONFIRM MESSAGE
	    CONFIRMMSG DB 13,10,13,10,"		DO YOU CONFIRM WANT TO LOGOUT (Y = YES N = NO) ? $"
		
		;CHOICES OF DOUBLE CONFIRM (Y/N)
	    CHOICES DB ? 
		
		;COMPARE 'Y'
	    CHARFORY DB 'Y' 
		CHARFORN DB 'N'
		
		;SUCCESS LOGOUT MESSAGE
	    LOGOUTMESG DB "            YOU HAD LOGOUT SUCCESSFULLY! $"
		THANKYOUMSG DB "          THANK YOU FOR USING THE SKYCAFE $"
		
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
				  
		;ACCOUNT SETTING TITILE 
		ACCSETITILE DB "            ACCOUNT SETTING PAGE "
					DB 13,10,"            ~~~~~~~~~~~~~~~~~~~~~ $"
				  
		;MESSAGE OF USER CHOOSE ACCOUNT SETTING TO RESET PASSWORD 
	    CHGPSWTITILE DB 13,10,13,10,"       DO YOU WANT TO RESET YOUR PASSWORD (Y = YES N = NO) ? $"
		
		;MSG TO KEY IN CURRENT PASSWORD (FOR SECURITY PURPOSE)
	    CURPSW DB 13,10,13,10,"PLEASE KEY IN YOUR CURRENT PASSWORD: $" 
		
		;MSG TO KEY IN NEW PASSWORD
	    INPUTCHGPSW DB 13,10,13,10,"PLEASE KEY IN WHAT IS YOUR NEW PASSWORD: $"
		
		;MSG TO DOUBLE CONFIRM NEW PASSWORD
		CONFIRNEWPSWMSG DB 13,10,"PLEASE KEY IN NEW PASSWORD AGAIN: $"
		
		;SUCCESS CHANGE PASSWORD MESSAGE
	    SUCESSCHGPSWMSG DB "  YOU HAD CHANGE THE PASSWORD SUCCESSFULLY !$"
		
		;KEY IN TWO TIMES PASSWORD NOT EAUAL
	    PSWNOTEQUAL DB "  YOU HAD KEY IN DIFFERENT NEW PASSWORD! PLEASE KEY IN AGAIN! $"
	   
	    ;USER KEY IN INVALID CURRENT PASSWORD
	    ACCINVALIDMSG DB "  YOU HAD KEY IN WRONG PASSWORD !! PLEASE KEY IN AGAIN. $"
		
		CONTINUE DB "Press any key to continue...$"

		;----------------------------------------------
		;ACCOUNT SETTNG ADD 
		DUPCONFIRMSG DB 13,10,"DO YOU CONFIRM WANT TO CHANGE PASSWORD (Y/N)? $"
		
                    
	.CODE
MAIN PROC 
		MOV AX,@DATA
		MOV DS,AX

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
		
		;RET
	;DISLOGO ENDP

		;CALL DISLOGO

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
		JE DISPLAYTHANKYOUMSG
		
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
			MOV CX,62
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
		;JE  			;PARTICULAR PLACEORDER MENU
		
		CMP AL,REPORT
		;JE 			;PARTICULAR REPORT MENU
		
		CMP AL,ACCOUNT
		JE GOTOACCOUNT
		
		JMP PRINTINMSG
		
		GOTOACCOUNT:
			CALL ACCSETTING
		
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
		;-------------------------------------------------------------------------------------end add 
			;CLEAR SCREEN  
			MOV AX,02
			INT 10H
		
			MOV AH,09H
			LEA DX,NL
			INT 21H
		
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

		
		
		EXIT:
			MOV AX,4C00H
			INT 21H
		
MAIN ENDP

ACCSETTING PROC
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


			

			RET
 ACCSETTING ENDP
END MAIN