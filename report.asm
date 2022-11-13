.MODEL SMALL
.STACK 100
.386
.DATA
        ;---------------GLOBAL VARIABLES-------------
        NL       DB 0DH,0AH,"$"	                                ; New Line
        CONTINUE DB "PRESS ANY KEY TO CONTINUE...$"	        ; Continue Message
        RETURN   DB "PRESS ANY KEY TO RETURN TO LAST STAGE...$"	; Return Message
        
        TEN1    DB 10

        ;---temp for test run
        MAINMENU DB 13,10,"HERE IS MAIN MENU!$"

        ; Report Types Menu
        RPTMENU DB 13,10,"-----REPORT TYPES-----"          
                DB 13,10,"1. DISPLAY DAILY SUMMARY REPORT"
                DB 13,10,"2. DISPLAY POPULAR DISHES AND DRINKS REPORT"
                DB 13,10,"3. RETURN TO MAIN MENU"
                DB 13,10
                DB 13,10,"ENTER SELECTION (1-3): $"

        ; Selection on report menu
        SELTRPT DB ? 

        ; SELTRPT == 1
        DATE     DB 13,10,"DATE: $"
        RPTONE1  DB 13,10,"--------------DAILY SUMMARY REPORT--------------"
                 DB 13,10,"================================================"
                 DB 13,10,"NO.  ITEMS NAME                    QUANTITY"
                 DB 13,10,"------------------------------------------------$"
      
        ; Total Quantity
        DSTQTT   DB 0
        DRTQTT   DB 0
        SDTQTT   DB 0

        SPACE1 DB ".  $"
        SPACE2 DB "           $"

        ; Total Quantity
        TQTT DB 13,10,"-------TOTAL QUANTITY OF 3 TYPES ITEMS-------"    
             DB 13,10,"============================================="  
             DB 13,10," TYPE                         QUANTITY       "  
             DB 13,10,"---------------------------------------------$"

        SPACE3 DB "                          $"

        INDEX DB 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14 ;0-4 DS, 5-9 DR, 10-14 SD

        ;SELTRPT == 2
        RPTTWO  DB 13,10,"----POPULAR DISHES AND DRINKS REPORT----$"
        
        LAB1    DB 13,10,"DISHES$"
        LAB2    DB 13,10,"DRINKS$"
        LAB3    DB 13,10,"SIDES $"

        TOP1    DB 13,10,"TOP 1 > $"
        TOP2    DB 13,10,"TOP 2 > $"
        TOP3    DB 13,10,"TOP 3 > $"

        ; Control display Top '?'
        COUNT1 DB 0
        COUNT2 DB 0

        ;sample quantity, testing use
        orderCount  DB 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ;1-5 dish, 6-10 drink, 11-15 side

        ;Item Names take from placeOrder, testing use
        ;DS: Dishes
        item1 DB "SPAGHETTI              $"
        item2 DB "NASI LEMAK             $"
        item3 DB "MARRYLAND CHICKEN CHOP $"
        item4 DB "BLACK PEPPER STEAK     $"
        item5 DB "SANDWICH               $"
        ;DR: Drinks
        item6 DB "ESPRESSO               $"
        item7 DB "MACCHIATO              $"
        item8 DB "AMERICANO              $"
        item9 DB "WHITE COFFEE           $"
        item10 DB "SOFT DRINKS            $"
        ;SD: Sides
        item11 DB "FRENCH FRIES           $"
        item12 DB "FISH CAKE              $"
        item13 DB "GRILLED SHRIMP         $"
        item14 DB "APPLE PIE              $"
        item15 DB "CHEESE CAKE            $"

        ;use to sort
        SORTINDEX DB 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14 ;0-4 DS, 5-9 DR, 10-14 SD

        ;SELTRPT == 3
        CONFEXT DB 13,10,"SURE TO QUIT REPORT MODULE? ('Y' TO EXIT): $" ; Confirmation Selection

        ;Selection on exit action
        SELTEXT DB ?

        ;SELTRPT != 1,2,3
        SELTIV  DB 13,10,"INVALID INPUT! PLEASE TRY AGAIN. $"

.CODE
MAIN PROC
        MOV AX,@DATA
        MOV DS,AX    
		
        ;--------------Display Report Types Menu--------------
; Select Report        
SELTREPROT:
        ; Clear screen
	MOV AX, 02
	INT 10H

        ; Display Report types menu
        MOV AH,09H
        LEA DX,RPTMENU
        INT 21H

        ; Prompt Selection
        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV SELTRPT,AL

        ;---Compare---
        ; 3 - back to Main Menu
        CMP SELTRPT,3
        JE QUITRPT

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

        JMP INVALID
        
        ;--------------Selection = 3--------------
; Quit Report   
QUITRPT: 
        ; Claer screen
	MOV AX, 02
	INT 10H

        ;----Confirm exit----
        ; Dispaly confirmation exit message
        MOV AH,09H
        LEA DX,CONFEXT
        INT 21H
        
        ; Prompt Cormation (Y/N)
        MOV AH,01H
        INT 21H
        MOV SELTEXT,AL

        ;----Compare---
        CMP SELTEXT,"Y"
        JE MAINM

        CMP SELTEXT,"N"
        JNE INVALID
        
        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Dispaly return message
        MOV AH,09H
        LEA DX,RETURN
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H

        JMP SELTREPROT

        ;--------------Selection = 1, Display "Daily Summary Report"--------------
; Report 1
RPT1:   ;recursive menu to display checking
        ; Claer screen
	MOV AX, 02
	INT 10H

        MOV AH,09H
        LEA DX,DATE
        INT 21H    

        ;---Dispaly Today Date---
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

        ; Dispaly continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
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

        ; Dispaly continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
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

        ; Dispaly continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
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

        ;---Dispaly Total Quantity of Dishes---
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
        
        ;---Dispaly Total Quantity of Sides Dishes---
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

        ; Dispaly continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H

        JMP SELTREPROT

        ;--------------Selection = 2, Display "Popular Dishes and Drinks Report"--------------
; Report 2
RPT2:
        ; Claer screen
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

        ; Dispaly continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H
        
        ; Back to Report Types Menu
        JMP SELTREPROT

        ;--------------Invalid Input--------------
INVALID:
        ; Display invalid msssage
        MOV AH,09H
        LEA DX,SELTIV
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Dispaly continue message
        MOV AH,09H
        LEA DX,CONTINUE
        INT 21H

        ; New line
        MOV AH,09H
        LEA DX,NL
        INT 21H

        ; Get any key
        MOV AH,01H
        INT 21H

        ; Back to Report Types Menu
        JMP SELTREPROT

        ;--------------Exit from reprot--------------
;expect JMP back to MAIN MENU...
;blow is temp only
MAINM:
        MOV AH,09H
        LEA DX,MAINMENU  
  
	MOV AX,4C00H
        INT 21H
MAIN ENDP
END MAIN