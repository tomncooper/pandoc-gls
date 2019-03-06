# pandoc-gls

This filter provides a slightly cleaner syntax for the LaTeX 
[glossaries package](https://www.ctan.org/pkg/glossaries). This uses a syntax inspired by
[pandoc-ac](https://github.com/Enet4/pandoc-ac) by Eduardo Pinho.

Use the codes below in place of the `\gls{label}` form in your source code:

| Code   | Description                                             | Translates to        |
|--------|---------------------------------------------------------|----------------------|
|`(+x)`  | glossary entry                                          | `\gls{x}`            |
|`(++x)` | capitalised glossary entry                              | `\Gls{x}`            |
|`(+^x)` | plural form of the glossary entry                       | `\glspl{x}`          |
|`(++^x)`| capitalised plural form of the glossary entry           | `\Glspl{x}`          |
|`(-x)`  | unlinked glossary entry name only                       | `\glsentryname{x}`   |
|`(-+x)` | caplitalised unlinked glossary entry                    | `\Glsentryname{x}`   |
|`(-^x)` | plutal unlinked glossary entry                          | `\glsentryplural{x}` |
|`(-+^x)`| caplitalised plural form of the unlinked glossary entry | `\Glsentryplural{x}` |

The unlinked versions of the syntax are recommended for figure and table captions as this
will prevent the acronyms and glossary first usages turning up in your tables of
figures/tables and/or messing up your PDF bookmarks.

If you are using the `hyperref` package to have links from your TOC to your sections then
avoid using the anything other than `(-x)` in your section headings as all manor of errors
await you. See the details about expandable vs non-expandable commands in the [glossaries
user
guide](http://mirror.ox.ac.uk/sites/ctan.org/macros/latex/contrib/glossaries/glossaries-user.pdf).

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

__NOTE:__ Glossary labels cannot contain spaces but can contain "\_" (underscore) and "-"
(hyphen) characters. Any other punctuation characters used within labels will cause the
parsing to fail.

## To-Do

Lua is not my main language so this filter could probably be made more efficient. Any tips
are welcome.

Currently only supports glossary entries in normal text, headings and tables. I need to
add support for code blocks and other inline elements.

I need to add support for using `hyperref`'s `\texorpdfstring{TEX text}{Bookmark Text}`
command to the commands above so they can be used in section headings.

