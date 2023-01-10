using GreekSyntax
using CitableText
using CitableCorpus

vudelim = "1.8.1-1.8.15a.1|transitive|1|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.1-1.8.15a"

vucex = ["1.8.1-1.8.15a.1|transitive|Independent clause|1|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.1-1.8.15a",
"1.8.1-1.8.15a.2|transitive|circumstantial participle|2|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.1-1.8.15a",
"1.8.1-1.8.15a.3|transitive|circumstantial participle|2|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.1-1.8.15a"
]
verbalunits = map(ln -> GreekSyntax.verbalunit(ln), vucex)

sentcex = "urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.1-1.8.15a|15|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.3"
sa = GreekSyntax.sentence(sentcex)
 
tkncex = """
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.1|lexical|ἐπ'|1.8.1-1.8.15a.2|5|adverbial|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.2|lexical|ἐκφορὰν|1.8.1-1.8.15a.2|1|object of preposition|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.3|lexical|γὰρ|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.4|lexical|αὐτῇ|1.8.1-1.8.15a.2|5|object|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.5|lexical|ἀκολουθήσασα|1.8.1-1.8.15a.2|8|unit verb|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.6|lexical|ἡ|1.8.1-1.8.15a.1|8|article|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.7|lexical|ἐμὴ|1.8.1-1.8.15a.1|8|attributive|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.8|lexical|γυνὴ|1.8.1-1.8.15a.1|15|subject|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.9|lexical|ὑπὸ|1.8.1-1.8.15a.3|13|agent|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.10|lexical|τούτου|1.8.1-1.8.15a.3|12|pronoun|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.11|lexical|τοῦ|1.8.1-1.8.15a.3|12|article|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.12|lexical|ἀνθρώπου|1.8.1-1.8.15a.3|9|object of preposition|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.13|lexical|ὀφθεῖσα|1.8.1-1.8.15a.3|8|unit verb|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.13a|ignore|,|0|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.14|lexical|χρόνῳ|1.8.1-1.8.15a.1|15|adverbial|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.15|lexical|διαφθείρεται|1.8.1-1.8.15a.1|3|unit verb|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.15a|ignore|:|0|nothing|nothing|nothing|nothing
"""

tknlines = split(tkncex, "\n")


tokens = filter(ln -> ! isempty(ln), tknlines) .|> GreekSyntax.token


htmltext(sa, tokens, syntaxtips = true) |> println

htmltext_indented(sa, verbalunits,  tokens, syntaxtips = true) |> println