This filter provides a slightly cleaner syntax for the LaTeX 
[glossaries package](https://www.ctan.org/pkg/glossaries). This uses a syntax inspired by
[pandoc-ac](https://github.com/Enet4/pandoc-ac) by Eduardo Pinho.

What it does:

| Code     | Description                                   | Translates to |
|----------|-----------------------------------------------|---------------|
| `(+x)`   | glossary entry                                | `\gls{x}`     |
| `(++x)`  | capitalised glossary entry                    | `\Gls{x}`     |
| `(+^x)`  | plural form of the glossary entry             | `\glspl{x}`   |
| `(++^x)` | capitalised plural form of the glossary entry | `\Glspl{x}`   |


## Usage

To apply this filter to your markdown code, clone the `pandoc-gls.lua` to an accessible
directory, then run pandoc with the `--lua-filters` option:

``` 
$ pandoc --from markdown --to latex -o output.pdf --lua-filter \path\to\pandoc-gls.lua input.md
```

In order for the glossary entries to render properly you need to include the glossaries
package and a definition file (see `glossary.tex` in this repository for an example) in
the markdown document's front matter:

``` 
header-includes:
    - \usepackage{glossaries}
    - \makenoidxglossaries
    - \include{<path to glossary definitions file>}
include-after:
    - \printnoidxglossary[sort=word]
```

This will include a glossary at the end of the document, however you can place it at the
front by putting the print glossary command in the `include-before` list.

## To-Do

Lua is not my main language so this filter could probably be made more efficient. Any tips
are welcome.

Currently only supports glossary entries in normal text, headings and tables. I need to
add support for code blocks and other inline elements.

