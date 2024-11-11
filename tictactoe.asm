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
instruction_message6 db "a horizontal, vertical, or diagonal line wins!$"
instruction_message7 db "Press any key to return to Main Menu$"
exit_message db "Thank you for playing!$" 

start_input db 0

play_message1 db "Let's Play TIC TAC TOE!$"

; tic tac toe logic
line1 db "|$"
line2 db "-----------$"

cell1 db " 1 $"   
cell2 db " 2 $"   
cell3 db " 3 $"  
cell4 db " 4 $"   
cell5 db " 5 $"   
cell6 db " 6 $"  
cell7 db " 7 $"  
cell8 db " 8 $"  
cell9 db " 9 $"

p1 db "Player 1's turn (X)$"
p2 db "Player 2's turn (O)$"
cell_input db "Enter a cell # $" 

cell_error db "Invalid Cell Number!$"

; 0 = empty, 1 = X, 2 = O
cell_flag db 0, 0, 0, 0, 0, 0, 0, 0, 0

; inputs ng players

; 0 = player 1, 1 = player 2
player_turn db 0

p1_input db 0
p2_input db 0

.code
 
menu_loop:
    ; ishtart ishcreen
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
    
    call menu_input
    
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
    call clear
    
    mov ah, 09h
    lea dx, play_message1
    int 21h
    
    call newline
    call newline
    
    call generate_grid
    
    call players_turn
    
    
    call newline
    
    mov ah, 09h
    lea dx, cell_input
    int 21h
    
    
    
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
menu_input:
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
    
; player turns
players_turn:
    cmp byte ptr [player_turn], 0
    je p1_turn
    cmp byte ptr [player_turn], 1
    je p2_turn
    

p1_turn:
    mov ah, 09h
    lea dx, p1
    int 21h
    
    call newline
    
    mov ah, 09h
    lea dx, cell_input
    int 21h
    
    mov ah, 01h
    int 21h
    
    mov [p1_input], al
    
    mov byte ptr [player_turn], 1
    
    call clear
    
    call newline
    
    call update_grid_x
    
    jmp players_turn
    
p2_turn:
    mov ah, 09h
    lea dx, p2
    int 21h
    
    call newline
    
    mov ah, 09h
    lea dx, cell_input
    int 21h
    
    mov ah, 01h
    int 21h
    
    mov [p1_input], al
    
    mov byte ptr [player_turn], 0
    
    call clear
    
    call newline
    
    call update_grid_o
    
    jmp players_turn    
    
    


; generate grid
generate_grid:
    mov ah, 09h
    lea dx, cell1
    int 21h
    
    lea dx, line1
    int 21h
    
    lea dx, cell2
    int 21h
    
    lea dx, line1
    int 21h
    
    lea dx, cell3
    int 21h
    
    call newline
    
    mov ah, 09h
    lea dx, line2
    int 21h
    
    call newline
    
    mov ah, 09h
    lea dx, cell4
    int 21h
    
    lea dx, line1
    int 21h
    
    lea dx, cell5
    int 21h
    
    lea dx, line1
    int 21h
    
    lea dx, cell6
    int 21h
    
    call newline
    
    mov ah, 09h
    lea dx, line2
    int 21h
    
    call newline
    
    mov ah, 09h
    lea dx, cell7
    int 21h
    
    lea dx, line1
    int 21h
    
    lea dx, cell8
    int 21h
    
    lea dx, line1
    int 21h
    
    lea dx, cell9
    int 21h
    
    call newline
    call newline
    
    ret
    
