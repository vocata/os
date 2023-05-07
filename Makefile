boot.img: boot.bin
	dd if=/dev/zero of=boot.img bs=512 count=2880		# floppy 1.44M
	# yes | bximage -q -fd=1.44M -func=create -sectsize=512 -imgmode=flat boot.img
	dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc

boot.bin: boot.asm
	nasm -f bin -o boot.bin boot.asm

.PHONY: bochs qemu clean

bochs: boot.img
	bochs -f bochsrc -q

qemu: boot.img
	qemu-system-i386 boot.img

clean:
	rm -rf *.o *.out *.bin *.img
