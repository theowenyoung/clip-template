#!/bin/bash
set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
BIN_DIR="$SCRIPT_DIR/../bin"
mkdir -p $BIN_DIR
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    cd -- /tmp
    curl -OL https://github.com/theowenyoung/mdbook-epub/releases/download/v0.4.2103/mdbook-epub-x86_64-unknown-linux-musl.tar.gz
    tar -xf /tmp/mdbook-epub-x86_64-unknown-linux-musl.tar.gz -C $BIN_DIR
    curl -OL https://github.com/rust-lang/mdBook/releases/download/v0.4.22/mdbook-v0.4.22-x86_64-unknown-linux-musl.tar.gz
    tar -xf /tmp/mdbook-v0.4.22-x86_64-unknown-linux-musl.tar.gz -C $BIN_DIR
    curl -OL https://github.com/denoland/deno/releases/download/v1.28.3/deno-x86_64-unknown-linux-gnu.zip
    unzip -o /tmp/deno-x86_64-unknown-linux-gnu.zip -d $BIN_DIR

elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    cd -- /tmp/
    curl -OL https://github.com/theowenyoung/mdbook-epub/releases/download/v0.4.2103/mdbook-epub-x86_64-apple-darwin.zip
    unzip -o /tmp/mdbook-epub-x86_64-apple-darwin.zip -d $BIN_DIR
    curl -OL https://github.com/rust-lang/mdBook/releases/download/v0.4.22/mdbook-v0.4.22-x86_64-apple-darwin.tar.gz
    tar -xf /tmp/mdbook-v0.4.22-x86_64-apple-darwin.tar.gz -C $BIN_DIR
    curl -OL https://github.com/denoland/deno/releases/download/v1.28.3/deno-x86_64-apple-darwin.zip
    unzip -o /tmp/deno-x86_64-apple-darwin.zip -d $BIN_DIR
else
    # not support
    echo "not support this platform"
fi

chmod +x $BIN_DIR/*

echo Install Success.

echo Run \`make serve\` to preview the book.

echo Run \`make build\` to build the book.
