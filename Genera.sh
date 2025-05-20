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
    'if false; then mv fi'
)

generate_inutile_funzione_inline() {
    local name="${fun_names[$RANDOM % ${#fun_names[@]}]}"
    local op="${ops[$RANDOM % ${#ops[@]}]}"
    echo "$name() { $op; }"
}

for i in $(seq 1 8); do
    file_name="$(pad_number "$i").sh"

    {
        echo '#!/bin/bash'

        # BLOCCO 1 - PARTE ALTA: 3 funzioni in 3 punti distinti
        echo NumFiles=$NumFiles
        echo "$(generate_inutile_funzione_inline)"
        echo
        echo 'trimmed=$(echo "$0" | cut -c3-)'
        echo 'echo "SONO IL FILE: $trimmed"'
        echo
        echo "$(generate_inutile_funzione_inline)"
        echo 'initSetup() { exit 0; }'
        echo "$(generate_inutile_funzione_inline)"
        echo
        echo 'pad() {'
        echo '        local n="$1"'
        echo '        local w="${#NumFiles}"'
        echo '        printf "%0${w}s" "$n" | tr " " "0"'
        echo "        $(generate_inutile_funzione_inline)"
        echo "        $(generate_inutile_funzione_inline)"
        echo '    }'
        # BLOCCO 2 - Dentro process_file: 7 funzioni mischiate
        echo 'process_file() {'
        echo '    for _ in $(seq 1 10); do'
        echo "        $(generate_inutile_funzione_inline)"
        echo '        n=$((1 + RANDOM % \$NumFiles))'
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

        # BLOCCO 3 - Parte finale: 5 funzioni mischiate + funzione final_exit con exit 0
        # Genero 5 funzioni inutili e raccolgo i loro nomi
        #echo "# definizione funzioni camouflage"
        position=$((1 + RANDOM % 5))
        declare -a _fnames=()
        for _j in {1..5}; do
            fn_def="$(generate_inutile_funzione_inline)"
            echo "$fn_def"
            _fnames+=("${fn_def%%(*}")

            # Ad esempio: alla terza funzione definita, loggo un commento o modifico qualcosa
            if [[ $_j -eq $position ]]; then
                echo 'initSetup'
            fi
        done

        echo 'process_file'
        # Chiamo 3 funzioni scelte a caso fra quelle definite sopra
        #echo "# chiamate camouflage"
        for _k in {1..3}; do
            # estraggo indice casuale da 0 a len-1
            idx=$(( RANDOM % ${#_fnames[@]} ))
            echo "${_fnames[$idx]}"
        done
        echo
    } > "$file_name"

    chmod u+x "$file_name"
done
