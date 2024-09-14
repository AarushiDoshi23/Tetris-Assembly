#####################################################################
# CSCB58 Summer 2024 Assembly Final Project - UTSC
# Student1: Aarushi Doshi, 1009395815, doshiaa1, aarushi.doshi@mail.utoronto.ca
# Student2: Kshitij Kapoor, 1010297581, kapoorks, kshitij.kapoor@mail.utoronto.ca
#
# Bitmap Display Configuration:
# - Unit width in pixels: 16
# - Unit height in pixels: 16
# - Display width in pixels: 256
# - Display height in pixels: 512
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 5
#
# Which approved features have been implemented?
# (See the assignment handout for the list of features)
# Easy Features:
# 1. Feature 1: Gravity
# 2. Feature 2: Increasing Gravity
# 3. Feature 3: Game Over and Restart
# 4. Feature 4: Sound effect when moving the tetronimo
# 5. Feature 5: Pause Game
# 6. Feature 6: Different levels
# Hard Features:
# 1. Feature 4: Animation when lines are completed 
# How to play:
# W: Rotate
# A: Move left
# D: Move Right
# S: Move Down
# R: Restart Game
# Q: Quit Game
# V: End Game
# P: Pause Game
# Link to video demonstration for final submission:
# https://youtu.be/_aYRi0aZ4D0
#
# Are you OK with us sharing the video with people outside course staff?
# - yes
#
#####################################################################
.data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000 

DIS_ARR: .byte 0:2048
SHAPE: .word 24, 0, 0, 0
MOVED_SHAPE: .word 0, 0, 0, 0
    
GREY_BORDER: .word 0x444444        # Colors
GREY_PATTERN: .word 0x161616        
BLUE: .word 0x0000ff  #blue - 2
BLACK: .word 0x000000  
RED: .word 0xff0000 
IS_PAUSED: .word 0   
JUST_UNPAUSED: .word 0
##############################################################################
# Mutable Data
##############################################################################
POS: .word 24
ROT: .word 0
NEXT_STAGE: .word 1
CURRENT_ROWS: .word 0
GAME_SPEED: .word 2000
CURRENT_TIME: .word 0
    

GAME_OVER_PATTERN: 
.word
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,

0x000000,0x42e3f5,0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,
0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,0x000000,

0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,

0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x42e3f5,0x000000,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,

0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,
0x000000,0x42e3f5,0x42e3f5,0x000000,0x42e3f5,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x42e3f5,0x000000,0x42e3f5,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,

0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,

0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000,

0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x42e3f5,0x000000,0x000000,0x000000,
0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x42e3f5,0x000000,0x000000,
0x000000,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x42e3f5,0x000000,0x000000,0x000000,0x000000,0x42e3f5,0x000000,0x000000,0x000000,0x42e3f5,0x000000


PAUSED_PATTERN: 
.word
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,

0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,

0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0xfcba03,0xfcba03,0xfcba03,0xfcba03,0xfcba03,0xfcba03,0xfcba03,0xfcba03,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0xfcba03,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0xfcba03,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0xfcba03,0x000000,0xfcba03,0xfcba03,0x000000,0x000000,0xfcba03,0xfcba03,0x000000,0xfcba03,0x000000,0x000000,0x000000,

0x000000,0x000000,0x000000,0xfcba03,0x000000,0xfcba03,0xfcba03,0x000000,0x000000,0xfcba03,0xfcba03,0x000000,0xfcba03,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0xfcba03,0x000000,0xfcba03,0xfcba03,0x000000,0x000000,0xfcba03,0xfcba03,0x000000,0xfcba03,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0xfcba03,0x000000,0xfcba03,0xfcba03,0x000000,0x000000,0xfcba03,0xfcba03,0x000000,0xfcba03,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0xfcba03,0x000000,0xfcba03,0xfcba03,0x000000,0x000000,0xfcba03,0xfcba03,0x000000,0xfcba03,0x000000,0x000000,0x000000,

