#!/bin/bash
set -e

# Function to display help
show_help() {
    cat << EOF
webera/md2pdf - Convert Markdown to PDF with professional templates

Usage:
    docker run -v \$(pwd):/data webera/md2pdf [OPTIONS] input.md [output.pdf]

Options:
    --help              Show this help message
    --list-templates    List available templates

Environment Variables:
    TEMPLATE            Template name (default: default)
    PAPER_SIZE          Paper size: a4 or letter (default: letter)
    MARGIN              Page margins (default: 1in)
    FONT_SIZE           Base font size (default: 11pt)
    COMPANY             Company name for templates
    AUTHOR              Document author
    DATE                Document date (default: today)
    LOGO_PATH           Path to company logo image
    CUSTOM_TEMPLATE     Path to custom template file

Available Templates:
    default             Clean, professional layout
    business-letter     Professional business letter
    business-report     Multi-page business report
    legal-contract      Legal document format
    invoice             Invoice with tables

Examples:
    # Basic conversion
    docker run -v \$(pwd):/data webera/md2pdf document.md

    # Use business letter template
    docker run -v \$(pwd):/data -e TEMPLATE=business-letter webera/md2pdf letter.md

    # With custom variables
    docker run -v \$(pwd):/data \\
        -e TEMPLATE=invoice \\
        -e COMPANY="Webera Inc." \\
        -e AUTHOR="John Doe" \\
        webera/md2pdf invoice.md
EOF
    exit 0
}

# Function to list templates
list_templates() {
    echo "Available templates:"
    for template in /opt/md2pdf/templates/*.latex; do
        basename "$template" .latex | sed 's/^/  - /'
    done
    exit 0
}

# Parse command line arguments
if [ "$1" == "--help" ] || [ "$1" == "-h" ] || [ $# -eq 0 ]; then
    show_help
fi

if [ "$1" == "--list-templates" ]; then
    list_templates
fi

# Get input and output files
INPUT_FILE="$1"
OUTPUT_FILE="${2:-${INPUT_FILE%.md}.pdf}"

# Validate input file
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found" >&2
    exit 1
fi

# Determine template path
TEMPLATE_DIR="/opt/md2pdf/templates"
if [ -n "$CUSTOM_TEMPLATE" ] && [ -f "$CUSTOM_TEMPLATE" ]; then
    TEMPLATE_PATH="$CUSTOM_TEMPLATE"
    echo "Using custom template: $CUSTOM_TEMPLATE"
else
    TEMPLATE_PATH="${TEMPLATE_DIR}/${TEMPLATE}.latex"
    if [ ! -f "$TEMPLATE_PATH" ]; then
        echo "Error: Template '${TEMPLATE}' not found" >&2
        echo "Available templates:" >&2
        ls -1 "${TEMPLATE_DIR}" | sed 's/\.latex$//' | sed 's/^/  - /' >&2
        exit 1
    fi
    echo "Using template: ${TEMPLATE}"
fi

# Build Pandoc command
PANDOC_CMD="pandoc"
PANDOC_ARGS=(
    "$INPUT_FILE"
    -o "$OUTPUT_FILE"
    --pdf-engine=xelatex
    --template="$TEMPLATE_PATH"
    --highlight-style=kate
    --variable="geometry:margin=${MARGIN}"
    --variable="fontsize:${FONT_SIZE}"
    --variable="papersize:${PAPER_SIZE}"
    --variable="colorlinks:true"
    --variable="linkcolor:blue"
    --variable="urlcolor:blue"
    --variable="toccolor:black"
)

# Add optional variables if set
[ -n "$COMPANY" ] && PANDOC_ARGS+=("--variable=company:${COMPANY}")
[ -n "$AUTHOR" ] && PANDOC_ARGS+=("--variable=author:${AUTHOR}")
[ -n "$DATE" ] && PANDOC_ARGS+=("--variable=date:${DATE}")
[ -n "$LOGO_PATH" ] && [ -f "$LOGO_PATH" ] && PANDOC_ARGS+=("--variable=logo:${LOGO_PATH}")

# Add custom Pandoc arguments if provided
[ -n "$PANDOC_EXTRA_ARGS" ] && PANDOC_ARGS+=($PANDOC_EXTRA_ARGS)

# Execute Pandoc
echo "Converting ${INPUT_FILE} to ${OUTPUT_FILE}..."
"${PANDOC_CMD}" "${PANDOC_ARGS[@]}"

if [ $? -eq 0 ]; then
    echo "Successfully created: ${OUTPUT_FILE}"
else
    echo "Error: PDF generation failed" >&2
    exit 1
fi