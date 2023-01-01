using GreekSyntax
using Kroki
repo = pwd()
(sentences, vus, syntokens) = joinpath(repo, "test", "data", "lysias1_selection.cex") |> readlines |> readdelimited
sa = sentences[2]

## Debugging
(sentencetokens, connectorids, origin) = GreekSyntax.tokensforsentence(sa, syntokens)
lextokens = filter(sentencetokens) do t
    t.tokentype == "lexical"
end



gr = mermaiddiagram(sa, syntokens)

open("debugmerm.txt", "w") do io
    write(io, gr)
end

mermaid"""
$(gr)
"""