0x000000,0x000000,0x000000,0xfcba03,0x000000,0xfcba03,0xfcba03,0x000000,0x000000,0xfcba03,0xfcba03,0x000000,0xfcba03,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0xfcba03,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0xfcba03,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0xfcba03,0xfcba03,0xfcba03,0xfcba03,0xfcba03,0xfcba03,0xfcba03,0xfcba03,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,

0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,

0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,

0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,
0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000,0x000000
##############################################################################
# Code
##############################################################################
	.text
	.globl main

	# Run the Tetris game.

draw_sides:
    la $t6, GREY_BORDER
    lw $t1, 0($t6)
    
    sw $t1, 0($t5)
    li $t2, 1
    sw $t2, 0($t7)
    
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    add $t7, $s0, $t4
    
    sw $t1, 0($t5)
    li $t2, 1
    sw $t2, 0($t7)
    
    addi $t4, $t4, 52
    add $t5, $t0, $t4
    add $t7, $s0, $t4
    
    sw $t1, 0($t5)
    li $t2, 1
    sw $t2, 0($t7)
    
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    add $t7, $s0, $t4
    
    sw $t1, 0($t5)
    li $t2, 1
    sw $t2, 0($t7)
    
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    add $t7, $s0, $t4
    blt $t4, 1914, draw_sides
    jr $ra
    
draw_bottom:
    la $t6, GREY_BORDER
    lw $t1, 0($t6)
    sw $t1, 0($t5)
    li $t2, 1
    sw $t2, 0($t7)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    add $t7, $s0, $t4
    ble $t4, 2044, draw_bottom    
    jr $ra
    
draw_pattern:
	la $t6, GREY_PATTERN
    lw $t1, 0($t6)
    la $t6, BLACK
    lw $t2, 0($t6)
    sw $t1, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t2, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t1, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t2, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t1, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t2, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t1, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t2, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t1, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t2, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t1, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t2, 0($t5)
    addi $t4, $t4, 20
    add $t5, $t0, $t4
    sw $t2, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t1, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t2, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t1, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t2, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t1, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t2, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t1, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t2, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t1, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t2, 0($t5)
    addi $t4, $t4, 4
    add $t5, $t0, $t4
    sw $t1, 0($t5)    
    addi $t4, $t4, 20
    add $t5, $t0, $t4
    blt $t4, 1908, draw_pattern
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal draw_old_shapes
    lw $ra, 0($sp)
    addi $sp, $sp, 4
   
    jr $ra

draw_old_shapes:
	la $t6, BLUE
	lw $t1, 0($t6)
	li $s5, 0
	add $t7, $s0, $s5
	add $t8, $t0, $s5
loop_array:	
	bge $s5, 1909, end_loop
	lw $t2, 0($t7)
	blt $t2, 2, increment 
	sw $t1, 0($t8)
increment:
	addi $s5, $s5, 4
	add $t7, $s0, $s5
	add $t8, $t0, $s5
	b loop_array
end_loop: 
	jr $ra

check_complete_lines:
	li $t4, 8
check_line:
	bge $t4, 1908, done_checking  #Will check each of the rows
	add $t5, $s0, $t4
	lw $t9, 0($t5)                # Checking the 12 different spaces on each row
	blt $t9, 2, next_line         # If any of those spaces are less than 2 then check the next line
	lw $t9, 4($t5)                
	blt $t9, 2, next_line
	lw $t9, 8($t5)
	blt $t9, 2, next_line
	lw $t9, 12($t5)
	blt $t9, 2, next_line
	lw $t9, 16($t5)
	blt $t9, 2, next_line
	lw $t9, 20($t5)
	blt $t9, 2, next_line
	lw $t9, 24($t5)
	blt $t9, 2, next_line
	lw $t9, 28($t5)
	blt $t9, 2, next_line
	lw $t9, 32($t5)
	blt $t9, 2, next_line
	lw $t9, 36($t5)
	blt $t9, 2, next_line
	lw $t9, 40($t5)
	blt $t9, 2, next_line
	lw $t9, 44($t5)
	blt $t9, 2, next_line
	sw $0, 0($t5)         # If none of them are less than 2 we have a full row so making those values 0
	sw $0, 4($t5)
	sw $0, 8($t5)
	sw $0, 12($t5)
	sw $0, 16($t5)
	sw $0, 20($t5)
	sw $0, 24($t5)
	sw $0, 28($t5)
	sw $0, 32($t5)
	sw $0, 36($t5)
	sw $0, 40($t5)
	sw $0, 44($t5)
	
	la $t6, RED
	lw $t1, 0($t6)
	add $t5, $t4, $t0
	sw $t1, 0($t5)
	sw $t1, 4($t5)
	sw $t1, 8($t5)
	sw $t1, 12($t5)
	sw $t1, 16($t5)
	sw $t1, 20($t5)
	sw $t1, 24($t5)
	sw $t1, 28($t5)
	sw $t1, 32($t5)
	sw $t1, 36($t5)
	sw $t1, 40($t5)
	sw $t1, 44($t5)
	li $v0, 32
	li $a0, 100
	syscall
	
	la $t6, CURRENT_ROWS     #Time change implementation
	lw $s5, 0($t6)
	addi $s5, $s5, 1			# adding 1 to the number of row breaks
	sw $s5, 0($t6)
	la $t6, NEXT_STAGE
	lw $s6, 0($t6)
	bne $s6, $s6, next_line      #checking if rows broken is the same as the tarhget
	li $s5, 0					# if its the same making rows 0 again and decresing the speed
	la $t6, CURRENT_ROWS
	sw $s5, 0($t6)
	la $t6, GAME_SPEED
	lw $s5, 0($t6)
	addi $s5, $s5, -500
	blez $s5, reset_speed_to_2000
	sw $s5, 0($t6)
	j next_line
reset_speed_to_2000:
	li $s5, 2000
	sw $s5, 0($t6)
next_line:  
	addi $t4, $t4, 64     # Increment and check next line
	b check_line  
done_checking:    # Once all lines are checked the array should be updated and we can draw
	li $t4, 8
	jal draw_initial_shape_i
	b game_loop
	
recently_paused:
	la $t6, JUST_UNPAUSED
	li $t2, 0
    sw $t2, 0($t6)
	jr $ra
	
draw_initial_shape_i:   #this is the initial shape i
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal draw_pattern
    lw $ra, 0($sp)
    addi $sp, $sp, 4
       
    la $t6, JUST_UNPAUSED       
    lw $t6, 0($t6)
    bnez $t6, recently_paused
    
    lw $s6, 24($s0) 				#Check for game over 
    bnez $s6, respond_to_Q
 	lw $s6, 88($s0)
    bnez $s6, respond_to_Q
    lw $s6, 152($s0)
    bnez $s6, respond_to_Q
    lw $s6, 216($s0)
    bnez $s6, respond_to_Q
	
    la $t6, ROT
	li $t2, 0
	sw $t2, 0($t6)
    
    la $t6, BLUE
    lw $t1, 0($t6)  #$t1 = blue color
    la $t6, POS
    lw $t7, 0($t6)  #$t7 is the pos of the first block of the shape
    
    sw $t7, 0($s1)  # change the SHAPE array to be the pos + offset of the 4 blocks
    addi $t7, $t7, 64
    sw $t7, 4($s1)
    addi $t7, $t7, 64
    sw $t7, 8($s1)
    addi $t7, $t7, 64
    sw $t7, 12($s1)

    lw $t3, 0($s1)                 # Load SHAPE[i] into $t3
    # Set DIS_ARR[SHAPE[i]] = 2 (store byte 0)
    add $t8, $s0, $t3              # Calculate address of DIS_ARR[SHAPE[i]]
    li $t7, 2                      # blue corresponds to the number 2 is the dis_arr
    sw $t7, 0($t8)               # Store word 2 in DIS_ARR[SHAPE[i]]
    add $t5, $t0, $t3
    
    lw $t3, 4($s1)                 # Load SHAPE[i] into $t3
    # Set DIS_ARR[SHAPE[i]] = 2 (store byte 0)
    add $t8, $s0, $t3              # Calculate address of DIS_ARR[SHAPE[i]]
    li $t7, 2                      # blue corresponds to the number 2 is the dis_arr
    sw $t7, 0($t8)               # Store word 2 in DIS_ARR[SHAPE[i]]
    
    lw $t3, 8($s1)                 # Load SHAPE[i] into $t3
    # Set DIS_ARR[SHAPE[i]] = 2 (store byte 0)
    add $t8, $s0, $t3              # Calculate address of DIS_ARR[SHAPE[i]]
    li $t7, 2                      # blue corresponds to the number 2 is the dis_arr
    sw $t7, 0($t8)               # Store byte 0 in DIS_ARR[SHAPE[i]]
    
    lw $t3, 12($s1)                 # Load SHAPE[i] into $t3
    # Set DIS_ARR[SHAPE[i]] = 2 (store byte 0)
    add $t8, $s0, $t3              # Calculate address of DIS_ARR[SHAPE[i]]
    li $t7, 2                      # blue corresponds to the number 2 is the dis_arr
    sw $t7, 0($t8)               # Store byte 0 in DIS_ARR[SHAPE[i]]
    
    sw $t1, 0($t5)
    sw $t1, 64($t5)
    sw $t1, 128($t5)
    sw $t1, 192($t5)
    jr $ra
    
