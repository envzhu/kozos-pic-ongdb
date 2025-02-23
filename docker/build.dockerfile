FROM ubuntu:24.04

# Install required apt packages
RUN DEBIAN_FRONTEND=noninteractive apt update \
    && apt install -y --no-install-recommends \
          build-essential curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Build and install binutils for MIPS
ARG BINUTILS_URL=https://ftp.gnu.org/gnu/binutils/binutils-2.44.tar.xz
RUN curl -L ${BINUTILS_URL} -o binutils.tar.xz \
    && tar -xf binutils.tar.xz \
    && mkdir build && cd build \
    && ./binutils*/configure --target=mips-elf \
    && make -j$(nproc) \
    && make install \
    && cd .. \
    && rm -rf build binutils

# Build and install GCC for MIPS
ARG GCC_URL=https://ftp.gnu.org/gnu/gcc/gcc-7.2.0/gcc-7.2.0.tar.xz
RUN curl -L ${GCC_URL} -o gcc.tar.xz \
    && tar -xf gcc.tar.xz \
    && mkdir build && cd build \
    && .,/gcc*/contrib/download_prerequisites \
    && ../gcc*/configure --target=mips-elf \
          --disable-nls --disable-threads --disable-shared --enable-languages=c --disable-bootstrap --disable-libssp \
    && make -j30 \
    && make install \
    && cd .. \
    && rm -rf build gcc*
