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
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.1|lexical|ἐπ'|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.2|lexical|ἐκφορὰν|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.3|lexical|γὰρ|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.4|lexical|αὐτῇ|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.5|lexical|ἀκολουθήσασα|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.6|lexical|ἡ|1.8.1-1.8.15a.1|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.7|lexical|ἐμὴ|1.8.1-1.8.15a.1|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.8|lexical|γυνὴ|1.8.1-1.8.15a.1|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.9|lexical|ὑπὸ|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.10|lexical|τούτου|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.11|lexical|τοῦ|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.12|lexical|ἀνθρώπου|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.13|lexical|ὀφθεῖσα|nothing|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.13a|ignore|,|0|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.14|lexical|χρόνῳ|1.8.1-1.8.15a.1|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.15|lexical|διαφθείρεται|1.8.1-1.8.15a.1|nothing|nothing|nothing|nothing
urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.8.15a|ignore|:|0|nothing|nothing|nothing|nothing
"""

tknlines = split(tkncex, "\n")


tokens = filter(ln -> ! isempty(ln), tknlines) .|> GreekSyntax.token


htmltext(sa, tokens)