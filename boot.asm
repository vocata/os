; BIOS会将主引导扇区加载到内存0x7c00处，org伪指令用于指定起始的偏移地址，
; 例如：mov ax, label，这个label的实际值为0x7c00+label的偏移量
[org 0x7c00]

; 使用BIOS的中断，中断号为0x10，参数通过ax传递，这里设置屏幕为文本模式，
; 并清除屏幕
mov ax, 3
int 0x10

; 初始化段寄存器
mov ax, 0
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00

; 0xb800显示器内存
mov ax, 0xb800
mov ds, ax
mov byte [0], 'H' ; [0]位置为字符，[1]为颜色设置
mov byte [2], 'E'
mov byte [4], 'L'
mov byte [6], 'L'
mov byte [8], 'O'


; 阻塞
jmp $

times 510 - ($ - $$) db 0

; 魔数，表示有效的主引导分区，小端字节序，第510字节为0x55，511字节为0xaa
dw 0xaa55
