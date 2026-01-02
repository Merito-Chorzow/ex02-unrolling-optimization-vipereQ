TOOL=arm-none-eabi

BASEFLAGS=-mcpu=cortex-m3 -mthumb -g -ffreestanding
LDFLAGS=-T boards/qemu-mps2/linker.ld -Wl,--gc-sections -nostartfiles --specs=rdimon.specs -lc -lrdimon

SRC=$(wildcard src/*.c) $(wildcard asm/*.S) boards/qemu-mps2/startup.S
OUT=build/firmware.elf

O0: CFLAGS=$(BASEFLAGS) -O0
O2: CFLAGS=$(BASEFLAGS) -O2
O3: CFLAGS=$(BASEFLAGS) -O3

O0 O2 O3:
	cmd /C if not exist build mkdir build
	$(TOOL)-gcc $(CFLAGS) $(LDFLAGS) -o $(OUT) $(SRC)

size:
	$(TOOL)-size $(OUT)

clean:
	cmd /C del /Q $(OUT) 2>NUL || exit 0


