ORG 100H

.data

start_message1 db "Welcome to TIC TAC TOE!$"
start_message2 db "Choose an option to start!$"

option_message1 db 0dh, 0ah, "1. Start Game$"
option_message2 db 0dh, 0ah, "2. How to Play$"
option_message3 db 0dh, 0ah, "3. Quit$"

instruction_message1 db "How to Play:$"
instruction_message2 db "Tic tac toe is a classic game for two players,$"
instruction_message3 db "typically played on a 3x3 grid, where players$"
instruction_message4 db "take turns placing either X or O in the empty squares.$"
instruction_message5 db "First player to get 3 X's or O's in either$" 
instruction_message6 db "horizontal, vertical, or diagonal line wins!$"
instruction_message7 db "Press any key to return to Main Menu$"
exit_message db "Thank you for playing!$" 

start_input db 0


.code
 
menu_loop:
    ; ishtart iscreen
    call clear
    
    call newline
    
    mov ah, 09h
    lea dx, start_message1
    int 21h
    
    call newline
    
    mov ah, 09h
    lea dx, start_message2
    int 21h
    
    call newline
        
    ; options
    
    mov ah, 09h
    lea dx, option_message1
    int 21h 
    
    mov ah, 09h
    lea dx, option_message2
    int 21h
    
    mov ah, 09h
    lea dx, option_message3
    int 21h
    
    call newline
    call newline
    
    call player_input
    
    call newline
        
    ;test if 1, 2, or 3

    cmp byte ptr [start_input], '1'
    je start_game
    cmp byte ptr [start_input], '2'
    je show_instruction
    cmp byte ptr [start_input], '3'
    je end_game  
    ;else natin to
    mov byte ptr [start_input], 0
    jmp menu_loop
     

;start game    
start_game:
    jmp menu_loop

;how to play
show_instruction:
    call clear
    
    mov ah, 09h
    lea dx, instruction_message1
    int 21h
    call newline
    mov ah, 09h
    lea dx, instruction_message2
    int 21h
    call newline
    mov ah, 09h
    lea dx, instruction_message3
    int 21h
    call newline
    mov ah, 09h
    lea dx, instruction_message4
    int 21h
    call newline
    call newline
    mov ah, 09h
    lea dx, instruction_message5
    int 21h
    call newline
    mov ah, 09h
    lea dx, instruction_message6
    int 21h
    call newline
    call newline
    mov ah, 09h
    lea dx, instruction_message7
    int 21h
    mov ah, 01h
    int 21h
    
    jmp menu_loop
    

;end game    
end_game:
    call clear
    
    call newline
    
    mov ah, 09h
    lea dx, exit_message
    int 21h
    int 20h
    
;clear screen
clear:

    mov ah, 06h
    mov al, 00h
    mov bh, 07h
    mov cx, 0
    mov dx, 184fh
    int 10h
    ret
    
;player input    
player_input:
    lea dx, start_input
    mov ah, 01h
    int 21h
    mov [start_input], al
    ret


     
; call newline
newline:
    mov ah, 02h
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h
    ret

    