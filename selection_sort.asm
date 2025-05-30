# selection_sort.asm - Implementación del algoritmo Selection Sort

.text
.globl selection_sort

# Selection Sort
selection_sort:
    addi $sp, $sp, -20
    sw $ra, 16($sp)
    sw $s3, 12($sp)
    sw $s2, 8($sp)
    sw $s1, 4($sp)
    sw $s0, 0($sp)
    
    move $s0, $a0        # Dirección del arreglo
    move $s1, $a1        # Tamaño del arreglo
    li $s2, 0            # i = 0
    
selection_outer_loop:
    addi $t0, $s1, -1    
    bge $s2, $t0, selection_end_outer  # if i >= n-1, terminar
    
    move $s3, $s2        
    addi $t1, $s2, 1     
    
selection_inner_loop:
    bge $t1, $s1, selection_end_inner  # if j >= n, terminar
    
    # array[j]
    sll $t2, $t1, 2      # j*4
    add $t2, $s0, $t2    # &array[j]
    lw $t3, 0($t2)       # array[j]
    
    # array[min_idx]
    sll $t4, $s3, 2      # min_idx*4
    add $t4, $s0, $t4    # &array[min_idx]
    lw $t5, 0($t4)       # array[min_idx]
    
    bge $t3, $t5, selection_no_new_min  # if array[j] >= array[min_idx], no actualizar
    
    move $s3, $t1        
    
selection_no_new_min:
    addi $t1, $t1, 1     # j++
    j selection_inner_loop
    
selection_end_inner:
    beq $s3, $s2, selection_no_swap_needed  # if min_idx == i, no intercambiar
    
    # Intercambiar array[i] y array[min_idx]
    sll $t2, $s2, 2      
    add $t2, $s0, $t2    
    lw $t3, 0($t2)       
    
    sll $t4, $s3, 2     
    add $t4, $s0, $t4    
    lw $t5, 0($t4)       
    
    sw $t5, 0($t2)       
    sw $t3, 0($t4)       
    
selection_no_swap_needed:
    addi $s2, $s2, 1     # i++
    j selection_outer_loop
    
selection_end_outer:
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $ra, 16($sp)
    addi $sp, $sp, 20
    jr $ra