draw_shape_i:    
    la $t6, BLUE
    lw $t1, 0($t6)
    
    li $t4, 2
    lw $t3, 0($s1)
    add $t5, $t3, $t0
    sw $t1, 0($t5)
    add $t5, $t3, $s0
    sw $t4, 0($t5)
    
    lw $t3, 4($s1)
    add $t5, $t3, $t0
    sw $t1, 0($t5)
    add $t5, $t3, $s0
    sw $t4, 0($t5)
    
    lw $t3, 8($s1)
    add $t5, $t3, $t0
    sw $t1, 0($t5)
    add $t5, $t3, $s0
    sw $t4, 0($t5)
    
    lw $t3, 12($s1)
    add $t5, $t3, $t0
    sw $t1, 0($t5)
    add $t5, $t3, $s0
    sw $t4, 0($t5)
    
    li $a0, 61   #load pitch, duration, instrument and volume when peice is moved
    li $a1, 900
    li $a2, 121
    li $a3, 100
    li $v0, 31
    syscall
    
    li $t4, 8
    addi $t5, $t0, 8 
    beq $t9, 0, next_check
    b game_loop
next_check:    beq $s4, 64, check_complete_lines 
    b game_loop
    
draw_moved_shape_i:
    #set dis_arr[SHAPE[i]] to 0 for all i and update the positions of MOVED_SHAPE
    lw $t3, 0($s1)                 # Load SHAPE[i] into $t3
    # Set DIS_ARR[SHAPE[i]] = 0 (store byte 0)
    add $t9, $s0, $t3              # Calculate address of DIS_ARR[SHAPE[i]]
    li $t7, 0                     
    sw $t7, 0($t9)               # Store word 0 in DIS_ARR[SHAPE[i]]
    add $t7, $t3, $s4
    sw $t7, 0($s2)              #MOVED_SHAPE[i] = SHAPE[i] + offset
    #add $t5, $t0, $t3
    
    lw $t3, 4($s1)                 # Load SHAPE[i] into $t3
    # Set DIS_ARR[SHAPE[i]] = 0 (store byte 0)
    add $t9, $s0, $t3              # Calculate address of DIS_ARR[SHAPE[i]]
    li $t7, 0             
    sw $t7, 0($t9)       
    add $t7, $t3, $s4
    sw $t7, 4($s2)
    
    lw $t3, 8($s1)                 # Load SHAPE[i] into $t3
    # Set DIS_ARR[SHAPE[i]] = 0 (store byte 0)
    add $t9, $s0, $t3              # Calculate address of DIS_ARR[SHAPE[i]]
    li $t7, 0                     
    sw $t7, 0($t9)               # Store byte 0 in DIS_ARR[SHAPE[i]]
    add $t7, $t3, $s4
    sw $t7, 8($s2)
    
    lw $t3, 12($s1)                 # Load SHAPE[i] into $t3
    # Set DIS_ARR[SHAPE[i]] = 0 (store byte 0)
    add $t9, $s0, $t3              # Calculate address of DIS_ARR[SHAPE[i]]
    li $t7, 0            
    sw $t7, 0($t9)               # Store byte 0 in DIS_ARR[SHAPE[i]]
    add $t7, $t3, $s4
    sw $t7, 12($s2)
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal draw_pattern
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    li $t9, 0
    #check if all new values are zero in the dis_arr
    lw $t3, 0($s2)           # Load MOVED_SHAPE[0]
    add $t3, $s0, $t3        # $t3 = DIS_ARR + MOVED_SHAPE[0]
    lw $t7, 0($t3)           # Load value from DIS_ARR[MOVED_SHAPE[0]]    
    bnez $t7, draw_shape_i   # If not zero, cannot move

    lw $t3, 4($s2)           # Load MOVED_SHAPE[1]
    add $t3, $s0, $t3        # $t3 = DIS_ARR + MOVED_SHAPE[1]
    lw $t7, 0($t3)           # Load value from DIS_ARR[MOVED_SHAPE[1]]
    bnez $t7, draw_shape_i   # If not zero, cannot move

    lw $t3, 8($s2)           # Load MOVED_SHAPE[2]
    add $t3, $s0, $t3        # $t3 = DIS_ARR + MOVED_SHAPE[2]
    lw $t7, 0($t3)           # Load value from DIS_ARR[MOVED_SHAPE[2]]
    bnez $t7, draw_shape_i   # If not zero, cannot move

    lw $t3, 12($s2)          # Load MOVED_SHAPE[3]
    add $t3, $s0, $t3        # $t3 = DIS_ARR + MOVED_SHAPE[3]
    lw $t7, 0($t3)           # Load value from DIS_ARR[MOVED_SHAPE[3]]
    bnez $t7, draw_shape_i   # If not zero, cannot move

    li $t9, 1
    #else, all are zero, everything can be moved
    lw $t3, 0($s2)
    sw $t3, 0($s1)
    lw $t3, 4($s2)
    sw $t3, 4($s1)
    lw $t3, 8($s2)
    sw $t3, 8($s1)
    lw $t3, 12($s2)
    sw $t3, 12($s1)
    b draw_shape_i
    
