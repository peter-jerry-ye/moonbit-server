# Build stage
FROM --platform=linux/amd64 alpine AS wasm-tools
ADD https://github.com/bytecodealliance/wasm-tools/releases/download/v1.201.0/wasm-tools-1.201.0-x86_64-linux.tar.gz /app/wasm-tools.tar.gz
RUN tar -xzf /app/wasm-tools.tar.gz -C /app --strip-components 1 && rm /app/wasm-tools.tar.gz

FROM --platform=linux/amd64 alpine AS wasmedge
ADD https://github.com/WasmEdge/WasmEdge/releases/download/0.14.0-rc.4/WasmEdge-0.14.0-rc.4-manylinux2014_x86_64.tar.gz /app/wasmedge.tar.gz
RUN tar -xzf /app/wasmedge.tar.gz -C /app --strip-components 1 && rm /app/wasmedge.tar.gz

FROM --platform=linux/amd64 alpine AS moon

ADD --chmod=755 https://cli.moonbitlang.com/ubuntu_x86_64_moon_setup.sh /app/moon_setup.sh
RUN apk add --no-cache bash curl
RUN /app/moon_setup.sh

FROM --platform=linux/amd64 debian:stable AS build-wat

COPY --from=moon /root/.moon /root/.moon
COPY . /app
WORKDIR /app
ENV PATH="/root/.moon/bin:${PATH}"

RUN moon bundle --source-dir /root/.moon/lib/core
RUN moon build --target wasm-gc --output-wat

FROM --platform=linux/amd64 debian:stable AS build-wasm

COPY --from=build-wat /app/target/wasm-gc/release/build/main/main.wat /root/main.wat
COPY --from=wasm-tools /app /app/wasm-tools

RUN sed -i -E 's/\(import "spectest" "print_char"\)//' /root/main.wat \
    && sed -i 's/moonbit\.memory/memory/g' /root/main.wat
RUN /app/wasm-tools/wasm-tools parse /root/main.wat -o /root/main.wasm
RUN /app/wasm-tools/wasm-tools strip /root/main.wasm -a -o /root/main.wasm

FROM --platform=linux/amd64 httpd:2.4.58-bookworm

COPY --chmod=755 main.sh /usr/local/apache2/cgi-bin/main
COPY --from=build-wasm /root/main.wasm /app/main.wasm
COPY --from=wasmedge /app/ /app/wasmedge
COPY my-httpd.conf /usr/local/apache2/conf/httpd.conf