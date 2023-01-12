using GreekSyntax
using CitableText
f = joinpath("..", "eagl-texts", "annotations", "Lysias1_annotations.cex")
(sentences, groups, tokens) = readlines(f) |> readdelimited




sentenceannotation = SentenceAnnotation(CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.33-1.14.39a"), 33,  nothing)

cex = """urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.33|lexical|ἐσιώπων|1.14.33-1.14.39a.1|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.34|lexical|ἐγὼ|1.14.33-1.14.39a.1|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.35|lexical|καὶ|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.36|lexical|ταῦτα|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.37|lexical|οὕτως|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.38|lexical|ἔχειν|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.39|lexical|ἡγούμην|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.39a|ignore|.|0|nothing|nothing|nothing|nothing
"""
intermediatetokens = filter(ln -> ! isempty(ln), split(cex, "\n") ) .|> token


verbalunits = [verbalunit("1.14.33-1.14.39a.1|Independent clause|transitive|1|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.33-1.14.39a")]



htmltext_indented(sentenceannotation, verbalunits, intermediatetokens, vucolor = false) 



testsent = "urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.33-1.14.39a|33|" |> sentence

testnotes = """urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.33|lexical|ἐσιώπων|1.14.33-1.14.39a.1|0|unit verb|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.34|lexical|ἐγὼ|1.14.33-1.14.39a.1|1|subject|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.35|lexical|καὶ|1.14.33-1.14.39a.2|7|conjunction|1|conjunction
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.36|lexical|ταῦτα|1.14.33-1.14.39a.3|6|subject|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.37|lexical|οὕτως|1.14.33-1.14.39a.3|6|adverbial|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.38|lexical|ἔχειν|1.14.33-1.14.39a.3|7|unit verb|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.39|lexical|ἡγούμην|1.14.33-1.14.39a.2|3|unit verb|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.14.39a|ignore|.|0|nothing|nothing|nothing|nothing
"""
notations = filter(ln -> !isempty(ln), split(testnotes, "\n")) .|> token

merm = mermaiddiagram(testsent, notations, format = "png")

write("merm1.png", merm)









