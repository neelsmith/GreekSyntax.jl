module GreekSyntax
using CitableText, CitableCorpus
using Orthography, PolytonicGreek
using Kroki
using Documenter, DocStringExtensions

include("sentence.jl")
include("verbalunit.jl")
include("token.jl")
include("delimited.jl")
include("utils.jl")
include("htmlutils.jl")
include("mermaidutils.jl")

export parsesentences
export delimited, readdelimited
export SentenceAnnotation
export VerbalUnitAnnotation
export TokenAnnotation


export htmltext, htmltext_indented
export htmlgroup, htmlgrouplist
export mermaiddiagram

end # module GreekSyntax
