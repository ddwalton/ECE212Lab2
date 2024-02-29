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
.equ pointAddress, =0x20001000;
.equ xAddress, =0x20001004;
.equ yAddress, =0x20001008;
.equ tempSpace, =0x2000100C;
.equ outAddress, =0x20001010;

LOAD:
ldr r0, =pointAddress;
ldr r0, [r0]; // number of points
ldr r1, =xAddress;
ldr r1, [r1]; // x values
ldr r2, =yAddress;
ldr r2, [r2]; // y values
ldr r3,=outAddress;
ldr r3, [r3]; // out address

mov.w r8, #0; // stores total area

LOOP: // for (; numOfPoints > 1; --numOfPoints)
ldr r4, [r1], #4; // x[i]
ldr r5, [r1]; // x[i+1]
sub r4, r5, r4; // r4 <- x[i+1] - x[i] = deltaX = {1, 2, 4}
ldr r6, [r2], #4; // y[i]
ldr r7, [r2]; // y[i+1]
add r5, r6, r7; // r5 <- y[i] + y[i+1]

DETERMINE:
cmp r4, #1; // if deltaX == 1: A = (y[i]+y[i+1]) / 2
addeq.w r8, r5, asr #1; // divide by 2 and add to area sum
cmp r4, #4; // if deltaX == 4: A = (y[i]+y[i+1]) * 2
addeq.w r8, r5, lsl #1; // multiply by 2 and add to area sum

RESET:
cmp r0, #1;
sub r0, #1;
bhi LOOP;

EXIT:
mov.w r0, r8;
str r0, [r3];

/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
POP {PC}

.data
/*--------------------------------------*/
