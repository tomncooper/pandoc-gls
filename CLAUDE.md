# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`pandoc-gls` is a single-file Pandoc Lua filter (`pandoc-gls.lua`) that translates a custom shorthand syntax into LaTeX `glossaries` package commands. For example, `(+FOO)` becomes `\gls{FOO}`.

## Testing

```sh
make test           # run smoke tests (all 5 should PASS)
make update-golden  # regenerate golden files after an intentional output change
```

Tests live in `tests/*.md` with expected outputs in `tests/golden/*.tex`. Each test pipes a markdown snippet through pandoc with the filter and diffs against the golden file. No extra tooling beyond pandoc is needed.

To produce a PDF from the full example (requires a LaTeX installation):

```sh
pandoc --from markdown --to pdf --lua-filter pandoc-gls.lua example.md -o output.pdf
```

## Architecture

The entire filter is `pandoc-gls.lua` (~53 lines). Pandoc's Lua filter API works by defining functions named after AST node types; any function named `Str` is automatically called for every inline string element during traversal.

The core logic is one Lua pattern match in `Str()` (line 10) that captures:
- `front` — characters before the opening `(`
- `capital` — the modifier prefix (`+`, `++`, `-`, `-+`)
- `plural` — optional `^` for plural forms
- `ac` — the glossary label (alphanumeric, underscores, hyphens)
- `apostrophe` — optional `'` or `'` for possessives
- `back` — characters after the closing `)`

The `replace()` helper assembles the final `\command{label}` string, which is returned as a `pandoc.RawInline("tex", ...)` node so Pandoc passes it through to LaTeX verbatim.

## Syntax reference

| Input      | Output LaTeX command  |
|------------|-----------------------|
| `(+x)`     | `\gls{x}`             |
| `(++x)`    | `\Gls{x}`             |
| `(+^x)`    | `\glspl{x}`           |
| `(++^x)`   | `\Glspl{x}`           |
| `(-x)`     | `\glsentryname{x}`    |
| `(-+x)`    | `\Glsentryname{x}`    |
| `(-^x)`    | `\glsentryplural{x}`  |
| `(-+^x)`   | `\Glsentryplural{x}`  |

Labels may contain alphanumeric characters, `_`, and `-`. Spaces and other punctuation in labels will break parsing.