; update grid X
update_grid_x:
    cmp byte ptr [p1_input], "1"
    je check_cell1_x 
    
    cmp byte ptr [p1_input], "2"
    je check_cell2_x 
    
    cmp byte ptr [p1_input], "3"
    je check_cell3_x 
    
    cmp byte ptr [p1_input], "4"
    je check_cell4_x 
    
    cmp byte ptr [p1_input], "5"
    je check_cell5_x
    
    cmp byte ptr [p1_input], "6"
    je check_cell6_x 
    
    cmp byte ptr [p1_input], "7"
    je check_cell7_x
    
    cmp byte ptr [p1_input], "8"
    je check_cell8_x 
    
    cmp byte ptr [p1_input], "9"
    je check_cell9_x

    ; error handling ng update grid
    mov ah, 09h
    lea dx, cell_error
    int 21h
    
    call newline
    call newline 
    
    mov byte ptr [p1_input], 0
    mov byte ptr [player_turn], 0
    
    call generate_grid 
    
    jmp players_turn

check_cell1_x:
    cmp byte ptr [cell_flag], 0
    je update_cell1_x
    call cell_occupied_x
    jmp players_turn

check_cell2_x:
    cmp byte ptr [cell_flag+1], 0
    je update_cell2_x
    call cell_occupied_x
    jmp players_turn

check_cell3_x:
    cmp byte ptr [cell_flag+2], 0
    je update_cell3_x
    call cell_occupied_x
    jmp players_turn

check_cell4_x:
    cmp byte ptr [cell_flag+3], 0
    je update_cell4_x
    call cell_occupied_x
    jmp players_turn

check_cell5_x:
    cmp byte ptr [cell_flag+4], 0
    je update_cell5_x
    call cell_occupied_x
    jmp players_turn

check_cell6_x:
    cmp byte ptr [cell_flag+5], 0
    je update_cell6_x
    call cell_occupied_x
    jmp players_turn

check_cell7_x:
    cmp byte ptr [cell_flag+6], 0
    je update_cell7_x
    call cell_occupied_x
    jmp players_turn

check_cell8_x:
    cmp byte ptr [cell_flag+7], 0
    je update_cell8_x
    call cell_occupied_x
    jmp players_turn

check_cell9_x:
    cmp byte ptr [cell_flag+8], 0
    je update_cell9_x
    call cell_occupied_x
    jmp players_turn

    
    
; update cells X
update_cell1_x:
    lea di, cell1
    mov byte ptr [di], " "
    mov byte ptr [di+1], "X"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"
    mov byte ptr [cell_flag], 1
    call generate_grid
    ret
update_cell2_x:
    lea di, cell2
    mov byte ptr [di], " "
    mov byte ptr [di+1], "X"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+1], 1
    call generate_grid
    ret 
update_cell3_x:
    lea di, cell3
    mov byte ptr [di], " "
    mov byte ptr [di+1], "X"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+2], 1
    call generate_grid
    ret
update_cell4_x:
    lea di, cell4
    mov byte ptr [di], " "
    mov byte ptr [di+1], "X"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+3], 1
    call generate_grid
    ret 
update_cell5_x:
    lea di, cell5
    mov byte ptr [di], " "
    mov byte ptr [di+1], "X"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+4], 1
    call generate_grid
    ret
update_cell6_x:
    lea di, cell6
    mov byte ptr [di], " "
    mov byte ptr [di+1], "X"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+5], 1
    call generate_grid
    ret 
update_cell7_x:
    lea di, cell7
    mov byte ptr [di], " "
    mov byte ptr [di+1], "X"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+6], 1
    call generate_grid
    ret 
update_cell8_x:
    lea di, cell8
    mov byte ptr [di], " "
    mov byte ptr [di+1], "X"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+7], 1
    call generate_grid
    ret 
update_cell9_x:
    lea di, cell9
    mov byte ptr [di], " "
    mov byte ptr [di+1], "X"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+8], 1
    call generate_grid
    ret
    
    
    
; update grid O
update_grid_o:
    cmp byte ptr [p1_input], "1"
    je check_cell1_o 
    
    cmp byte ptr [p1_input], "2"
    je check_cell2_o 
    
    cmp byte ptr [p1_input], "3"
    je check_cell3_o 
    
    cmp byte ptr [p1_input], "4"
    je check_cell4_o 
    
    cmp byte ptr [p1_input], "5"
    je check_cell5_o
    
    cmp byte ptr [p1_input], "6"
    je check_cell6_o 
    
    cmp byte ptr [p1_input], "7"
    je check_cell7_o
    
    cmp byte ptr [p1_input], "8"
    je check_cell8_o 
    
    cmp byte ptr [p1_input], "9"
    je check_cell9_o

    ; error handling ng update grid
    mov ah, 09h
    lea dx, cell_error
    int 21h
    
    call newline
    call newline 
    
    mov byte ptr [p1_input], 0
    mov byte ptr [player_turn], 1
    
    call generate_grid 
    
    jmp players_turn

