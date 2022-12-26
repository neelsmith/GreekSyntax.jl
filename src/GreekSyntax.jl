module GreekSyntax
using CitableText, CitableCorpus
using Orthography, PolytonicGreek

using Documenter, DocStringExtensions

include("sentence.jl")
include("verbalunit.jl")
include("token.jl")
include("delimited.jl")

export parsedelimited
export SentenceAnnotation
export VerbalUnitAnnotation
export TokenAnnotation

end # module GreekSyntax
