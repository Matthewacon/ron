# ron
I'm sure this is exactly the use-case IBM had in mind when they invented the PC standard

## Who is Ron?
Scientists have not yet been able to answer this question.

## Building
### System requirements
 - CMake 3.19+
 - A C++20 compatible compiler, ideally GCC or Clang
 - GNU AS

### Supported targets
Ron's architecture: x86 (i386-pc-none)

### Building
**Note**: Does not support in-source builds.

```sh
mkdir build
cd build
env CC=c_compiler CXX=cxx_compiler cmake .. -GNinja
ninja -j0
```

## License
This project is licensed under [The Unlicense](./LICENSE).
