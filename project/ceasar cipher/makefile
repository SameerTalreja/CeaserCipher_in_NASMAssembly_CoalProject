caesar: cs.o
	ld -m elf_i386 cs.o -o caesar

cs.o: cs.asm
	nasm -f elf32 cs.asm -o cs.o

clean:
	rm -f *.o caesar