draw_rotate_i:
    lw $t3, 0($s1) 
    add $t9, $s0, $t3              # Calculate address of DIS_ARR[SHAPE[i]]
    li $t7, 0                     
    sw $t7, 0($t9)            #MOVED_SHAPE[i] = SHAPE[i] + offset
    
    lw $t3, 4($s1)                 # Load SHAPE[i] into $t3
    # Set DIS_ARR[SHAPE[i]] = 0 (store byte 0)
    add $t9, $s0, $t3              # Calculate address of DIS_ARR[SHAPE[i]]
    li $t7, 0                
    sw $t7, 0($t9)               # Store word 0 in DIS_ARR[SHAPE[i]]
    
    lw $t3, 8($s1)                 # Load SHAPE[i] into $t3
    # Set DIS_ARR[SHAPE[i]] = 0 (store byte 0)
    add $t9, $s0, $t3              # Calculate address of DIS_ARR[SHAPE[i]]
    li $t7, 0      
    sw $t7, 0($t9)               # Store byte 0 in DIS_ARR[SHAPE[i]]
    
    lw $t3, 12($s1)                 # Load SHAPE[i] into $t3
    # Set DIS_ARR[SHAPE[i]] = 0 (store byte 0)
    add $t9, $s0, $t3              # Calculate address of DIS_ARR[SHAPE[i]]
    li $t7, 0   
    sw $t7, 0($t9)               # Store byte 0 in DIS_ARR[SHAPE[i]]
	
	la $t6, ROT
    lw $t2, 0($t6)
    beq $t2, 0, first_pos_i
    beq $t2, 1, second_pos_i
    beq $t2, 2, first_pos_i
    beq $t2, 3, second_pos_i
