# webera/md2pdf

A Docker image for converting Markdown files to professional PDF documents using Pandoc with customizable LaTeX templates. Perfect for generating business documents, reports, invoices, legal contracts, and letters.

## Features

- **Multiple Professional Templates**: Business letters, reports, invoices, legal contracts, and a clean default template
- **Customizable Output**: Control paper size, margins, fonts, and styling through environment variables
- **YAML Frontmatter Support**: Define document metadata directly in your Markdown files
- **Custom Template Support**: Mount and use your own LaTeX templates
- **XeLaTeX Engine**: Better font support and modern typography
- **Syntax Highlighting**: Automatic code block highlighting for technical documents
- **Multi-platform**: Supports both AMD64 and ARM64 architectures

## Quick Start

### Basic Usage

Convert a Markdown file to PDF using the default template:

```bash
docker run -v $(pwd):/data webera/md2pdf document.md
```

### Using Different Templates

```bash
# Business letter
docker run -v $(pwd):/data -e TEMPLATE=business-letter webera/md2pdf letter.md

# Business report with table of contents
docker run -v $(pwd):/data -e TEMPLATE=business-report webera/md2pdf report.md

# Invoice
docker run -v $(pwd):/data -e TEMPLATE=invoice webera/md2pdf invoice.md

# Legal contract
docker run -v $(pwd):/data -e TEMPLATE=legal-contract webera/md2pdf contract.md
```

## Available Templates

### default
A clean, professional layout suitable for general business documents with:
- Professional typography
- Header and footer with page numbers
- Support for table of contents
- Code syntax highlighting

### business-letter
Professional business letter format featuring:
- Company letterhead area
- Sender and recipient address blocks
- Proper date and signature formatting
- Support for enclosures and CC

### business-report
Comprehensive business report template with:
- Cover page with logo placeholder
- Executive summary section
- Automatic table of contents
- Professional heading styles
- Page headers and footers

### legal-contract
Legal document format including:
- Automatic section numbering (Roman numerals)
- Proper legal formatting and indentation
- Signature blocks for multiple parties
- Witness and notary sections
- Dense text formatting

### invoice
Professional invoice template with:
- Company header section
- Bill-to and ship-to addresses
- Itemized table with calculations
- Payment terms and methods
- Customizable thank you message

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `TEMPLATE` | Template name to use | `default` |
| `PAPER_SIZE` | Paper size (a4 or letter) | `letter` |
| `MARGIN` | Page margins | `1in` |
| `FONT_SIZE` | Base font size | `11pt` |
| `COMPANY` | Company name | - |
| `AUTHOR` | Document author | - |
| `DATE` | Document date | Today's date |
| `LOGO_PATH` | Path to company logo | - |
| `CUSTOM_TEMPLATE` | Path to custom template | - |

## YAML Frontmatter

You can define document metadata in your Markdown file using YAML frontmatter:

```markdown
---
title: "Quarterly Sales Report"
subtitle: "Q4 2024"
author: "Jane Smith"
company: "Webera Inc."
date: "January 15, 2024"
toc: true
---

# Introduction

Your content here...
```

### Common Frontmatter Variables

- `title`: Document title
- `subtitle`: Document subtitle
- `author`: Author name
- `date`: Publication date
- `company`: Company name
- `toc`: Enable table of contents (true/false)
- `abstract`: Document abstract
- `keywords`: Document keywords

## Template-Specific Variables

### Business Letter
```yaml
---
sender-address: |
  123 Business Ave
  Suite 100
  New York, NY 10001
recipient-name: "John Doe"
recipient-company: "ABC Corporation"
recipient-address: |
  456 Commerce St
  Los Angeles, CA 90001
salutation: "Dear Mr. Doe:"
closing-text: "Sincerely,"
---
```

### Invoice
```yaml
---
invoice-number: "INV-2024-001"
due-date: "February 15, 2024"
bill-to-name: "Client Name"
bill-to-company: "Client Company"
subtotal: "1000.00"
tax-rate: "10"
tax: "100.00"
total: "1100.00"
payment-terms: "Net 30 days"
---
```

