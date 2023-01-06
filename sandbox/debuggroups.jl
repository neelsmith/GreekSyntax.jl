using GreekSyntax
using CitableBase, CitableText, CitableCorpus

url = "https://raw.githubusercontent.com/neelsmith/GreekSyntax/main/data/Lysias1_annotations.cex"

(sentences, groups, tokens) = Downloads.download(url) |> readlines |> readdelimited

(tkns, conns, origin) = GreekSyntax.tokeninfoforsentence(sentences[40], tokens)



using Orthography, PolytonicGreek
f = joinpath(pwd(), "test", "data", "texts", "lysias1.cex")
c = fromcex(f, CitableTextCorpus, FileReader)
tokenanalysis = tokenize(c, literaryGreek())
tokencorpus = map(pr -> pr[1], tokenanalysis) |> CitableTextCorpus
sents = parsesentences(c, literaryGreek())

select(sents[40].urn, tokencorpus)