first_pos_i:
	lw $t3, 0($s1)
	sw $t3, 0($s2)
	addi $t3, $t3, 64
	sw $t3, 4($s2)
    	addi $t3, $t3, 64
	sw $t3, 8($s2)
	addi $t3, $t3, 64
	sw $t3, 12($s2)
    
    lw $t3, 0($s2)           # Load MOVED_SHAPE[0]
    add $t3, $s0, $t3        # $t3 = DIS_ARR + MOVED_SHAPE[0]
    lw $t7, 0($t3)           # Load value from DIS_ARR[MOVED_SHAPE[0]]
    bnez $t7, draw_shape_i   # If not zero, cannot move

    lw $t3, 4($s2)           # Load MOVED_SHAPE[1]
    add $t3, $s0, $t3        # $t3 = DIS_ARR + MOVED_SHAPE[1]
    lw $t7, 0($t3)           # Load value from DIS_ARR[MOVED_SHAPE[1]]
    bnez $t7, draw_shape_i   # If not zero, cannot move

    lw $t3, 8($s2)           # Load MOVED_SHAPE[2]
    add $t3, $s0, $t3        # $t3 = DIS_ARR + MOVED_SHAPE[2]
    lw $t7, 0($t3)           # Load value from DIS_ARR[MOVED_SHAPE[2]]
    bnez $t7, draw_shape_i   # If not zero, cannot move

    lw $t3, 12($s2)          # Load MOVED_SHAPE[3]
    add $t3, $s0, $t3        # $t3 = DIS_ARR + MOVED_SHAPE[3]
    lw $t7, 0($t3)           # Load value from DIS_ARR[MOVED_SHAPE[3]]
    bnez $t7, draw_shape_i   # If not zero, cannot move

	addi $sp, $sp, -4
	sw $ra, 0($sp)
    jal draw_pattern
    lw $ra, 0($sp)
    addi $sp, $sp, 4
	
    #else, all are zero, everything can be moved
    lw $t3, 0($s2)
    sw $t3, 0($s1)
    lw $t3, 4($s2)
    sw $t3, 4($s1)
    lw $t3, 8($s2)
    sw $t3, 8($s1)
    lw $t3, 12($s2)
    sw $t3, 12($s1)
    b draw_shape_i
second_pos_i:
	lw $t3, 0($s1)
	sw $t3, 0($s2)
	addi $t3, $t3, 4
	sw $t3, 4($s2)
    	addi $t3, $t3, 4
	sw $t3, 8($s2)
	addi $t3, $t3, 4
	sw $t3, 12($s2)
    
    lw $t3, 0($s2)           # Load MOVED_SHAPE[0]
    add $t3, $s0, $t3        # $t3 = DIS_ARR + MOVED_SHAPE[0]
    lw $t7, 0($t3)           # Load value from DIS_ARR[MOVED_SHAPE[0]]
    bnez $t7, draw_shape_i   # If not zero, cannot move

    lw $t3, 4($s2)           # Load MOVED_SHAPE[1]
    add $t3, $s0, $t3        # $t3 = DIS_ARR + MOVED_SHAPE[1]
    lw $t7, 0($t3)           # Load value from DIS_ARR[MOVED_SHAPE[1]]
    bnez $t7, draw_shape_i   # If not zero, cannot move

    lw $t3, 8($s2)           # Load MOVED_SHAPE[2]
    add $t3, $s0, $t3        # $t3 = DIS_ARR + MOVED_SHAPE[2]
    lw $t7, 0($t3)           # Load value from DIS_ARR[MOVED_SHAPE[2]]
    bnez $t7, draw_shape_i   # If not zero, cannot move

    lw $t3, 12($s2)          # Load MOVED_SHAPE[3]
    add $t3, $s0, $t3        # $t3 = DIS_ARR + MOVED_SHAPE[3]
    lw $t7, 0($t3)           # Load value from DIS_ARR[MOVED_SHAPE[3]]
    bnez $t7, draw_shape_i   # If not zero, cannot move
    
    	addi $sp, $sp, -4
	sw $ra, 0($sp)
    jal draw_pattern
    lw $ra, 0($sp)
    addi $sp, $sp, 4

        #else, all are zero, everything can be moved
    lw $t3, 0($s2)
    sw $t3, 0($s1)
    lw $t3, 4($s2)
    sw $t3, 4($s1)
    lw $t3, 8($s2)
    sw $t3, 8($s1)
    lw $t3, 12($s2)
    sw $t3, 12($s1)
    b draw_shape_i

