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
        "Read a delimited file" => "read.md"
       
    ]
    )

deploydocs(
    repo = "github.com/neelsmith/GreekSyntax.jl.git",
)    