### Legal Contract
```yaml
---
contract-number: "CTR-2024-001"
effective-date: "January 1, 2024"
parties:
  - name: "Party A Inc."
    designation: "Vendor"
    description: "a corporation organized under the laws of Delaware"
  - name: "Party B LLC"
    designation: "Client"
    description: "a limited liability company organized under the laws of California"
---
```

## Custom Templates

### Using Custom Templates

Mount your custom LaTeX template and use it:

```bash
docker run -v $(pwd):/data \
  -v $(pwd)/my-template.latex:/opt/md2pdf/templates/custom.latex \
  -e TEMPLATE=custom \
  webera/md2pdf document.md
```

Or specify a custom template path:

```bash
docker run -v $(pwd):/data \
  -v $(pwd)/templates:/custom-templates \
  -e CUSTOM_TEMPLATE=/custom-templates/my-template.latex \
  webera/md2pdf document.md
```

### Creating Custom Templates

Custom templates should be LaTeX files using Pandoc template syntax. Key variables to support:

- `$body$`: The converted Markdown content
- `$title$`: Document title
- `$author$`: Author name
- `$date$`: Document date
- Custom variables using `$variable-name$`

Example minimal template:

```latex
\documentclass{article}
\begin{document}
\title{$title$}
\author{$author$}
\date{$date$}
\maketitle
$body$
\end{document}
```

## Advanced Usage

### Multiple Variables

```bash
docker run -v $(pwd):/data \
  -e TEMPLATE=business-report \
  -e COMPANY="Webera Inc." \
  -e AUTHOR="John Doe" \
  -e PAPER_SIZE=a4 \
  -e MARGIN=2cm \
  webera/md2pdf report.md quarterly-report.pdf
```

### With Custom Pandoc Arguments

```bash
docker run -v $(pwd):/data \
  -e PANDOC_EXTRA_ARGS="--toc --number-sections" \
  webera/md2pdf document.md
```

### Including Images

Place images in the same directory as your Markdown file:

```markdown
![Company Logo](logo.png)
```

### Code Blocks with Syntax Highlighting

````markdown
```python
def hello_world():
    print("Hello, World!")
```
````

## Examples

### Business Letter Example

```markdown
---
title: "Business Proposal"
author: "Jane Smith"
company: "Webera Inc."
date: "January 15, 2024"
recipient-name: "Mr. John Doe"
recipient-company: "ABC Corporation"
salutation: "Dear Mr. Doe:"
closing-text: "Best regards,"
---

I am writing to propose a partnership between our companies...

## Proposal Details

Our proposal includes the following key points:

1. Strategic alignment
2. Mutual benefits
3. Implementation timeline
```

### Invoice Example

```markdown
---
title: "Invoice"
invoice-number: "2024-001"
date: "January 15, 2024"
due-date: "February 15, 2024"
bill-to-name: "John Doe"
bill-to-company: "ABC Corporation"
---

| Item | Description | Qty | Rate | Amount |
|------|-------------|-----|------|--------|
| 1 | Consulting Services | 10 | $150 | $1,500 |
| 2 | Development | 20 | $175 | $3,500 |

**Subtotal:** $5,000
**Tax (10%):** $500
**Total:** $5,500
```

## Troubleshooting

### Common Issues

1. **Missing fonts**: The image includes Liberation fonts. For other fonts, mount them or use system fonts.

2. **Large file size**: LaTeX packages can make the image large. Use `--no-install-recommends` when building custom images.

3. **Template not found**: Ensure the template name matches exactly (case-sensitive) and the file exists.

4. **Images not showing**: Ensure images are in the mounted volume and use relative paths.

### Getting Help

```bash
docker run webera/md2pdf --help
```

List available templates:

```bash
docker run webera/md2pdf --list-templates
```

## Building from Source

```bash
# Clone the repository
git clone https://github.com/wearewebera/public-images.git
cd public-images/images/md2pdf

# Build the image
docker build -t webera/md2pdf .

# Test the build
docker run -v $(pwd)/test:/data webera/md2pdf test.md
```

## License

This image is provided as-is for use in generating PDF documents from Markdown files.

## Support

For issues, feature requests, or questions, please visit:
https://github.com/wearewebera/public-images/issues