main:
    lw $t0, ADDR_DSPL       # $t0 = base address for display
    la $s0, DIS_ARR         #s0 = base address for dis_arr
    la $s1, SHAPE           #s1 = base address for the shape
    la $s2, MOVED_SHAPE
    li $t4, 0
    add $t5, $t0, $t4   #display + offset
    add $t7, $s0, $t4   #dis_arr + offset
    jal draw_sides
    li $t4, 1920
    add $t5, $t0, $t4
    add $t7, $s0, $t4
    jal draw_bottom
    li $t4, 8   #this is to set the starting position of the pattern
    add $t5, $t0, $t4
    jal draw_initial_shape_i       # Initialize the game
    
game_loop:
	la $t6, NEXT_STAGE
	lw $s5, 0($t6)
	la $t6, GAME_SPEED
	lw $s6, 0($t6)
    la $t6, CURRENT_TIME
	lw $s7, 0($t6)
    li $v0, 32
    li $a0, 10
    syscall
    addi $s7, $s7, 10
    sw $s7, 0($t6)
    beq $s6, $s7, respond_to_S 
    lw $t2, ADDR_KBRD               # $t2 = base address for keyboard
    lw $t8, 0($t2)                  # Load first word from keyboard
    beq $t8, 1, keyboard_input      # If first word 1, key is pressed
    b game_loop

keyboard_input:                     # A key is pressed  
    lw $a0, 4($t2)                  # Load second word from keyboard
    la $a1, IS_PAUSED
    lw $a1, 0($a1)
    li $a2, 1
  	beq $a0, 112, respond_to_P
  	beq $a0, 113, respond_to_Q
    beq $a1, $a2, game_loop
    beq $a0, 100, respond_to_D     # Check if the key d was pressed
    beq $a0, 97, respond_to_A
    beq $a0, 115, respond_to_S
    beq $a0, 119, respond_to_W
    beq $a0, 114, respond_to_R
    beq $a0, 118, end_game
    b game_loop

respond_to_R:
	la $s5, CURRENT_TIME
	li $s6, 0
	sw $s6, 0($s5)
	la $s5, GAME_SPEED
	li $s6, 2000
	sw $s6, 0($s5)
	la $s5, CURRENT_ROWS
	li $s6, 0
	sw $s6, 0($s5)
	la $s5, IS_PAUSED
	sw $0, 0($s5)
	la $s5, JUST_UNPAUSED
	sw $0, 0($s5) 
	#rest the display arr
	la $t1, DIS_ARR      # Load base address of DIS_ARR into $t1
    li $t0, 0            # Initialize offset ($t0) to 0
    li $t5, 0            # Set value to zero

reset_dis_arr_loop:
	#reset dis_arr
    sw $t5, 0($t1)       # Store byte (0) into the current address at base + offset
    addi $t1, $t1, 4     # Move to the next word in the array by incrementing base address
    addi $t0, $t0, 4     # Increment the offset
    blt $t0, 2048, reset_dis_arr_loop # If offset <= 2048, branch to loop
    #reset_shape
    la $t1, SHAPE
	sw $t5, 0($t1)
	sw $t5, 4($t1) 
	sw $t5, 8($t1) 
	sw $t5, 12($t1)  
	#reset_moved_shape
	la $t1, MOVED_SHAPE
	sw $t5, 0($t1)
	sw $t5, 4($t1) 
	sw $t5, 8($t1) 
	sw $t5, 12($t1)
	#reset_pos_and_rot
	la $t1, ROT
	sw $t5, 0($t1)
	la $t1, POS
	addi $t5, $t5, 24
	sw $t5, 0($t1)
	j main

respond_to_D:
    li $t4, 8   #inintal offset for the pattern
    add $t5, $t0, $t4
    li $s4, 4 #the increment value for the shape is 4
    jal draw_moved_shape_i
    b game_loop
    
respond_to_A:
    li $t4, 8   #inintal offset for the pattern
    add $t5, $t0, $t4
    li $s4, -4 #the increment value for the shape is 4
    jal draw_moved_shape_i
    b game_loop