check_cell1_o:
    cmp byte ptr [cell_flag], 0
    je update_cell1_o
    call cell_occupied_o
    jmp players_turn

check_cell2_o:
    cmp byte ptr [cell_flag+1], 0
    je update_cell2_o
    call cell_occupied_o
    jmp players_turn

check_cell3_o:
    cmp byte ptr [cell_flag+2], 0
    je update_cell3_o
    call cell_occupied_o
    jmp players_turn

check_cell4_o:
    cmp byte ptr [cell_flag+3], 0
    je update_cell4_o
    call cell_occupied_o
    jmp players_turn

check_cell5_o:
    cmp byte ptr [cell_flag+4], 0
    je update_cell5_o
    call cell_occupied_o
    jmp players_turn

check_cell6_o:
    cmp byte ptr [cell_flag+5], 0
    je update_cell6_o
    call cell_occupied_o
    jmp players_turn

check_cell7_o:
    cmp byte ptr [cell_flag+6], 0
    je update_cell7_o
    call cell_occupied_o
    jmp players_turn

check_cell8_o:
    cmp byte ptr [cell_flag+7], 0
    je update_cell8_o
    call cell_occupied_o
    jmp players_turn

check_cell9_o:
    cmp byte ptr [cell_flag+8], 0
    je update_cell9_o
    call cell_occupied_o
    jmp players_turn
    
; update cells O
update_cell1_o:
    lea di, cell1
    mov byte ptr [di], " "
    mov byte ptr [di+1], "O"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"
    mov byte ptr [cell_flag], 2
    call generate_grid
    ret
update_cell2_o:
    lea di, cell2
    mov byte ptr [di], " "
    mov byte ptr [di+1], "O"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"
    mov byte ptr [cell_flag+1], 2
    call generate_grid
    ret 
update_cell3_o:
    lea di, cell3
    mov byte ptr [di], " "
    mov byte ptr [di+1], "O"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+2], 2
    call generate_grid
    ret
update_cell4_o:
    lea di, cell4
    mov byte ptr [di], " "
    mov byte ptr [di+1], "O"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+3], 2
    call generate_grid
    ret 
update_cell5_o:
    lea di, cell5
    mov byte ptr [di], " "
    mov byte ptr [di+1], "O"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+4], 2
    call generate_grid
    ret
update_cell6_o:
    lea di, cell6
    mov byte ptr [di], " "
    mov byte ptr [di+1], "O"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+5], 2
    call generate_grid
    ret 
update_cell7_o:
    lea di, cell7
    mov byte ptr [di], " "
    mov byte ptr [di+1], "O"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+6], 2
    call generate_grid
    ret 
update_cell8_o:
    lea di, cell8
    mov byte ptr [di], " "
    mov byte ptr [di+1], "O"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+7], 2
    call generate_grid
    ret 
update_cell9_o:
    lea di, cell9
    mov byte ptr [di], " "
    mov byte ptr [di+1], "O"
    mov byte ptr [di+2], " "
    mov byte ptr [di+3], "$"   
    mov byte ptr [cell_flag+8], 2
    call generate_grid
    ret
    
; cell occupied
cell_occupied_x:
    mov ah, 09h
    lea dx, cell_error
    int 21h
    
    call newline
    call newline
    
    call generate_grid
    
    mov byte ptr [player_turn], 0
    
    ret
    
cell_occupied_o:
    mov ah, 09h
    lea dx, cell_error
    int 21h
    
    call newline
    call newline
    
    call generate_grid
    
    mov byte ptr [player_turn], 1
    
    ret