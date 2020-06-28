// disable standard library for our own OS:
#![no_std]
#![no_main]

use core::panic::PanicInfo;

/// This function is called on panic:
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

// static string byte array containing our message to the world:
static HELLO: &[u8] = b"!!!! Hello World !!!!";

#[no_mangle]
pub extern "C" fn _start() -> ! {
    // raw pointer. We need an unsafe block to actually write to it:
    let vga_buffer = 0xb8000 as *mut u8;

    for (i, &byte) in HELLO.iter().enumerate() {
        unsafe {
            *vga_buffer.offset(i as isize * 2) = byte;
            *vga_buffer.offset(i as isize * 2 + 1) = 0xb;
        }
    }

    loop {}
}
