### A Pluto.jl notebook ###
# v0.19.18

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

end

# ╔═╡ 2a2d0160-8794-11ed-23a7-0d6ff795640e
md"""# Dev. notebook"""

# ╔═╡ 31fc979d-121f-456e-a963-713224e318c7
md"""> ### Two things we'll need
>
> - a tokenized corpus
> - a sequence of sentence ranges (annotation candidates)


"""

# ╔═╡ ba10f3f6-7a47-4ebd-9559-65f230d74081
sentencepairs = begin
	f = joinpath(repo, "test", "data", "lysias1.cex")
	c = fromcex(f, CitableTextCorpus, FileReader)
	parsesentences(c, ortho = literaryGreek())
end

# ╔═╡ 905993bd-214c-41a4-9053-aeed890b4d92
tcorpus = tokenize(c, literaryGreek())

# ╔═╡ 52ef9b1a-5b30-4b4e-8168-69a4807757e5
md"""> Typing named tuples"""

# ╔═╡ 7394f724-01fa-422a-b426-65949f8eed62
pr = tokenize(c, literaryGreek())[1] # |> typeof <: TokenCategory

# ╔═╡ b2a7fb60-cdb8-4319-bc6c-b2d0fa902c1a
pr |> typeof

# ╔═╡ 1c92113a-089e-4311-be7a-f8ff1b337399
mytkntup = Tuple{CitablePassage,TokenCategory}[]

# ╔═╡ bc050830-5416-4a91-a176-df77f3ed63cf
push!(mytkntup, pr)

# ╔═╡ dc2379b8-0d04-4023-8914-9e986d9ffe81
sentencepairs[1] |> typeof

# ╔═╡ 01787bcc-a741-43ae-886a-c4d4feaed6a4
tupmanual = NamedTuple{(:urn, :sequence), Tuple{CtsUrn, Int64}}[]

# ╔═╡ 1614daae-9d09-4611-818b-9faf6537b862
typeof(tupmanual)

# ╔═╡ 54794592-6ced-4a45-be97-c7692c33d942
begin
	push!(tupmanual, (urn = CtsUrn("urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.1.1-1.1.60"), sequence = 2))
	tupmanual
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

# ╔═╡ 330075de-5116-4de9-823e-4602e3c23ce9

function parsethis(v::Vector{Tuple{CitablePassage,TokenCategory}}; ortho::T,	terminators = [".", ":", ";"]) where T <: OrthographicSystem
	sentenceindex =  []

	currenttext = c.passages[1].urn |> droppassage
	sentencecount = 0
	rangeopener = ""
	for tkn in v
		if droppassage(tkn[1].urn) != currenttext
			currenttext = droppassage(tkn[1].urn)
            sentencecount = 0
			if ! isempty(rangeopener)
                rangeu = addpassage(currenttext, string(rangeopener, "-", 	passagecomponent(n[1].urn)))
            end
		end

		if tkn[1].text in terminators
			sentencecount = sentencecount + 1
			if isempty(rangeopener)
                @error("Syntax error: empty sentence at token $(n)")
            end

			rangeu = addpassage(currenttext, string(rangeopener, "-", 	passagecomponent(tkn[1].urn)))
			push!(sentenceindex, (urn = rangeu, sequence = sentencecount))
			
		else
			if isempty(rangeopener)
				rangeopener = passagecomponent(tkn[1].urn)
			end
		end
	
	end
	sentenceindex
end

# ╔═╡ d5d53192-5e5a-4511-950b-2e56927add85
parsethis(tupmanual, ortho = literaryGreek())

# ╔═╡ Cell order:
# ╟─d3d708ea-5a63-4c9e-9fc2-6801ada726e0
# ╠═a4471683-d5cd-4ca4-9f3b-c582427f473b
# ╟─2a2d0160-8794-11ed-23a7-0d6ff795640e
# ╟─31fc979d-121f-456e-a963-713224e318c7
# ╟─905993bd-214c-41a4-9053-aeed890b4d92
# ╠═ba10f3f6-7a47-4ebd-9559-65f230d74081
# ╟─52ef9b1a-5b30-4b4e-8168-69a4807757e5
# ╠═7394f724-01fa-422a-b426-65949f8eed62
# ╠═b2a7fb60-cdb8-4319-bc6c-b2d0fa902c1a
# ╠═1c92113a-089e-4311-be7a-f8ff1b337399
# ╠═bc050830-5416-4a91-a176-df77f3ed63cf
# ╠═dc2379b8-0d04-4023-8914-9e986d9ffe81
# ╠═01787bcc-a741-43ae-886a-c4d4feaed6a4
# ╠═1614daae-9d09-4611-818b-9faf6537b862
# ╠═54794592-6ced-4a45-be97-c7692c33d942
# ╟─d12ab940-f56a-49e0-bedf-b341f2124bc5
# ╠═059b137a-a5ff-4b9e-935b-b00effdf0a9f
# ╠═d5d53192-5e5a-4511-950b-2e56927add85
# ╠═330075de-5116-4de9-823e-4602e3c23ce9
