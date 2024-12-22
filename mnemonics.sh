DICTIONARY_FILE="dictionary.txt"

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

for digit in {0..9}; do
    valid_letters+="${digit_map[$digit]}"
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

display_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --card <value>           Perform a card-related operation with the specified value."
    echo "  --number <value>         Perform a number-related operation with the specified value."
    echo "  --gen-dictionary <lang>  Generate a dictionary for the given language code (e.g., en_US)."
    echo "  -h, --help               Display this help message."
    echo ""
    echo "Example:"
    echo "  $0 --gen-dictionary en_US"
    exit 0
}

handle_card() {
}

handle_number() {
}

handle_gen_dictionary() {
    local lang="$1"
    local dic_file="/usr/share/hunspell/${lang}.dic"
    local aff_file="/usr/share/hunspell/${lang}.aff"
    local output_file=$DICTIONARY_FILE

    # Check if unmunch and hunspell files exist
    if ! command -v unmunch &>/dev/null; then
        echo "Error: unmunch command not found. Install it with:"
        echo "  sudo apt install hunspell"
        exit 1
    fi

    if [[ ! -f "$dic_file" || ! -f "$aff_file" ]]; then
        echo "Error: Dictionary files for '$lang' not found. Install them with:"
        echo "  sudo apt install hunspell-<LANGUAGE>"
        exit 1
    fi

    # Generate the dictionary
    echo "Generating dictionary for language '$lang'..."
    unmunch "$dic_file" "$aff_file" >> "$output_file"
    echo "Dictionary saved to: $output_file"
}

if [[ "$#" -eq 0 ]]; then
    display_help
fi

while [[ "$#" -gt 0 ]]; do
    case $1 in
    --card)
        if [[ -n "$2" && "$2" != --* ]]; then
            handle_card "$2"
            shift
        else
            echo "Error: --card requires a parameter."
            exit 1
        fi
        ;;
    --number)
        if [[ -n "$2" && "$2" != --* ]]; then
            handle_number "$2"
            shift
        else
            echo "Error: --number requires a parameter."
            exit 1
        fi
        ;;
    --gen-dictionary)
        if [[ -n "$2" && "$2" != --* ]]; then
            handle_gen_dictionary "$2"
            shift
        else
            echo "Error: --gen-dictionary requires a language code parameter (e.g., en_US)."
            exit 1
        fi
        ;;
    -h | --help)
        display_help
        ;;
    *)
        echo "Unknown argument: $1"
        display_help
        ;;
    esac
    shift
done
