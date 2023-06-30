#!/usr/bin/env bash

INPUTS=("$@")
INPUT_LENGTH=${#INPUTS[@]}

EXTRA_COLORS=$((INPUT_LENGTH / 5))
COLORS=($(pastel distinct $((INPUT_LENGTH + (EXTRA_COLORS * 3) + 1)) --metric CIEDE2000 | pastel sort-by brightness | pastel format hex | head -n $((INPUT_LENGTH + (EXTRA_COLORS * 1))) | tail -n $INPUT_LENGTH))
COLOR_ID=0

# min_max_cpp_clang_size,C++ clang,size,C++ clang -Os,#3454D1
# min_max_cpp_clang_speed,C++ clang,speed,C++ clang -O3,#7A8FE1
# min_max_cpp_gcc_size,C++ gcc,size,C++ gcc -Os,#34D1BF
# min_max_cpp_gcc_speed,C++ gcc,speed,C++ gcc -O3,#7AE1D5
# min_max_rust_size,Rust,size,Rust -Os,#C1292E
# min_max_rust_speed,Rust,speed,Rust -O3,#E2787C
# min_max_rust_idiomatic_size,Idiomatic Rust,size,Idiomatic Rust -Os,#F65D00
# min_max_rust_idiomatic_speed,Idiomatic Rust,speed,Idiomatic Rust -O3,#FF9A5C
function get_color() {
    shopt -s extglob
    NAME="$1"
    case "$NAME" in
    *"_clang_size")
        echo "#3454D1"
        ;;
    *"_clang_speed")
        echo "#7A8FE1"
        ;;
    *"_gcc_size")
        echo "#34D1BF"
        ;;
    *"_gcc_speed")
        echo "#7AE1D5"
        ;;
    *"_rust_size")
        echo "#C1292E"
        ;;
    *"_rust_speed")
        echo "#E2787C"
        ;;
    *"_idiom_size")
        echo "#F65D00"
        ;;
    *"_idiom_speed")
        echo "#FF9A5C"
        ;;
    *)
        echo "#000000"
        ;;
    esac
}

function process_name() {
    NAME="$1"
    OIFS=$IFS
    IFS='_'
    read -a parts <<<"$NAME"
    IFS=$OIFS

    COMPILER=Rust
    COMPILER_COMMAND=rust
    OPTIMIZATION=_marker_
    OPTIMIZATION_FLAG=_marker_
    SETUP=_marker_
    LANGUAGE=Rust
    IDIOMATIC=false
    COLOR=$(get_color "$NAME")
    CRATES=false
    # COLOR=${COLORS[$COLOR_ID]}
    # COLOR_ID=$((COLOR_ID + 1))

    # id,Compiler,Optimized for,Setup,color
    # min_max_cpp_clang_size,C++ clang,size,C++ clang -Os,#3454D1
    # min_max_cpp_clang_speed,C++ clang,speed,C++ clang -O3,#7A8FE1
    # min_max_cpp_gcc_size,C++ gcc,size,C++ gcc -Os,#34D1BF
    # min_max_cpp_gcc_speed,C++ gcc,speed,C++ gcc -O3,#7AE1D5
    # min_max_rust_size,Rust,size,Rust -Os,#C1292E
    # min_max_rust_speed,Rust,speed,Rust -O3,#E2787C
    # min_max_rust_idiomatic_size,Idiomatic Rust,size,Idiomatic Rust -Os,#F65D00
    # min_max_rust_idiomatic_speed,Idiomatic Rust,speed,Idiomatic Rust -O3,#FF9A5C
    FUNCTION=${parts[0]}

    for part in ${parts[@]}; do
        if test "$part" = "gcc"; then
            COMPILER=GCC
            LANGUAGE=C++
            COMPILER_COMMAND=gcc
        fi
        if test "$part" = "clang"; then
            COMPILER=Clang
            LANGUAGE=C++
            COMPILER_COMMAND=clang
        fi
        if test "$part" = "rust"; then
            LANGUAGE=Rust
            COMPILER=Rust
            COMPILER_COMMAND=rust
        fi
        if test "$part" = "idiom"; then
            IDIOMATIC=true
        fi
        if test "$part" = "crates"; then
            CRATES=true
        fi
        if test "$part" = "speed"; then
            OPTIMIZATION=speed
            OPTIMIZATION_FLAG=-O3
        fi
        if test "$part" = "size"; then
            OPTIMIZATION=size
            OPTIMIZATION_FLAG=-Os
        fi
    done

    # Identifies the compiler and configuration
    COMPILER_SETUP="$COMPILER_COMMAND $OPTIMIZATION_FLAG"

    IDIOMATIC_STRING=""
    if $IDIOMATIC; then
        IDIOMATIC_STRING="Idiomatic "
    fi
    if $CRATES; then
        IDIOMATIC_STRING="crates.io "
    fi

    # Identifies the source file
    IMPLEMENTATION="$IDIOMATIC_STRING$LANGUAGE"

    SETUP_SECOND_STRING=" $COMPILER_COMMAND"
    if test "$LANGUAGE" = "Rust"; then
        if test "$COMPILER_COMMAND" = "rust"; then
            SETUP_SECOND_STRING=""
        fi
    fi
    # Identifies the source file and tool used
    SCENARIO="$IMPLEMENTATION$SETUP_SECOND_STRING"

    # Identifies the source file, tool and configuration used
    SETUP="$IMPLEMENTATION$SETUP_SECOND_STRING $OPTIMIZATION_FLAG"

    # id,Compiler,Optimized for,Setup,color
    # min_max_cpp_clang_size,C++ clang,size,C++ clang -Os,#3454D1
    # min_max_cpp_clang_speed,C++ clang,speed,C++ clang -O3,#7A8FE1
    # min_max_cpp_gcc_size,C++ gcc,size,C++ gcc -Os,#34D1BF
    # min_max_cpp_gcc_speed,C++ gcc,speed,C++ gcc -O3,#7AE1D5
    # min_max_rust_size,Rust,size,Rust -Os,#C1292E
    # min_max_rust_speed,Rust,speed,Rust -O3,#E2787C
    # min_max_rust_idiomatic_size,Idiomatic Rust,size,Idiomatic Rust -Os,#F65D00
    # min_max_rust_idiomatic_speed,Idiomatic Rust,speed,Idiomatic Rust -O3,#FF9A5C
    FUNCTION=${parts[0]}

    echo "{
    \"id\": \"$NAME\",
    \"Setup\": \"$SETUP\",
    \"Scenario\": \"$SCENARIO\",
    \"compilerSetup\": \"$COMPILER_SETUP\",
    \"Implementation\": \"$IMPLEMENTATION\",
    \"Function\": \"$FUNCTION\",
    \"Compiler\": \"$COMPILER\",
    \"Optimized for\": \"$OPTIMIZATION\",
    \"Optimization flag\": \"$OPTIMIZATION_FLAG\",
    \"Language\": \"$LANGUAGE\",
    \"Idiomatic\": \"$IDIOMATIC\",
    \"From crates.io\": \"$CRATES\",
    \"color\": \"$COLOR\"
    }"
}

function main {

    echo "{"
    COMMA=""
    for input in "${INPUTS[@]}"; do
        echo $COMMA "\"$input\": "
        COMMA=","
        process_name $input
    done
    echo "}"

}

main | jq
# get_color $1
