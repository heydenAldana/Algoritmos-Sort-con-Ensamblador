# main.asm - Programa principal para probar los algoritmos de ordenamiento

.include "arrays.asm"
.include "bubble_sort.asm"
.include "insertion_sort.asm"
.include "selection_sort.asm"
.include "merge_sort.asm"
.include "heap_sort.asm"
.include "quick_sort.asm"

.text
.globl main

main:
    jal initialize_arrays
    
    # Probar Bubble Sort
    la $a0, msgTesting
    li $v0, 4
    syscall
    la $a0, size10
    lw $a0, 0($a0)
    li $v0, 1
    syscall
    la $a0, newLine
    li $v0, 4
    syscall
    
    la $a0, array10
    lw $a1, size10
    jal bubble_sort
    
    # Probar Insertion Sort
    la $a0, msgTesting
    li $v0, 4
    syscall
    la $a0, size50
    lw $a0, 0($a0)
    li $v0, 1
    syscall
    la $a0, newLine
    li $v0, 4
    syscall
    
    la $a0, array50
    lw $a1, size50
    jal insertion_sort
    
    # Probar Selection Sort
    la $a0, msgTesting
    li $v0, 4
    syscall
    la $a0, size500
    lw $a0, 0($a0)
    li $v0, 1
    syscall
    la $a0, newLine
    li $v0, 4
    syscall
    
    la $a0, array500
    lw $a1, size500
    jal selection_sort
    
    # Probar Merge Sort
    la $a0, msgTesting
    li $v0, 4
    syscall
    la $a0, size5000
    lw $a0, 0($a0)
    li $v0, 1
    syscall
    la $a0, newLine
    li $v0, 4
    syscall
    
    la $a0, array5000
    lw $a1, size5000
    jal merge_sort
    
    # Probar Heap Sort
    la $a0, msgTesting
    li $v0, 4
    syscall
    la $a0, size10000
    lw $a0, 0($a0)
    li $v0, 1
    syscall
    la $a0, newLine
    li $v0, 4
    syscall
    
    la $a0, array10000
    lw $a1, size10000
    jal heap_sort
    
    # Probar Quick Sort
    la $a0, msgTesting
    li $v0, 4
    syscall
    la $a0, size10000
    lw $a0, 0($a0)
    li $v0, 1
    syscall
    la $a0, newLine
    li $v0, 4
    syscall
    
    la $a0, array10000
    lw $a1, size10000
    jal quick_sort
    
    # Hasta aqui termina de funkar el programa
    li $v0, 10
    syscall