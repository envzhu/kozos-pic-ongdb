FROM ubuntu:18.04

# Install required apt packages
RUN DEBIAN_FRONTEND=noninteractive apt update \
    && apt install -y --no-install-recommends \
          git ca-certificates \
          build-essential texinfo bison flex \
    && rm -rf /var/lib/apt/lists/*

# Build and install GDB for MIPS
ARG GDB_REPO=https://github.com/envzhu/gdb4kozos-pic.git
RUN git clone --depth=1 ${GDB_REPO} gdb \
    && mkdir build && cd build \
    && ../gdb/configure --target=mipsisa32r2-elf --disable-nls \
    && make -j$(nproc) \
    && make install \
    && cd .. \
    && rm -rf ./build ./gdb
