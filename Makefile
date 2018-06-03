ARCH = mips-elf
ADDNAME = $(ARCH)-

AR      = $(ADDNAME)ar
AS      = $(ADDNAME)as
CC      = $(ADDNAME)gcc
LD      = $(ADDNAME)ld
NM      = $(ADDNAME)nm
OBJCOPY = $(ADDNAME)objcopy
OBJDUMP = $(ADDNAME)objdump
RANLIB  = $(ADDNAME)ranlib
STRIP   = $(ADDNAME)strip
BIN2HEX = $(ADDNAME)bin2hex

GDB			= mipsisa32r2-elf-gdb
RUN			= mipsisa32r2-elf-run

OBJS  = startup.o main.o interrupt.o vector.o intr.o
OBJS += lib.o 

# hardware-dependent sources
OBJS += hardware.o serial.o timer.o sim-io.o

# sources of kozos
OBJS += kozos.o syscall.o memory.o consdrv.o tmrdrv.o command.o

TARGET = kozos

CFLAGS = -Wall -march=m4k -EL -nostdinc -nostdlib -fno-builtin
CFLAGS += -I. 
CFLAGS += -G0 #これをしないとエラーが出る
CFLAGS += -Os
CFLAGS += -DKOZOS -DDEBUG 

# cflags for GDB sim
CFLAGS += -DSIMULATOR
CFLAGS += -g

LFLAGS = -static -T ld.scr -L.

.SUFFIXES: .c .o
.SUFFIXES: .s .o
.SUFFIXES: .S .o

all :		$(TARGET) $(TARGET).hex

$(TARGET) :	$(OBJS) Makefile ld.scr
		$(CC) $(OBJS) -o $(TARGET) $(CFLAGS) $(LFLAGS)
		cp $(TARGET) $(TARGET).elf
		$(STRIP) $(TARGET)

.c.o :		$<
		$(CC) -c $(CFLAGS) $<

.s.o :		$<
		$(CC) -c $(CFLAGS) $<

.S.o :		$<
		$(CC) -c $(CFLAGS) $<

$(TARGET).hex :	$(TARGET)
		$(OBJCOPY) -O ihex $(TARGET) $(TARGET).hex

image :		$(TARGET).hex

obj_clean :
		rm -f $(OBJS)

clean :
		rm -f $(OBJS) $(TARGET) $(TARGET).elf $(TARGET).hex

line :
		wc -l *.c *.h *.s *.S ld.scr Makefile

sim : $(TARGET)
		$(GDB) $(TARGET).elf
run : $(TARGET)
		$(RUN) $(TARGET).elf
