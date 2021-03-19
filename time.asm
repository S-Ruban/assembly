
org 100h

time:
mov bx,0x000a
mov ah,0x2c
int 0x21
mov al,ch
xor ah,ah
div bl
xchg al,ah
mov dl,ah
add dl,0x30
mov ah,0x02
int 0x21
mov ah,0x2c
int 0x21
mov al,ch
xor ah,ah
div bl
xchg al,ah
mov dl,al
add dl,0x30
mov ah,0x02
int 0x21
mov dl,0x3a
int 0x21
mov ah,0x2c
int 0x21
mov al,cl
xor ah,ah
div bl
xchg al,ah
mov dl,ah
add dl,0x30
mov ah,0x02
int 0x21
mov ah,0x2c
int 0x21
mov al,cl
xor ah,ah
div bl
xchg al,ah
mov dl,al
add dl,0x30
mov ah,0x02
int 0x21
mov dl,0x3a
int 0x21
mov ah,0x2c
int 0x21
mov al,dh
xor ah,ah
div bl
xchg al,ah
mov dl,ah
add dl,0x30
mov ah,0x02
int 0x21
mov ah,0x2c
int 0x21
mov al,dh
xor ah,ah
div bl
xchg al,ah
mov dl,al
add dl,0x30
mov ah,0x02
int 0x21
xor dx,dx
mov ah,0x02
mov bh,0x00
int 0x10
jmp time
hlt

ret

