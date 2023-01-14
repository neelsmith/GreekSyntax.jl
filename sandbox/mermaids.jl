using GreekSyntax
using Kroki
repo = pwd()
(sentences, vus, syntokens) = joinpath(repo, "test", "data", "Lysias1.6ff.cex") |> readlines |> readdelimited

sa = sentences[2]

## Debugging
lextokens = lexicalforsentence(sa, tokens)



gr = mermaiddiagram(sa, syntokens)

open("debugmerm.txt", "w") do io
    write(io, gr)
end

mermaid"""
$(gr)
"""



as_png =  mermaiddiagram(sa, syntokens, format = "png")
write("syntax.png", as_png)