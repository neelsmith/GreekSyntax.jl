# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
# Run this from repository root to serve:
#
#   julia -e 'using LiveServer; serve(dir="docs/build")'
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions
using GreekSyntax

makedocs(   
    sitename = "GreekSyntax",
    pages = [
        "Overview" => "index.md",
        "Read an annotated text from a delimited-text source" => "read.md",
        "Working with sentences, verbal expressions and tokens" => "structures.md",
        "Metrics of syntactic complexity" => "metrics.md",
        "Values for syntactic annotations" => "annotations.md",
        "Composing HTML and CSS" => "html.md",
        
        "API docs" => "api.md",
        "Appendix: delimited-text format" => "serialization.md"
       
    ]
    )

deploydocs(
    repo = "github.com/neelsmith/GreekSyntax.jl.git",
)    
