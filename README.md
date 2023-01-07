# GreekSyntax.jl

> Implementing a simple model of ancient Greek syntax presented at <https://neelsmith.github.io/GreekSyntax/>.

- read syntax annotations from simple delimited-text files
- analyze syntax annotations
- compose a variety of HTML visualizations of syntactically highlighted text
- visualize syntax graphically with Mermaid diagrams


Documentation at  <https://neelsmith.github.io/GreekSyntax.jl/stable/>.



## Example

The script in `scripts/syntaxsite.jl` illustrates usage of the functions composing HTML views of syntactically annotated text. It reads a set of syntactic annotations from a delimited-text source, and composes a web page for each annotated sentence.  Try it!  You can run it as is to build pages for Lysias 1. Supply your own data, or modify the CSS to format the web pages as you like.