# heap_sort.asm - Implementación del algoritmo Heap Sort

.text
.globl heap_sort

# Heap Sort
heap_sort:
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s2, 8($sp)
    sw $s1, 4($sp)
    sw $s0, 0($sp)
    
    move $s0, $a0        # Dirección del arreglo
    move $s1, $a1        # Tamaño del arreglo
    
    # Construir heap (reorganizar el arreglo)
    srl $s2, $s1, 1      
    addi $s2, $s2, -1
    
build_heap:
    blt $s2, 0, heap_ready  # if i < 0, terminar
    
    move $a0, $s0        # Dirección del arreglo
    move $a1, $s1        # Tamaño del arreglo
    move $a2, $s2        
    jal heapify
    
    addi $s2, $s2, -1    # i--
    j build_heap
    
heap_ready:
    # Extraer elementos del heap uno por uno
    addi $s2, $s1, -1    # i = n-1
    
extract_loop:
    blez $s2, end_heap_sort  # if i <= 0, terminar
    
    # Intercambiar arr[0] y arr[i]
    lw $t0, 0($s0)       
    sll $t1, $s2, 2      
    add $t1, $s0, $t1   
    lw $t2, 0($t1)      
    sw $t2, 0($s0)       
    sw $t0, 0($t1)      
    
    # Llamar heapify en el heap reducido
    move $a0, $s0        # Dirección del arreglo
    move $a1, $s2        # Nuevo tamaño (i)
    li $a2, 0            
    jal heapify
    
    addi $s2, $s2, -1    # i--
    j extract_loop
    
end_heap_sort:
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra

# Función heapify
heapify:
    addi $sp, $sp, -20
    sw $ra, 16($sp)
    sw $s3, 12($sp)
    sw $s2, 8($sp)
    sw $s1, 4($sp)
    sw $s0, 0($sp)
    
    move $s0, $a0        # Dirección del arreglo
    move $s1, $a1        # Tamaño del heap
    move $s2, $a2        # Índice raíz
    
    sll $t0, $s2, 1      
    addi $s3, $t0, 1    
    addi $t0, $t0, 2    
    
    move $t1, $s2       
    
    # Comparar con hijo izquierdo
    bge $s3, $s1, check_right  # if left >= n, saltar
    sll $t2, $s3, 2      
    add $t2, $s0, $t2    
    lw $t3, 0($t2)      
    
    sll $t4, $t1, 2      
    add $t4, $s0, $t4    
    lw $t5, 0($t4)       
    
    ble $t3, $t5, check_right  # if arr[left] <= arr[largest], saltar
    
    move $t1, $s3        # largest = left
    
check_right:
    bge $t0, $s1, compare_largest  # if right >= n, saltar
    sll $t2, $t0, 2     
    add $t2, $s0, $t2    
    lw $t3, 0($t2)       
    
    sll $t4, $t1, 2      
    add $t4, $s0, $t4    
    lw $t5, 0($t4)      
    
    ble $t3, $t5, compare_largest  # if arr[right] <= arr[largest], saltar
    
    move $t1, $t0        
    
compare_largest:
    beq $t1, $s2, end_heapify  # if largest == i, terminar
    
    # Intercambiar arr[i] y arr[largest]
    sll $t2, $s2, 2      
    add $t2, $s0, $t2    
    lw $t3, 0($t2)       
    
    sll $t4, $t1, 2      
    add $t4, $s0, $t4    
    lw $t5, 0($t4)      
    
    sw $t5, 0($t2)       
    sw $t3, 0($t4)       
    
    # Llamar heapify recursivamente en el subárbol afectado
    move $a0, $s0        
    move $a1, $s1        # Tamaño del heap
    move $a2, $t1        
    jal heapify
    
end_heapify:
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $ra, 16($sp)
    addi $sp, $sp, 20
    jr $ra