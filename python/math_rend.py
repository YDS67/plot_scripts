import re

# Mapping of LaTeX Greek codes to Unicode
greek_letters = {
    r"\\alpha": "α",
    r"\\beta": "β",
    r"\\gamma": "γ",
    r"\\delta": "δ",
    r"\\epsilon": "ε",
    r"\\zeta": "ζ",
    r"\\eta": "η",
    r"\\theta": "θ",
    r"\\iota": "ι",
    r"\\kappa": "κ",
    r"\\lambda": "λ",
    r"\\mu": "μ",
    r"\\nu": "ν",
    r"\\xi": "ξ",
    r"\\omicron": "ο",
    r"\\pi": "π",
    r"\\rho": "ρ",
    r"\\sigma": "σ",
    r"\\tau": "τ",
    r"\\upsilon": "υ",
    r"\\phi": "φ",
    r"\\chi": "χ",
    r"\\psi": "ψ",
    r"\\omega": "ω",
    r"\\Gamma": "Γ",
    r"\\Delta": "Δ",
    r"\\Theta": "Θ",
    r"\\Lambda": "Λ",
    r"\\Xi": "Ξ",
    r"\\Pi": "Π",
    r"\\Sigma": "Σ",
    r"\\Upsilon": "Υ",
    r"\\Phi": "Φ",
    r"\\Psi": "Ψ",
    r"\\Omega": "Ω"
}

def html(mathjax_string):
    """
    Converts simple MathJax inline formulas to HTML, handling superscripts, subscripts,
    common functions, and avoiding italicizing numbers and brackets.
    """
    pattern = r"\$(.*?)\$"

    def replace_sqrt(match):
        expression = match.group(1)  # Extract the content inside the curly braces
        # Construct the result by combining the Unicode square root symbol (√) and overlined expression
        # The overline can be represented as a combining character `\u0305` after the expression
        return f"√({expression})"
    
    # Function to wrap letters outside HTML tags
    def wrap_outside_tags(match):
        text = match.group(1)  # Group 1 is the non-tagged text
        # Wrap each individual letter in <i></i>
        wrapped_text = re.sub(r"([a-zA-Z\u0370-\u03FF])", r"<i>\1</i>", text)
        return wrapped_text

    def replace_match(match):
        content = match.group(1)
        content = re.sub(r'\\sqrt{(.*?)}', replace_sqrt, content)
        content = re.sub(r"([a-zA-Z0-9\(\)\[\]\{\}])\^([a-zA-Z0-9])", r"\1<sup>\2</sup>", content)
        content = re.sub(r"([a-zA-Z0-9\(\)\[\]\{\}])_([a-zA-Z0-9])", r"\1<sub>\2</sub>", content)
        content = re.sub(r"([a-zA-Z0-9\(\)\[\]\{\}])\^\{([a-zA-Z0-9\(\)\[\]]+)\}", r"\1<sup>\2</sup>", content)
        content = re.sub(r"([a-zA-Z0-9\(\)\[\]\{\}])_\{([a-zA-Z0-9\(\)\[\]]+)\}", r"\1<sub>\2</sub>", content)
        common_functions = ["cos", "sin", "tan", "exp", "log", "ln"]
        for func in common_functions:
            content = re.sub(r"\\"+func, r"<span>"+func+r"</span>", content)
        for latex_code, unicode_symbol in greek_letters.items():
            content = re.sub(latex_code, unicode_symbol, content)
        content = re.sub(r"([^<>]+)(?=<|$)", wrap_outside_tags, content)
        return content

    html_string = re.sub(pattern, replace_match, mathjax_string)

    # Find everything inside <span>...</span> and process it
    def remove_i_from_span(match):
        span_content = match.group(1)  # Extract content inside the <span>...</span>
        # Remove all <i> tags inside the span content
        cleaned_span = re.sub(r'<i>(.*?)</i>', r'\1', span_content)
        return cleaned_span
    
    # Match all <span>...</span> tags and apply the cleaning function
    html_string = re.sub(r'<span>(.*?)</span>', remove_i_from_span, html_string)

    return html_string