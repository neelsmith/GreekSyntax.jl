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

include("metrics/syntax.jl")

include("html/htmlutils.jl")
include("html/mermaidutils.jl")


export SentenceAnnotation, sentence
export VerbalUnitAnnotation, verbalunit
export TokenAnnotation, token

export parsesentences
export delimited, readdelimited

export groupsforsentence
export tokensforsentence
export sentencerange, sentencesforurn

export htmltext, htmltext_indented
export htmlgroup, htmlgrouplist, sovkey
export mermaiddiagram

end # module GreekSyntax
