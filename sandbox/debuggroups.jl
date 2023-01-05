using GreekSyntax
using Downloads
using CitableText, CitableCorpus

url = "https://raw.githubusercontent.com/neelsmith/GreekSyntax/main/data/lysias1_selection.cex"

(sentences, groups, tokens) = Downloads.download(url) |> readlines |> readdelimited


sentence = sentences[1]


(sentencetokens, connectorids, origin) = GreekSyntax.tokensforsentence(sentence, tokens)



typeof(sentencetokens)

thresh = 1
levelselection = filter(sentencetokens) do tkn
    g = GreekSyntax.groupfortoken(tkn, groups)
    !isnothing(g) && g.depth <= thresh && g.depth != 0
end

levelcorp = map(t -> GreekSyntax.passagefromtoken(t), levelselection) |> CitableTextCorpus
selrange = GreekSyntax.sentencerange(levelselection)
newsent = SentenceAnnotation(
    selrange, sentence.sequence, sentence.connector
)



htmltext_indented(newsent, groups, levelselection)