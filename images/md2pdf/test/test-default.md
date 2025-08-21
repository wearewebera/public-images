---
title: "Sample Document"
author: "Webera Test Suite"
date: "January 2024"
toc: true
---

# Introduction

This is a test document for the webera/md2pdf Docker image. It demonstrates the capabilities of the default template.

## Features

The default template provides a clean, professional layout suitable for various business documents.

### Typography

The template uses Liberation fonts for excellent readability:

- **Bold text** for emphasis
- *Italic text* for subtle emphasis
- `Inline code` for technical terms

### Lists

Unordered lists:
- First item
- Second item
  - Nested item
  - Another nested item
- Third item

Ordered lists:
1. First step
2. Second step
3. Third step

## Code Blocks

Here's an example of syntax-highlighted code:

```python
def fibonacci(n):
    """Generate Fibonacci sequence up to n terms."""
    if n <= 0:
        return []
    elif n == 1:
        return [0]
    elif n == 2:
        return [0, 1]
    
    fib = [0, 1]
    for i in range(2, n):
        fib.append(fib[i-1] + fib[i-2])
    return fib

# Example usage
print(fibonacci(10))
```

## Tables

| Feature | Description | Status |
|---------|-------------|--------|
| PDF Generation | Convert Markdown to PDF | ✓ |
| Templates | Multiple professional templates | ✓ |
| Customization | Environment variables | ✓ |
| Cross-platform | AMD64 and ARM64 | ✓ |

## Links and References

Visit [Webera](https://webera.com) for more information.

For technical documentation, see the [GitHub repository](https://github.com/wearewebera/public-images).

## Mathematical Expressions

The template supports LaTeX math expressions:

Inline math: $E = mc^2$

Display math:
$$\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}$$

## Blockquotes

> "The best way to predict the future is to invent it."
> 
> — Alan Kay

## Images

Images can be included with captions and proper formatting. The template handles image placement and sizing automatically.

## Conclusion

This test document demonstrates the key features of the default template. The clean, professional layout makes it suitable for a wide range of business and technical documents.