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
	Pkg.status()
end

# ╔═╡ 2a2d0160-8794-11ed-23a7-0d6ff795640e
md"""# Dev. notebook"""

# ╔═╡ 8c4abe4f-113e-4519-8c55-85aa128a4728
md"""> ### What we'll need to read syntactically annotated texts
>
> Read from a CEX file with annotations:
> 
> 1. sentences
> 2. verbal units
> 3. annotated tokens
>
> We can get all of that in one shot with the `readdelimited` function.

"""

# ╔═╡ 0471aaa8-9a5d-47ca-a7a5-7612c6f86b81
(sentences, vus, syntokens) = begin
	notescex = joinpath(repo, "test", "data", "lysias1_selection.cex") |> readlines
	readdelimited(notescex)
end

# ╔═╡ fdfeae81-e007-482c-98c4-af9295b45f90
palette = ["#79A6A3;",
	"#E5B36A;",
	"#C7D7CA;",
	"#E7926C;",
	"#D29DC0;",
	"#C2D6C4;",
	"#D291BC;",
	"E7DCCA;",
	"#FEC8D8;",
	"#F5CF89;",
	"#F394AF;"
]

# ╔═╡ 0d945905-cdbf-4253-b5bf-bbe58a3ea5a5
 css = begin
 css_text = """
<style>
  blockquote.subordination {
 	padding: 0em;
 
 }
 
 .connector {
 background: yellow;  
 font-style: bold;
}

.subject {
 	text-decoration: underline;
 	text-decoration-thickness: 3px;
}
.object {
 	text-decoration: underline;
 	text-decoration-style: wavy;
 }
 .verb {
 	border: thin solid black;
 	padding: 1px 3px;
 	
 }
 
span.tooltip{
  position: relative;
  display: inline;
}
span.tooltip:hover:after{ visibility: visible; opacity: 0.8; bottom: 20px; }
span.tooltip:hover:before{ visibility: visible; opacity: 0.8; bottom: 14px; }

span.tooltip:after{
  display: block;
  visibility: hidden;
  position: absolute;
  bottom: 0;
  left: 50%;
  opacity: 0.9;
  content: attr(tool-tips);
  height: auto;
  width: auto;
  min-width: 100px;
  padding: 5px 8px;
  z-index: 999;
  color: #fff;
  text-decoration: none;
  text-align: center;
  background: rgba(0,0,0,0.85);
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
  border-radius: 5px;
}
span.tooltip:before {
  position: absolute;
  visibility: hidden;
  width: 0;
  height: 0;
  left: 50%;
  bottom: 0px;
  opacity: 0;
  content: "";
  border-style: solid;
  border-width: 6px 6px 0 6px;
  border-color: rgba(0,0,0,0.85) transparent transparent transparent;
}
 """
	 HTML(css_text)
 end

# ╔═╡ 241dea49-45f2-498c-9fab-f020378969a0
begin

	md"""*Choose a sentence by sequence number* $(@bind annsentseq confirm(NumberField(0:length(sentences))))"""
end

# ╔═╡ eeaf2e50-a70b-4113-a85e-66b224aa3356
begin
displaymenu = ["continuous" => "continuous text", "indented" => "indented for subordination"
	]
	md"""*Display* $(@bind txtdisplay Select(displaymenu)) *Highlight SOV+ functions* $(@bind sov CheckBox()) *Color verbal units* $(@bind vucolor CheckBox()) *Add tooltips* $(@bind tippy CheckBox())
"""
end

# ╔═╡ 2a17467a-56ea-49d5-927a-0359a098f2e1
# ╠═╡ show_logs = false
if annsentseq > 0
	if txtdisplay == "continuous"
		rendered = htmltext(sentences[annsentseq], syntokens; sov = sov, vucolor = vucolor)
		HTML(rendered)
	else
		rendered = htmltext_indented(sentences[annsentseq], vus, syntokens)#; sov = sov, vucolor = vucolor)

		HTML(rendered)
		
	end
	
end

# ╔═╡ 31fc979d-121f-456e-a963-713224e318c7
md"""> ### Three things we'll need for editing annotations
>
> - a vector of analyzed tokens
> - a tokenized corpus (the citable passages of the analyzed tokens, as a corpus)
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

# ╔═╡ ba10f3f6-7a47-4ebd-9559-65f230d74081
sentencepairs = parsesentences(c, literaryGreek())


# ╔═╡ d12ab940-f56a-49e0-bedf-b341f2124bc5
md"""> Formatting a vector of tokens"""

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

# ╔═╡ Cell order:
# ╟─d3d708ea-5a63-4c9e-9fc2-6801ada726e0
# ╠═a4471683-d5cd-4ca4-9f3b-c582427f473b
# ╟─2a2d0160-8794-11ed-23a7-0d6ff795640e
# ╟─8c4abe4f-113e-4519-8c55-85aa128a4728
# ╠═0471aaa8-9a5d-47ca-a7a5-7612c6f86b81
# ╟─fdfeae81-e007-482c-98c4-af9295b45f90
# ╟─0d945905-cdbf-4253-b5bf-bbe58a3ea5a5
# ╟─241dea49-45f2-498c-9fab-f020378969a0
# ╟─eeaf2e50-a70b-4113-a85e-66b224aa3356
# ╟─2a17467a-56ea-49d5-927a-0359a098f2e1
# ╟─31fc979d-121f-456e-a963-713224e318c7
# ╠═7d29b0b7-f561-4c12-a13c-711893c94ddf
# ╠═905993bd-214c-41a4-9053-aeed890b4d92
# ╠═ca14751b-0a59-4117-b87f-4ed1b359abb1
# ╟─ba10f3f6-7a47-4ebd-9559-65f230d74081
# ╟─d12ab940-f56a-49e0-bedf-b341f2124bc5
# ╠═effa7095-1691-4873-9cd6-3741c9343f3c
# ╠═1f4624f7-b747-49ba-a2ab-209e596f25b5
# ╠═c2dd8786-f17f-47d9-9187-f6e84c1b72ee
