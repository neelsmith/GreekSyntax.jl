### A Pluto.jl notebook ###
# v0.19.17

using Markdown
using InteractiveUtils

# ╔═╡ d3d708ea-5a63-4c9e-9fc2-6801ada726e0
repo = joinpath(pwd(), "..")

# ╔═╡ a4471683-d5cd-4ca4-9f3b-c582427f473b
# ╠═╡ show_logs = false
begin
	using Pkg
	Pkg.activate(repo)
	Pkg.resolve()
	Pkg.instantiate()
	using GreekSyntax
	using CitableBase
	using CitableText
	using CitableCorpus
	using Orthography
	using PolytonicGreek
	const GS = GreekSyntax
end

# ╔═╡ 2a2d0160-8794-11ed-23a7-0d6ff795640e
md"""# Dev. notebook"""

# ╔═╡ d12ab940-f56a-49e0-bedf-b341f2124bc5
f = joinpath(repo, "test", "data", "lysias1.cex")

# ╔═╡ 059b137a-a5ff-4b9e-935b-b00effdf0a9f
c = fromcex(f, CitableTextCorpus, FileReader)

# ╔═╡ Cell order:
# ╟─d3d708ea-5a63-4c9e-9fc2-6801ada726e0
# ╠═a4471683-d5cd-4ca4-9f3b-c582427f473b
# ╟─2a2d0160-8794-11ed-23a7-0d6ff795640e
# ╠═d12ab940-f56a-49e0-bedf-b341f2124bc5
# ╠═059b137a-a5ff-4b9e-935b-b00effdf0a9f