respond_to_S:
	beq $s7, $s6, reset_time
    li $t4, 8   #inintal offset for the pattern
    add $t5, $t0, $t4
    li $s4, 64 #the increment value for the shape is 64
    jal draw_moved_shape_i
    b game_loop
reset_time:
	li $s7, 0
	sw $s7, 0($t6)
	b respond_to_S

respond_to_W:
	la $t6, ROT
	lw $t2, 0($t6)
	blt $t2, 3, first_pos
	beq $t2, 3, fourth_pos
first_pos:
    addi $t2, $t2, 1
    sw $t2, 0($t6)
    li $t4, 8
    add $t5, $t0, $t4
    jal draw_rotate_i
    b game_loop
fourth_pos:
	li $t2, 0
	sw $t2, 0($t6)
	li $t4, 8
    add $t5, $t0, $t4
	jal draw_rotate_i
	b game_loop
	
respond_to_P:
	la $t1, IS_PAUSED
	lw $t2, 0($t1)
	beqz $t2, game_paused
	li $t2, 0
	sw $t2, 0($t1)
	
	la $t6, CURRENT_TIME
	li $s5, 0
	sw $s5, 0($t6)
	j main 

retrieve_data:
	lw $t4, 0($sp)
	addi $sp, $sp, 4
	lw $t5, 0($sp)
	addi $sp, $sp, 4
	j game_loop

game_paused:
	la $t3, IS_PAUSED
	li $t2, 1
	sw $t2, 0($t3)
	
	la $t6, CURRENT_TIME
	li $s5, 5000
	sw $s5, 0($t6)
		
	la $t3, JUST_UNPAUSED
	li $t2, 1
	sw $t2, 0($t3)
	la $t2, PAUSED_PATTERN    #draw game paused screen

	
	addi $sp, $sp, -4
	sw $t5, 0($sp)
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	
	li $t4, 0
	addi $t5, $t0, 0
draw_paused_screen:
	beq $t4, 2048, retrieve_data          # End loop after processing 2048 colors 
    lw $t3, 0($t2)            # Load word from test pattern into $t2
    sw $t3, 0 ($t5)
    addi $t4, $t4, 4          # Increment counter
    addi $t5, $t5, 4          # Move to the next word in pattern
    addi $t2, $t2, 4
    j draw_paused_screen      # Repeat loop
    
draw_game_over:
    beq $t5, 2048, play_game_over_notes           # End loop after processing 8 colors (length of test pattern)
    lw $t6, 0($t2)            # Load word from test pattern into $t6
    sw $t6, 0($t1)            # Store word into display memory
    addi $t5, $t5, 1          # Increment counter
    addi $t2, $t2, 4          # Move to the next word in pattern
    addi $t1, $t1, 4          # Move to the next location in display memory
    j draw_game_over          # Repeat loop

play_game_over_notes:
    li $a0, 42   #load pitch, duration, instrument and volume when peice is moved F#
    li $a1, 1200
    li $a2, 33
    li $a3, 100
    li $v0, 31
    syscall
    
    li $a0, 39   #load pitch, duration, instrument and volume when peice is moved D#
    li $a1, 1200
    li $a2, 33
    li $a3, 100
    li $v0, 31
    syscall
    
    li $a0, 36   #load pitch, duration, instrument and volume when peice is moved C#
    li $a1, 1200
    li $a2, 33
    li $a3, 100
    li $v0, 31
    syscall
waiting_to_reset:
	li $v0, 32
	li $a0, 50
	syscall
    lw $t2, ADDR_KBRD               # $t2 = base address for keyboard
    lw $t8, 0($t2)                  # Load first word from keyboard
    lw $a0, 4($t2) 
    beq $a0, 114, respond_to_R
    beq $a0, 118, end_game
    j waiting_to_reset

respond_to_Q:
    lw $t1, ADDR_DSPL         # Load base address of display memory into $t1
    la $t2, GAME_OVER_PATTERN      # Load address of test pattern into $t2
    li $t4, 0                 # Initialize index
    li $t5, 0                 # Set counter to zero
    
    la $t6, CURRENT_TIME
    li $s5, 5000
    sw $s5, 0($t6)
    
    j draw_game_over

end_game:
    li $v0, 10
    syscall
