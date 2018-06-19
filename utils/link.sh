#!/bin/bash

cd "$(dirname "$0")/.."

[[ ! -d libs ]] && mkdir -p libs
[[ ! -L libs/LibStub ]] && ln -s ../LibStub libs/LibStub
[[ ! -L libs/CallbackHandler-1.0 ]] && ln -s ../CallbackHandler-1.0 libs/CallbackHandler-1.0
[[ ! -L libs/LibResInfo-1.0 ]] && ln -s ../LibResInfo-1.0 libs/LibResInfo-1.0
