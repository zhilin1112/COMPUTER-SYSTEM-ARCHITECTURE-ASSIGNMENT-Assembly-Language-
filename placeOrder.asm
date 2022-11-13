;Note from Kang Sheng
;This is a basic structure of the program, OA is limited with 3 digits, 3 digit param list as output
;Having 3 menus for the u guys to do the integration test
;got debugging message on the end when doing the convertion to the param list <- debug output for CHK
;
; Note for Yuan Qi
; OrderCount 的 Array 里面我弄好了15个Size, index 0 - 4 是 第一个Menu(Dish Menu). 5 - 9 是第二个Menu (Drink Menu), 10 - 14 是第三个Menu (Side Menu)
; 想要看Value, 当你test 玩选几个item 去选 payment, Debug 的 message 我留在那里， 满意的话记得在whatsapp跟我说
;1. Cancel Order (Pending)
;3. Refactor the code, improve the code smells (Final Task)
.MODEL SMALL
.STACK 100
.386 ;for adjusting the program to perform long jumps without any checkpoint
.DATA   
        ;Global Variables
        P DB ?
        Q DB ?
        R DB ?
        S DB ?
        TEN DB 10
        TEN2 DW 10
        NL DB 13,10,"$S"
        SLASHT DB "            $"
        CONTINUE DB "Press any key to continue...$"
        
	;Strings for menu
        EMSG DB 13,10,"INVALID INPUT $"
        GETCHOICE DB 13,10,"ENTER YOUR CHOICE :$"
        CONFIRMDELETE DB 13,10,"ARE YOU SURE TO DELETE ? (Y\N) : $"
        itemDeleteSuccess DB 13,10,"ITEM DELETED SUCCESSFULLY $"
        MENU DB 0DH,0AH,13,10,"---MENU---"
        	DB  13,10,"1. DISPLAY DISH MENU"
        	DB  13,10,"2. DISPLAY DRINKS MENU"
        	DB  0DH,0AH,"3. DISPLAY SIDES MENU"
        	DB  13,10,"4. CANCEL ORDER "
        	DB  13,10,"5. PAYMENT "
        	DB  13,10,"6. RETURN TO MAIN MENU $"
        dishMenu DB 13,10,13,10,"---DISH MENU--- "
                 DB 13,10, "1. SPAGHETTI (RM 4)"
                 DB 13,10, "2. NASI LEMAK(RM 5)"
                 DB 13,10, "3. MARRYLAND CHICKEN CHOP(RM 7)"
                 DB 13,10, "4. BLACK PEPPER STEAK (RM 7)"
                 DB 13,10, "5. SANDWICH (RM 3)$"
        drinkMenu DB 13,10,13,10,"---DRINK MENU---"
                 DB 13,10, "1. ESPRESSO (RM 5)"
                 DB 13,10, "2. MACCHIATO (RM 9)"
                 DB 13,10, "3. AMERICANO (RM 5)"
                 DB 13,10, "4. WHITE COFFEE (RM 4)"
                 DB 13,10, "5. SOFT DRINKS (RM 3)$"
        sideMenu DB 13,10,13,10,"---SIDES MENU---"
                 DB 13,10, "1. FRENCH FRIES (RM 4)"
                 DB 13,10, "2. FISH CAKE (RM 7)"
                 DB 13,10, "3. GRILLED SHRIMP (RM 8)"
                 DB 13,10, "4. APPLE PIE (RM 5)"
                 DB 13,10, "5. CHEESE CAKE (RM 6)$"
        cancelOrder DB 13,10, "---CANCEL ORDER--- "
                    DB 13,10, "NO    ITEM                 QUANTITY        ORDERAMOUNT$"
        ;Input Message
        quantityMSG DB 13,10,"ENTER THE QUANTITY : $"
        orderAmountMSG DB 13,10,"ORDER AMOUNT : RM$"
        promptOrderState DB 13,10,"ADD ANOTHER ITEM FROM THE MENU? (Y/N) $"
        totalOrderAmountMSG DB "TOTAL ORDER AMOUNT : RM$"
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
        ;debug msg
        stubMsg DB 13,10,"UNDER MAINTENANCE $"
        oaMSG  DB 13,10,"THE OA IN PARAMETER LIST = $"
        actMSG DB 13,10,"THE ACTIVE LENGTH IS = $"
        maxMsg DB 13,10,"THE MAX LENGTH IS  = $"
        orderCountMsg DB 13,10,"THE CONTENT OF ORDER COUNT = $"
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
        tspace DB "     $"
        moneyHeader DB "RM$"
        longline DB "--------------------------------------------------------$"
        noItemMsg DB 13,10,"YOU HAVE ORDERED 0 ITEMS UNABLE TO CANCEL!$"
        deleteCancel DB 13,10,"ITEM DELETION CANCELLED!$"
        beforeOA DB 13,10,"BEFORE ORDER AMOUNT : $"
        afterOA DB 13,10,"NEW ORDER AMOUNT : $"
        DPI_OA DW ?	; Decimal Point Index For Order Amount
        DPI_DEBUGMSG DB 13,10,"DECIMAL POINT INDEX : $"
