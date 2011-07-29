#!/bin/bash

function source_if_exists {
    if [[ -e "$1" ]]; then
        source $1
    fi
}
