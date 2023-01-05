using Pkg
Pkg.activate("..")


using GreekSyntax
using CitableCorpus, CitableBase, CitableText
using Orthography, PolytonicGreek

using Test
using TestSetExtensions



@testset "All the tests" begin
    println(map(s -> replace(s, r".jl$" => ""), ARGS))
    @includetests map(s -> replace(s, r".jl$" => ""), ARGS)
end
