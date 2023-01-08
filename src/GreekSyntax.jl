module GreekSyntax
using CitableText, CitableCorpus
using Orthography, PolytonicGreek
using Kroki
using Documenter, DocStringExtensions

import Base: ==


include("html/css.jl")
include("common/sentence.jl")
include("greek/sentenceparser.jl")
include("common/groups.jl")
include("greek/groupsparser.jl")
include("common/token.jl")
include("greek/tokenparser.jl")
include("common/delimited.jl")
include("common/utils.jl")
include("common/sentenceutils.jl")
include("common/grouputils.jl")
include("common/tokenutils.jl")
include("html/htmlutils.jl")
include("html/mermaidutils.jl")


export SentenceAnnotation
export VerbalUnitAnnotation
export TokenAnnotation

export parsesentences
export delimited, readdelimited

export htmltext, htmltext_indented
export htmlgroup, htmlgrouplist
export mermaiddiagram

end # module GreekSyntax
