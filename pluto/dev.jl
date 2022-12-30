### A Pluto.jl notebook ###
# v0.19.18

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

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

	using PlutoUI
end

# ╔═╡ 2a2d0160-8794-11ed-23a7-0d6ff795640e
md"""# Dev. notebook"""

# ╔═╡ 31fc979d-121f-456e-a963-713224e318c7
md"""> ### Two things we'll need
>
> - a tokenized corpus
> - a sequence of sentence ranges (annotation candidates).  These are pairings (in a `NamedTuple`) of a range URN with a sequence number.


"""

# ╔═╡ 7d29b0b7-f561-4c12-a13c-711893c94ddf
c = begin
	f = joinpath(repo, "test", "data", "lysias1.cex")
	fromcex(f, CitableTextCorpus, FileReader)
end

# ╔═╡ 905993bd-214c-41a4-9053-aeed890b4d92
analyzedtokens = tokenize(c, literaryGreek())

# ╔═╡ ca14751b-0a59-4117-b87f-4ed1b359abb1
tcorpus = map(analyzedtokens) do pr
	pr[1]
end |> CitableTextCorpus

# ╔═╡ f69a7bce-d35c-4dbe-9f74-852a81ba5d9f
length(analyzedtokens)

# ╔═╡ ba10f3f6-7a47-4ebd-9559-65f230d74081
sentencepairs = parsesentences(c, literaryGreek())


# ╔═╡ d12ab940-f56a-49e0-bedf-b341f2124bc5
md"""> Formatting a vector of tokens"""

# ╔═╡ d5cdfb4b-fb30-409c-80db-f8ce765eb2f3


# ╔═╡ effa7095-1691-4873-9cd6-3741c9343f3c
begin

	md"""*Choose a sentence by sequence number* $(@bind sentseq confirm(NumberField(0:length(sentencepairs))))"""
end

# ╔═╡ 1f4624f7-b747-49ba-a2ab-209e596f25b5
if sentseq > 0
	senturn = sentencepairs[sentseq].urn
end

# ╔═╡ c2dd8786-f17f-47d9-9187-f6e84c1b72ee
if sentseq > 0
	md"""Display sentence **$(passagecomponent(senturn))**
	
	
"""
end

# ╔═╡ 9f1983a9-cda2-431f-94b4-30f4535dba17
if sentseq > 0
	#formatsentenceBW(senturn, analyzedtokens)
end

# ╔═╡ d6f81c51-0249-426a-99e7-72bae282411c
senturn

# ╔═╡ d293a0b8-3db8-4e8f-a5dc-3b0d0d388fbe
begin
	select(senturn, tcorpus)
end

# ╔═╡ 059b137a-a5ff-4b9e-935b-b00effdf0a9f
"""What we need:

- a range urn
- a bunch o' tokens. These are the tuples that token analyis produces: a citable passage + a token category.
"""
function formatsentenceBW(range::CtsUrn, v::Vector{Tuple{CitablePassage, TokenCategory}})
	formatted = []


	#=
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
	=#
	join(formatted,"")
end

# ╔═╡ Cell order:
# ╟─d3d708ea-5a63-4c9e-9fc2-6801ada726e0
# ╠═a4471683-d5cd-4ca4-9f3b-c582427f473b
# ╟─2a2d0160-8794-11ed-23a7-0d6ff795640e
# ╟─31fc979d-121f-456e-a963-713224e318c7
# ╟─7d29b0b7-f561-4c12-a13c-711893c94ddf
# ╠═905993bd-214c-41a4-9053-aeed890b4d92
# ╠═ca14751b-0a59-4117-b87f-4ed1b359abb1
# ╠═f69a7bce-d35c-4dbe-9f74-852a81ba5d9f
# ╠═ba10f3f6-7a47-4ebd-9559-65f230d74081
# ╟─d12ab940-f56a-49e0-bedf-b341f2124bc5
# ╠═d5cdfb4b-fb30-409c-80db-f8ce765eb2f3
# ╟─effa7095-1691-4873-9cd6-3741c9343f3c
# ╠═1f4624f7-b747-49ba-a2ab-209e596f25b5
# ╠═c2dd8786-f17f-47d9-9187-f6e84c1b72ee
# ╠═9f1983a9-cda2-431f-94b4-30f4535dba17
# ╠═d6f81c51-0249-426a-99e7-72bae282411c
# ╠═d293a0b8-3db8-4e8f-a5dc-3b0d0d388fbe
# ╠═059b137a-a5ff-4b9e-935b-b00effdf0a9f
