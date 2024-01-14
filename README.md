# 

#### 









### You are here

![Overview](overview.dot.svg)





## Add

### Add as an individual component

Use [mulle-sde](//github.com/mulle-sde) to add  to your project:

``` sh
mulle-sde add :/
```

To only add the sources of  with dependency
sources use [clib](https://github.com/clibs/clib):


``` sh
clib install --out src/ /
```

Add `-isystem src/` to your `CFLAGS` and compile all the sources that were downloaded with your project.


## Install

### Install with mulle-sde

Use [mulle-sde](//github.com/mulle-sde) to build and install :

``` sh
mulle-sde install --prefix /usr/local \
   https://github.com///archive/latest.tar.gz
```

### Manual Installation


Download the latest [tar](https://github.com///archive/refs/tags/latest.tar.gz) or [zip](https://github.com///archive/refs/tags/latest.zip) archive and unpack it.

Install **** into `/usr/local` with [cmake](https://cmake.org):

``` sh
cmake -B build \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DCMAKE_PREFIX_PATH=/usr/local \
      -DCMAKE_BUILD_TYPE=Release &&
cmake --build build --config Release &&
cmake --install build --config Release
```


## Author

[Nat!](https://mulle-kybernetik.com/weblog) for Mulle kybernetiK  



