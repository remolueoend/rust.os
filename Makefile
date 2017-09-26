arch ?= x86_64
kernel := build/kernel-$(arch).bin
iso := build/rust.os-$(arch).iso

linker_script := src/$(arch)/linker.ld
grub_cfg := src/$(arch)/grub.cfg
assembly_src_files := $(wildcard src/$(arch)/*.asm)
assembly_obj_files := $(patsubst src/$(arch)/%.asm, \
	build/arch/$(arch)/%.o, $(assembly_src_files))

.PHONY: all clean run iso

clean:
	@rm -r build

kernel: $(kernel)

run: $(iso)
	@qemu-system-x86_64 -cdrom $(iso)

iso: $(iso)

$(iso): $(kernel) $(grub_cfg)
	@mkdir -p build/isofiles/boot/grub
	@cp $(kernel) build/isofiles/boot/kernel.bin
	@cp $(grub_cfg) build/isofiles/boot/grub
	@grub-mkrescue -o $(iso) build/isofiles
	@rm -r build/isofiles

$(kernel): $(assembly_obj_files) $(linker_script)
	@ld -n -T $(linker_script) -o $(kernel) $(assembly_obj_files)

build/arch/$(arch)/%.o: src/$(arch)/%.asm
	@mkdir -p $(shell dirname $@)
	@nasm -f elf64 $< -o $@