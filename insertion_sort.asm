# insertion_sort.asm - Implementación del algoritmo Insertion Sort

.text
.globl insertion_sort

# Insertion Sort
insertion_sort:
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s2, 8($sp)
    sw $s1, 4($sp)
    sw $s0, 0($sp)
    
    move $s0, $a0        # Dirección del arreglo
    move $s1, $a1        # Tamaño del arreglo
    li $s2, 1            # i = 1
    
bubble_outer_loop:
    bge $s2, $s1, bubble_end_outer  # if i >= n, terminar
    
    # key = array[i]
    sll $t0, $s2, 2      # i*4
    add $t0, $s0, $t0    
    lw $t1, 0($t0)       
    
    addi $t2, $s2, -1    # j = i-1
    
bubble_inner_loop:
    blt $t2, 0, bubble_end_inner  # if j < 0, terminar
    
    # array[j]
    sll $t3, $t2, 2     
    add $t3, $s0, $t3    
    lw $t4, 0($t3)      
    
    ble $t4, $t1, bubble_end_inner  # if array[j] <= key, terminar
    
    # array[j+1] = array[j]
    sw $t4, 4($t3)
    
    addi $t2, $t2, -1    # j--
    j bubble_inner_loop
    
bubble_end_inner:
    # array[j+1] = key
    addi $t2, $t2, 1     
    sll $t3, $t2, 2     
    add $t3, $s0, $t3    
    sw $t1, 0($t3)       
    
    addi $s2, $s2, 1     # i++
    j bubble_outer_loop
    
bubble_end_outer:
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra