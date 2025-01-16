FROM ubuntu:24.04
WORKDIR /app
RUN apt-get update && apt-get install -y \
    git \
    make \
    cmake \
    clang \
    libssl-dev \
    libbz2-dev \
    build-essential \
    default-libmysqlclient-dev \
    libace-dev \
    cargo \
    && rm -rf /var/lib/apt/lists/*
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang 100
COPY ./patches/ /app/patches
RUN git clone --recurse-submodules https://github.com/mangoszero/server.git \
    && cd server \
    && git apply /app/patches/*.patch \
    && mkdir _build _install \
    && cd _build \
    && cmake .. -DCMAKE_INSTALL_PREFIX=/app/server/_install \
                -DBUILD_TOOLS=1 \
                -DBUILD_MANGOSD=1 \
                -DBUILD_REALMD=1 \
                -DSOAP=1 \
                -DSCRIPT_LIB_ELUNA=0 \
                -DSCRIPT_LIB_SD3=1 \
                -DPLAYERBOTS=1 \
                -DUSE_STORMLIB=1 \
    && make -j$(nproc) \
    && make install \
    && cp /app/server/_install/bin/tools/* /usr/local/bin/ \
    && cp /app/server/_install/bin/mangosd /usr/local/bin \
    && cp /app/server/_install/bin/realmd /usr/local/bin \
    && rm -rf /app
WORKDIR /