.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        ;start tracing the inputs from user
        MOV DI,0
        JMP orderMenu
orderMenu:
        ;clear screen
        MOV AX,02
        INT 10H
	    ;display order menu by categories
	    MOV AH,09H
	    LEA DX, MENU
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

chk_order_selection:
        ;Assign menu choice that the user inputed
        MOV BL,choice
        MOV menuChoiceList[DI],BL
        ;clear screen
        MOV AX,02
        INT 10H
	;if 6 Go Back To Main Menu
	CMP choice, 6
	JE chkpoint_exit1            
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

        ;display header
        MOV AH,09H
        LEA DX,cancelOrder
        INT 21H
        LEA DX,NL
        INT 21H
        LEA DX,longLine
        int 21H
        ;Start displaying the items , DI is the size of the array
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
        ;Order Number
        MOV AH,02H
        MOV DX,SI
        ADD DL,30H
        INC DL
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
        CMP quantityList[SI], 9
        JA display2Digit
        MOV AH,02H
        MOV DL,quantityList[SI]
        ADD DL, 30H
        INT 21H
        JMP display_oa
display2Digit:
        MOV AH,0
        MOV AL,quantityList[SI]
        DIV TEN
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
        CALL CLEANOAPARAM
        LEA SI,orderAmount
        MOV BX,OA
        MOV varIn,BX
        call CVTVARTOPARAM
        MOV SI,0
getActLen:
        CMP orderAmount[SI], '$'
        JE DEBUGMSG
        INC SI
        JMP getActLen
DEBUGMSG:
        MOV BX,SI
        MOV ACT_LEN,BL
        ;debug msg for orderamount
        MOV AH,09H
        LEA DX,oaMSG
        INT 21H
        ;order amount
        MOV AH,09H
        LEA DX, orderAmount
        INT 21H
        ;debug msg for active length
        MOV AH,09H
        LEA DX, actMSG
        INT 21H
        ;active length
        MOV AH,02H
        MOV DL, ACT_LEN
        ADD DL,30H
        INT 21H
        ;DIP_OA 
        MOV AH,09H
        LEA DX, DPI_DEBUGMSG
        INT 21H
        MOV AH,02H
        MOV DX,DPI_OA
        ADD DL,30H
        INT 21H
        ;debug msg for max length (2 digit)
        MOV AH,09H
        LEA DX, maxMsg
        INT 21h
        ;max length
        MOV AH,0
        MOV AL,MAX_LEN
        DIV TEN
        MOV BX,AX
        MOV AH,02H
        MOV DL,BL
        ADD DL,30H
        INT 21h
        MOV DL,BH
        ADD DL,30H
        INT 21H
        ;Debug Message for the array in order count
        MOV AH,09H
        LEA DX,orderCountMsg
        INT 21H
        MOV SI,0
        MOV AH,02H
        MOV DL," "
        INT 21H
        MOV CX,15
DISPORDERCOUNT:
        MOV DL,orderCount[SI]
        ADD DL,30H
        INT 21H
        MOV DL," "
        INT 21H
        INC SI
        LOOP DISPORDERCOUNT        
        ;expected the jmp to payment module here <--- in default leaving it to leave the program as well

EXIT:
	MOV AX,4C00H
	INT 21H
MAIN ENDP
;Procedure that do 2 digit input conversion from parameter list
;Parameter -> SI, arrSize(DB)
;Output -> AL
CVTPARAMTOVAR PROC
        ;Check Size
        CMP arrSize, 2
        JE TWODIGITCVT
        ;Case 1
        SUB [SI], 30H
        MOV AL,[SI]
        RET
TWODIGITCVT:
        ;Case 2
        SUB [SI],30H
        MOV AL,[SI]
        MUL TEN
        INC SI
        SUB [SI],30H
        ADD AL,[SI]
        RET
CVTPARAMTOVAR ENDP
;Procedure the convert 3 digit values to parameter list
CVTVARTOPARAM PROC
       ;doing 16-bit division, 126 / 10 -> 6 store to DX(DL), 12 store to AX, AX DIV TEN , 1 to AL, 2 to AH
	MOV DX,0
        MOV AX,varIn
        MOV BX,0
	DIV TEN2
	MOV R,DL ;6
	DIV TEN ;12
	MOV Q,AH ;2
	MOV P,AL ;1
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
END MAIN


