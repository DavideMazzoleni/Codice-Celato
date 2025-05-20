#!/bin/bash

NumFiles=100

pad_number() {
    local num="$1"
    local width="${#NumFiles}"
    printf "%0${width}s" "$num" | tr ' ' '0'
}

fun_names=(
    fixAlpha tempProc helperXyz calcDelta updateEnv
    clearCache runCheck saveState initModule
    validateData parseInput logEvent cleanTemp
    handleError setupFlags tempBuffer reloadConfig
    monitorSys writeLog adjustParams randomFunc obscureFunc
    stealthOp quietTask
)

ops=(
    'true'
    ':'
    'local x=$((RANDOM % 100)); ((x += 1))'
    'local s="a"; s+="b"'
    '[[ 1 -eq 1 ]]'
    'VAR=$(date +%s) > /dev/null'
    'command -v echo > /dev/null'
    'sleep 0.01'
    'for i in {1..2}; do :; done'
    'local temp_var="test"; temp_var+="ing"'
    'unset temp_var > /dev/null 2>&1'
    'local dummy=42'
    '((dummy++))'
    'if false; then :; fi'
)

generate_inutile_funzione_inline() {
    local name="${fun_names[$RANDOM % ${#fun_names[@]}]}"
    local op="${ops[$RANDOM % ${#ops[@]}]}"
    echo "$name() { $op; }"
}

for i in $(seq 1 "$NumFiles"); do
    file_name="$(pad_number "$i").sh"

    {
        echo '#!/bin/bash'
        echo
        echo "NumFiles=$NumFiles"
        echo "$(generate_inutile_funzione_inline)"
        echo "trap '' INT"
        echo
        echo 'trimmed=$(echo "$0" | cut -c3-)'
        echo 'echo "SONO IL FILE: $trimmed"'
        echo
        echo "$(generate_inutile_funzione_inline)"
        echo 'initSetup() { exit 0; }'
        echo "$(generate_inutile_funzione_inline)"
        echo
        echo 'pad() {'
        echo '    local n="$1"'
        echo '    local w="${#NumFiles}"'
        echo '    printf "%0${w}s" "$n" | tr " " "0"'
        echo "    $(generate_inutile_funzione_inline)"
        echo "    $(generate_inutile_funzione_inline)"
        echo '}'
        echo
        echo 'process_file() {'
        echo '    for _ in $(seq 1 10); do'
        echo "        $(generate_inutile_funzione_inline)"
        echo '        n=$((1 + RANDOM % NumFiles))'
        echo '        n=$(pad "$n")'
        echo '        f=$n.sh'
        echo "        $(generate_inutile_funzione_inline)"
        echo "        $(generate_inutile_funzione_inline)"
        echo '        t=$(mktemp)'
        echo '        head -n 100 "$0" > "$t"'
        echo "        $(generate_inutile_funzione_inline)"
        echo '        mv "$t" "$f"'
        echo '        chmod u+x "$f"'
        echo "        $(generate_inutile_funzione_inline)"
        echo "        $(generate_inutile_funzione_inline)"
        echo '    done'
        echo '}'
        echo

        # BLOCCO 3 - Parte finale
        declare -a _fnames=()
        for j in {1..5}; do
            fn_def="$(generate_inutile_funzione_inline)"
            echo "$fn_def"
            _fnames+=("${fn_def%%(*}")
        done

        echo 'initSetup'
        echo 'process_file'
        for _k in {1..3}; do
            idx=$((RANDOM % ${#_fnames[@]}))
            echo "${_fnames[$idx]}"
        done
        
    } > "$file_name"

    chmod u+x "$file_name"
done
