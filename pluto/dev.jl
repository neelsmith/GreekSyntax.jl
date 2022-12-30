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

# ╔═╡ 31fc979d-121f-456e-a963-713224e318c7
md"""> Load a corpus and create sentence candidates"""

# ╔═╡ ba10f3f6-7a47-4ebd-9559-65f230d74081
begin
	f = joinpath(repo, "test", "data", "lysias1.cex")
	c = fromcex(f, CitableTextCorpus, FileReader)
	parsesentences(c, ortho = literaryGreek())
end

# ╔═╡ d12ab940-f56a-49e0-bedf-b341f2124bc5
md"""> Formatting a vector of tokens"""

# ╔═╡ 059b137a-a5ff-4b9e-935b-b00effdf0a9f
function formatsentenceBW(s)
	formatted = []

	counter = 0
	for (tkn, tkntype) in s
		counter = counter + 1
		if typeof(tkntype) == LexicalToken
			
			if isempty(connectorlist)  || isnothing(connectorlist[1]) || ! (counter in connectorlist)
			
				
				push!(formatted, " " * tkn.text)
			else
				tagged = "<span class=\"connector\")>$(tkn.text)</span>"
				push!(formatted, " " * tagged)
			end
			
		else
			push!(formatted, tkn.text)
		end
	end
	
	join(formatted,"")
end;

# ╔═╡ Cell order:
# ╟─d3d708ea-5a63-4c9e-9fc2-6801ada726e0
# ╠═a4471683-d5cd-4ca4-9f3b-c582427f473b
# ╟─2a2d0160-8794-11ed-23a7-0d6ff795640e
# ╟─31fc979d-121f-456e-a963-713224e318c7
# ╠═ba10f3f6-7a47-4ebd-9559-65f230d74081
# ╠═d12ab940-f56a-49e0-bedf-b341f2124bc5
# ╠═059b137a-a5ff-4b9e-935b-b00effdf0a9f
