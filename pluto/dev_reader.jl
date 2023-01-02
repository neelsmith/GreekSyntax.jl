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

	using Kroki

	using PlutoUI 
	Pkg.status()
	md"""*Environment set up is in this cell*."""
end

# ╔═╡ 2a2d0160-8794-11ed-23a7-0d6ff795640e
md"""# Dev. notebook: syntactic reader"""

# ╔═╡ 8c4abe4f-113e-4519-8c55-85aa128a4728
md""" ##### Three things we need to read syntactically annotated texts

1. sentences
2. verbal units
3. annotated tokens

We can get all of that in one shot with the `readdelimited` function.

""" 

# ╔═╡ 0471aaa8-9a5d-47ca-a7a5-7612c6f86b81
(sentences, vus, syntokens) = begin
	notescex = joinpath(repo, "test", "data", "lysias1_selection.cex") |> readlines
	readdelimited(notescex)
end

# ╔═╡ 9d4cdefa-8119-4255-b13d-7c1828fd318c
md"""#### A syntactically aware reader in a handful of Pluto cells"""

# ╔═╡ 241dea49-45f2-498c-9fab-f020378969a0
begin

	md"""*Choose a sentence by sequence number* $(@bind annsentseq confirm(NumberField(0:length(sentences))))"""
end

# ╔═╡ eeaf2e50-a70b-4113-a85e-66b224aa3356
begin
displaymenu = ["continuous" => "continuous text", "indented" => "indented for subordination"
	]
	md"""*Display* $(@bind txtdisplay Select(displaymenu)) 
	
*Highlight SOV+ functions* $(@bind sov CheckBox()) *Color verbal units* $(@bind vucolor CheckBox()) *Include syntax diagram* $(@bind diagram CheckBox(true))
"""
end

# ╔═╡ 04ebcdec-b7c1-4d48-9774-b8e36fd9da10
begin
	if annsentseq > 0
		"<p><i>Verbal groups</i>:</p>" * htmlgrouplist(sentences[annsentseq], vus) |> HTML
	end
end

# ╔═╡ 2a17467a-56ea-49d5-927a-0359a098f2e1
# ╠═╡ show_logs = false
if annsentseq > 0
	if txtdisplay == "continuous"
		rendered = htmltext(sentences[annsentseq], syntokens; sov = sov, vucolor = vucolor)
		HTML(rendered)
	else
		rendered = htmltext_indented(sentences[annsentseq], vus, syntokens; sov = sov, vucolor = vucolor)

		HTML(rendered)
		
	end
	
end

# ╔═╡ a5b2760b-70b0-415e-8f65-31f3b4d48a3f
if annsentseq > 0
	graphstr  = mermaiddiagram(sentences[annsentseq], syntokens)
end

# ╔═╡ e1d6eda6-2f6f-4b78-bf6d-05081c980145
	if annsentseq > 0 && diagram
		mermaid"""$(graphstr)"""
	end

# ╔═╡ 8fac0e83-ecd0-4d04-95f3-e72a520dbd25
md"""> ##### Visual formatting: CSS and  vector of colors for highlighting groups"""

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

# ╔═╡ Cell order:
# ╟─d3d708ea-5a63-4c9e-9fc2-6801ada726e0
# ╟─a4471683-d5cd-4ca4-9f3b-c582427f473b
# ╟─2a2d0160-8794-11ed-23a7-0d6ff795640e
# ╟─8c4abe4f-113e-4519-8c55-85aa128a4728
# ╟─0471aaa8-9a5d-47ca-a7a5-7612c6f86b81
# ╟─9d4cdefa-8119-4255-b13d-7c1828fd318c
# ╟─241dea49-45f2-498c-9fab-f020378969a0
# ╟─eeaf2e50-a70b-4113-a85e-66b224aa3356
# ╟─04ebcdec-b7c1-4d48-9774-b8e36fd9da10
# ╟─2a17467a-56ea-49d5-927a-0359a098f2e1
# ╟─e1d6eda6-2f6f-4b78-bf6d-05081c980145
# ╟─a5b2760b-70b0-415e-8f65-31f3b4d48a3f
# ╟─8fac0e83-ecd0-4d04-95f3-e72a520dbd25
# ╟─0d945905-cdbf-4253-b5bf-bbe58a3ea5a5
# ╟─fdfeae81-e007-482c-98c4-af9295b45f90
