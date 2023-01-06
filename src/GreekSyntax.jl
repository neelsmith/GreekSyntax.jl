module GreekSyntax
using CitableText, CitableCorpus
using Orthography, PolytonicGreek
using Kroki
using Documenter, DocStringExtensions

import Base: ==


include("css.jl")
include("sentence.jl")
include("groups.jl")
include("token.jl")
include("delimited.jl")
include("utils.jl")
include("sentenceutils.jl")
include("grouputils.jl")
include("tokenutils.jl")
include("htmlutils.jl")
include("mermaidutils.jl")


export SentenceAnnotation
export VerbalUnitAnnotation
export TokenAnnotation

export parsesentences
export delimited, readdelimited

export htmltext, htmltext_indented
export htmlgroup, htmlgrouplist
export mermaiddiagram

end # module GreekSyntax
