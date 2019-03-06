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

Welcome to the (+pandoc-gls) test source code document. I really don't want this ->
(-pandoc-gls) to be linked to the glossary!

## Section heading

Some text in here with some acronyms: You have to watch out for those (+^BAR), they are
(+^FOO) (although (+BAZ) disagrees). (++^FOO) should not be trusted!

## Another section heading
 
Some other text with _emphasised_ glossary terms _(+FOO)_ __(+BAZ)__

## A heading with an acronym in: (+BAR)

Some inline code `code ac (+^BAZ)`.

Why not have a table:

| Name    | Description | 
|---------|-------------|
| Dave    | (+BAR)      |
| (+BAZ)  | (++FOO)     |
