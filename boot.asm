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

; bochs魔术断点
xchg bx, bx

; 获取数据地址，调用打印函数
mov si, booting
call print

; 阻塞
jmp $

; 打印函数
print:
  mov ah, 0x0e  ; 中断0x10的参数之一，ah=0x0e表示在光标位置显示字符
.next:
  mov al, [si]  ; 中断0x10的参数之一，al指定了要显示的字符
  cmp al, 0
  jz .done
  int 0x10
  inc si
  jmp .next
.done:
  ret
  
; 打印信息
booting:
  db "Hello world!!!", 10, 13, 0  ; \n\r

times 510 - ($ - $$) db 0

; 魔数，表示有效的主引导分区，小端字节序，第510字节为0x55，511字节为0xaa
dw 0xaa55
