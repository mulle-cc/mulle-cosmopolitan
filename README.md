# mulle-cosmopolitan

To test build use `mulle-sde craft craftorder -- --sdk cosmopolitan`


#### ⛺ mulle-cosmopolitan support for mulle-c

mulle-cosmopolitan builds the libc of [cosmopolitan](https://github.com/jart/cosmopolitan)
and provides custom compilers **mulle-gcc.cosmopolitan** and **mulle-clang.cosmopolitan**
to build projects that link against this libc. Such executables are supposed to
be OS independent as long as the platform runs on intel compatible processors.

Other system headers will not be available!

Outside of a mulle-sde environment, you may need to define the environment
variable `DEPENDENCY_DIR` that is the root of your `cosmopolitan` installation.
If `DEPENDENCY_DIR` is not defined, the compiler will then look for
`${MULLE_VIRTUAL_ROOT}/dependency`. If that directory is missing or
`MULLE_VIRTUAL_ROOT` is undefined, the compiler will use its grand-parent
directory as a fallback. (e.g. `/usr/local/bin/mulle-gcc.cosmopolitan`
will use `/usr/local` as `DEPENDENCY_DIR`)

> #### Note
>
> Does not work with the mulle-clang compiler (sometimes) for unknown reasons.
> Everything builds but the executable errors with an alignment error:
> `APE phdrs must be 4096-aligned and 4096-padded`

## Add mulle-cosmopolitan to your mulle-sde project

Add `mulle-cosmopolitan-cc` and `mulle-cosmopolitan` as dependencies. It is
intended that you set `cosmopolitan` as your `MULLE_CRAFT_SDKS` environment variable:

``` sh
mulle-sde dependency add --marks no-header,no-link,only-craft-sdk-cosmopolitan --github mulle-cc mulle-cosmopolitan
mulle-sde dependency add --marks no-header,no-link,only-craft-sdk-cosmopolitan --github mulle-cc mulle-cosmopolitan-cc
mulle-sde dependency move mulle-cosmopolitan-cc top
mulle-sde dependency move mulle-cosmopolitan top
mulle-sde env --global set --append MULLE_CRAFT_SDKS cosmopolitan
```

## Dependency setup

The file structure of the `DEPENDENCY_DIR` as create by **mulle-cosmopolitan**
is slightly non-standard for a *cosmopolitan* build and will look like this:

```
├── include
│   ├── alloca.h
.....
│   ├── cosmopolitan
│   │   └── cosmopolitan.h
│   ├── ctype.h
.....
│   ├── netinet
│   │   ├── in.h
.........
│   │   └── udp.h
.....
│   ├── sys
│   │   ├── dir.h
........
│   │   └── wait.h
.....
│   └── wctype.h
├── lib
│   ├── ape.lds
│   ├── ape-no-modify-self.o
│   ├── cosmopolitan.a
│   ├── crt.o
│   ├── libdl.a
│   ├── libm.a
│   └── libpthread.a
```

Each header except `<cosmopolitan/cosmopolitan.h>` contains only these three
lines:

``` c
#ifndef COSMOPOLITAN_H_
# include <cosmopolitan/cosmopolitan.h>
#endif
```

The `lib<name>.a` libraries are just empty shells, so the linker finds
something.


## Author

[Nat!](//www.mulle-kybernetik.com/weblog) for
[Mulle kybernetiK](//www.mulle-kybernetik.com)
