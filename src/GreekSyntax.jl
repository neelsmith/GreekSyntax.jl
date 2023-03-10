module GreekSyntax
using CitableText, CitableCorpus
using Orthography, PolytonicGreek
using Kroki
using StringDistances
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
include("common/validation.jl")
include("greek/greekvalidation.jl")
include("common/utils.jl")
include("common/sentenceutils.jl")
include("common/grouputils.jl")
include("common/tokenutils.jl")

include("metrics/tokenmetrics.jl")
include("metrics/groupmetrics.jl")
include("metrics/sentencemetrics.jl")

include("html/htmlutils.jl")
include("html/mermaidutils.jl")


export SentenceAnnotation, sentence
export VerbalUnitAnnotation, verbalunit
export TokenAnnotation, token

export parsesentences
export delimited, readdelimited
export validatedform

export groupsforsentence
export tokensforsentence, lexicalforsentence
export sentencerange, sentencesforurn
export tokensforgroup
export sentenceforgroup
export groupfortoken
export sentencefortoken

export htmltext, htmltext_indented
export htmlgroup, htmlgrouplist, sovkey
export mermaiddiagram

export distance, displacement
export span, spansize, displacedby, cohesion
export maxdepth
export maxtokendistance, avgtokendistance
export maxtokendisplacement, avgtokendisplacement
export maxgroupdisplacement, avggroupdisplacement

end # module GreekSyntax
