# Rust OS

Follwoing along with [@phil-opp][2]'s blog post series ["A minimal x86 kernel"][1].

[1]: https://os.phil-opp.com
[2]: https://github.com/phil-opp

## Prerequisites OSX
* use `git clone --recursive git@github.com:remolueoend/rust.os.git` to clone GRUB and objconv too under `/tools`
* Install cross-compile binutils: https://os.phil-opp.com/cross-compile-binutils/
* compile objconv under /tools/objconv: `g++ -o objconv -O2 src/*.cpp`
* install autoreconf for building GRUB: `brew install automake`
* compile GRUB under /tools/grub, see http://wiki.osdev.org/GRUB_2#Installing_GRUB_2_on_OS_X and https://github.com/phil-opp/blog_os/issues/55#issuecomment-159995128