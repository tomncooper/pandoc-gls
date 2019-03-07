---
title: Pandoc-gls test document
author: Thomas Cooper
date: 02/03/2019
header-includes:
    - \usepackage{glossaries}
    - \makenoidxglossaries
    - \input{glossary}
include-after:
    - \printnoidxglossary[sort=word]
---

## Introduction

Welcome to (+pandoc-gls)' test source code document. But I really don't want this ->
(-pandoc-gls) or this (-+^FOO) to be linked to the glossary!

## Section heading

You have to watch out for those (+^BAR), they are (+^FOO) (although (+BAZ) disagrees).
(++^FOO) should not be trusted! Also watch out for the (+BAR)'s dog it is a biter!

## Another section heading
 
Some other text with _emphasised_ glossary terms _(+FOO)_ __(+BAZ)__

We also need to make sure the surrounding punctuation and characters are not ignored:

- ((+FOO)).
- ((++BAZ)),
- ((+^BAR))!?!?!?!
- (+pandoc-gls)oloing


## A heading with an acronym in: (-BAR)

Some inline code `code ac (+^BAZ)`.

Why not have a table:

| Name    | Description | 
|---------|-------------|
| Dave    | (+BAR)      |
| (+BAZ)  | (++FOO)     |
