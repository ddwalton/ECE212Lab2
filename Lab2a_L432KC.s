/*Author - Wing Hoy. Last edited on Jan 14, 2022 */
/*-----------------DO NOT MODIFY--------*/
.global TestAsmCall
.global printf
.global cr
.syntax unified

.text
TestAsmCall:
PUSH {lr}
/*--------------------------------------*/

/*-------Students write their code here ------------*/
DEFINE:

.equ sizeOfArray, 0x20001000;
.equ firstArray, 0x200010004; address of first array
.equ secondArray, 0x20001008; address of second array
.equ riwo, 0x2000100C; Register Indirect With Offset
.equ iri, 0x2001010; Indexed Register Indirect
.equ piri, 0x20001014; Post increment Register Indirect

ldr r0, =sizeOfArray;
ldr r1, =firstArray;
ldr r2, =secondArray;

A1:
ldr r5, =riwo;
mov r6, #0; incrementing by 4 each iteration until reaches C (3 iterations)

LOOP1: ;for (int r6 = 0; r6 < 12; r6 += 4)
ldr r3, [r1, r6]; r3 = current value in array 1
ldr r4, [r2, r6]; r4 = current value in array 2
add r7, r3, r4; store addition of current elements into r7
str r7, [r5, r6]; store result in riwo address

cmp r6, #0xB;
add r6, #4;
bls LOOP1; restart loop if r6 hasn't reached 0xC = 12 (using bls to prevent malfunction) 

A2:
ldr r5, =iri;
mov r6, #0; incrementing by 1 each iteration until it reaches size of array

LOOP2: ;for (int r6 = 0; r6 < sizeOfArray; ++r6)
ldr r3, [r1]; r3 = current value in array 1
ldr r4, [r2]; r4 = current value in array 2
add r7, r3, r4; store addition of current elements into r7
str r7, [r5];

add r1, #4; increment all addresses by 4
add r2, #4; 
add r5, #4;

cmp r0, r6;
add r6, #1;
bhi LOOP2; restart loop if r6 < sizeOfArray

A3:
ldr r1, =firstArray;
ldr r2, =secondArray;
ldr r5, =piri;

mov r6, #0; incrementing by 1 each iteration until it reaches size of array

LOOP3: ;for (int r6 = 0; r6 < sizeOfArray; ++r6)
ldr r3, [r1], #4; r3 = current value in array 1 and increment address by 4
ldr r4, [r2], #4; r4 = current value in array 2 and increment address by 4
add r7, r3, r4; store addition of current elements into r7
str r7, [r5], #4; store r7 into address in r5 and increment address by 4

cmp r0, r6;
add r6, #1;
bhi LOOP3; restart loop if r6 < sizeOfArray

/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
POP {PC}

.data
/*--------------------------------------*/
