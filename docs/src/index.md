

# `GreekSyntax.jl`

The `GreekSyntax` package implements the simple model of ancient Greek syntax  presented at [https://neelsmith.github.io/GreekSyntax/](https://neelsmith.github.io/GreekSyntax/).

It defines types for:

- annotations on *sentences*
- annotations on *verbal expressions* within a sentence
- annotations on *lexical tokens* with a verbal expression

It includes functions to:

- read/write delimited-text files recording syntactic annotations
- compose a HTML visualizations of text syntactically highlighted in a variety of ways
- visualize syntax graphically with Mermaid diagrams


The next pages provide a few examples of how to use these functions.  These are followed by fuller API listings, and a summary of the delimited file format that the `GreekSyntax` package writes to and reads from.