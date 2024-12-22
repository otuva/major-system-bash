DICTIONARY_FILE="words.txt"

digit_map=(
    [0]="sz"
    [1]="td"
    [2]="n"
    [3]="m"
    [4]="r"
    [5]="l"
    [6]="jş(sh)ç(ch)"
    [7]="k"
    [8]="fv"
    [9]="pb"
)

for digit in {0..9}; do valid_letters+="${digit_map[$digit]}" 
done

generate_regex() {
    local input="$1"
    local regex=""

    regex+="^[^$valid_letters]*"
    for ((i = 0; i < ${#input}; i++)); do
        local digit="${input:i:1}"
        regex+="[${digit_map[$digit]}][^$valid_letters]*"
    done
    regex+="$"

    echo "$regex"
}

generate_word() {
    local number="$1"
    local regex=$(generate_regex "$number")
    grep -E "$regex" "$DICTIONARY_FILE"
}

if [[ $1 -eq "" ]]; then
    echo "Usage: $0 <number> [start,end]"
    exit 1
fi

if [[ $2 -eq "" ]]; then
    generate_word "$1"
else
    len_str=$(echo $2 | cut -d "," -f 1)
    len_end=$(echo $2 | cut -d "," -f 2)
    generate_word "$1" | grep -xE ".{$len_str,$len_end}" | awk '{ print length($0) " " $0; }' | sort -r -n | cut -d ' ' -f 2-
fi
