using GreekSyntax
repo = pwd()
(sentences, vus, syntokens) = joinpath(repo, "test", "data", "lysias1_selection.cex") |> readlines |> readdelimited


#(sentencetokens, connectorids, origin) = GreekSyntax.tokensforsentence(sa, syntokens)