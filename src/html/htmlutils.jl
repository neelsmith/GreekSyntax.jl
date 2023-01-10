# RGB list to cycle through in assigning colors to groups.
defaultpalette = [
	"#79A6A3",
	"#E5B36A",
	"#C7D7CA",
	"#E7926C",
	"#D29DC0",
	"#C2D6C4",
	"#D291BC",
	"E7DCCA",
	"#FEC8D8",
	"#F5CF89",
	"#F394AF"
]

"""Compose HTML string for tokens included  in `u`.
$(SIGNATURES)
"""
function htmltext(u::CtsUrn, sentencelist::Vector{SentenceAnnotation}, tknannotations::Vector{TokenAnnotation}; 
	sov = true, vucolor = true, colors = defaultpalette, syntaxtips = false)

	# Build up HTML strings here:
	formatted = ["<div class=\"passage\">",
	"<span class=\"ref\">$(passagecomponent(u))</span>"
	]
	currentcontainer = nothing
	for sentence in sentencesforurn(u, sentencelist, tknannotations)
		push!(formatted, htmltext(sentence, tknannotations, sov = sov, vucolor = vucolor, colors = colors, syntaxtips = syntaxtips))
	end
	push!(formatted, "</div>")
	join(formatted, "\n")
end

function tipsfortoken(t::TokenAnnotation, tkns::Vector{TokenAnnotation}, isconnector::Bool)
	if isconnector
		"tool-tips=\"Connects sentence to context.\""
	elseif t.node1relation == "nothing" || isnothing(t.node1relation)
		""
	else
		related = tkns[parse(Int, t.node1)]
		"tool-tips=\"Related to $(related.text): $(t.node1relation).\""
	end
end

"""Compose string for a token, wrapping lexical tokens in an HTML `span`. 
Based on lexical type and context indicated by `inprefix` flag, prefixes the resulting string with a leading space or not.
$(SIGNATURES)
"""
function htmltoken(t::TokenAnnotation, lextokens::Vector{TokenAnnotation}, inprefix::Bool, connectingword::Bool, add_sov::Bool, add_color::Bool; colors = defaultpalette, syntaxtips = false)
	if t.tokentype == "lexical"			
		classes = add_sov ? classesfortoken(t, connectingword, syntaxtips = syntaxtips) : ""
		styles = add_color ? groupcolorfortoken(t, colors = colors) : ""
		tips = syntaxtips ? tipsfortoken(t, lextokens, connectingword) : ""
		if inprefix
			"<span $(classes) $(styles) $(tips)>"  * t.text * "</span>"
		else
			" <span $(classes) $(styles)  $(tips)>"  * t.text * "</span>"
		end

	else
		if occursin(t.text,PolytonicGreek.prefixpunctuation())
			" " * t.text
		else
			t.text
		end
	end
end

"""Compose HTML string for the annotated sentence `sa` using
data from a vector of token annotations.  Boolean flags for `sov`
and `vucolor` provoke CSS additions for Subject-Object-Verb highlight,
and for color coding by verbal unit.
$(SIGNATURES)
"""
function htmltext(sa::SentenceAnnotation, tknannotations::Vector{TokenAnnotation}; sov = true, vucolor = true, colors = defaultpalette, syntaxtips = false)
	# Build up HTML strings here:
	formatted = []

	(sentencetokens, connectorids, origin) = tokeninfoforsentence(sa, tknannotations)
	lexical = filter(t -> t.tokentype == "lexical", sentencetokens)
	prefixedpunct = false
	tknidx = origin - 1
	for t in sentencetokens
		tknidx = tknidx + 1
		isconnector = tknidx in connectorids
		spanstr = htmltoken(t, lexical, prefixedpunct, isconnector, sov, vucolor, colors = colors, syntaxtips = syntaxtips)
		push!(formatted, spanstr)

		if t.tokentype == "lexical"			
			prefixedpunct = false
		elseif occursin(t.text,PolytonicGreek.prefixpunctuation())
			prefixedpunct = true
		end
	end
	join(formatted,"")
end

"""Compose HTML string for the annotated sentence `sa` indented by level of subordination.
Formatting relies on data from a vector of token annotations and annotations on verbal units.
$(SIGNATURES)
"""
function htmltext_indented(sa::SentenceAnnotation, 	groups::Vector{VerbalUnitAnnotation}, tknannotations::Vector{TokenAnnotation};
	sov = true, vucolor = true, palette = defaultpalette, syntaxtips = false)
	# Vector where we'll collect HTML strings:
	indentedtext = ["<div class=\"passage\"><blockquote class=\"subordination\">"]

	(sentencetokens, connectorids, origin) = GreekSyntax.tokeninfoforsentence(sa, tknannotations)
	lexical = filter(t -> t.tokentype == "lexical", sentencetokens)
	prefixedpunct = false
	tknidx = origin - 1
	currindent = 0
	currgroup = ""
	for t in sentencetokens
		tknidx = tknidx + 1
		isconnector = tknidx in connectorids
		
		vumatches = filter(groups) do vu
			vu.id == t.verbalunit
		end
		if isempty(vumatches)
			@debug("No match found for verbal unit $(t.verbalunit)")

		else
			spanstr = htmltoken(t, lexical, prefixedpunct, isconnector, sov, vucolor, colors = palette)
			matchingdepth = vumatches[1].depth
			matchinggroup = vumatches[1].id


			if currindent == matchingdepth &&  currgroup == matchinggroup
				push!(indentedtext, spanstr)
		
			else
				if (currindent != 0)
					push!(indentedtext, repeat("</blockquote>", currindent))
				end
				push!(indentedtext,  repeat("<blockquote class=\"subordination\">", matchingdepth) * "<span class=\"ref\">$(matchingdepth)</span> " * " "  )
				currindent = matchingdepth
				currgroup = matchinggroup

				push!(indentedtext, spanstr)
			end
		end
		if t.tokentype == "lexical"			
			prefixedpunct = false
		elseif occursin(t.text,PolytonicGreek.prefixpunctuation())
			prefixedpunct = true
		end
	end
	push!(indentedtext,"</blockquote></div>")
	join(indentedtext)
end

"""Compose an HTML span for the verbal annotation `vu`.
$(SIGNATURES)
"""
function htmlgroup(vu::VerbalUnitAnnotation; palette = defaultpalette)
	color = groupcolor(vu, colors = palette)
	"<span style=\"color: $(color);\">$(vu.syntactic_type)</span> (level $(vu.depth),  $(vu.semantic_type) verb)"
end

"""Compose an HTML ordered list for verbal units belonging to sentence `sa`.
$(SIGNATURES)
"""
function htmlgrouplist(sa::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation}; palette = defaultpalette)
	htmlgrouplist(groupsforsentence(sa, groups), palette = palette)
end

"""Compose an HTML ordered list for the verbal annotations `vulist`.
$(SIGNATURES)
"""
function htmlgrouplist(vulist::Vector{VerbalUnitAnnotation}; palette = defaultpalette)
	outputlines = ["<ol>"]
	for  vu in vulist
		push!(outputlines, string("<li>", htmlgroup(vu, palette = palette),"</li>" ))
	end
	push!(outputlines, "</ol>")
	join(outputlines, "\n")
end

"""Compose an HTML unordered list illustrating each CSS class
used in marking `span` elements.
$(SIGNATURES)
"""
function sovkey()
    """
<ul>
<li><span class="connector">connecting words</span>
<li><span class="verb">unit verb</span>
<li><span class="subject">subject</span>
<li><span class="object">object</span>
</ul>
"""
end

"""Compose an HTML class attribute for a lexical token.
$(SIGNATURES)
"""
function classesfortoken(t::TokenAnnotation, isconnector; syntaxtips = false)
	opts = []
	if isconnector
		push!(opts, "connector")
	end
	if syntaxtips
		push!(opts, "tooltip")
	end
	if isnothing(t.node1relation)
		#skip
	else
		rel1 = lowercase(t.node1relation)
		if rel1 == "subject"
			push!(opts, "subject")
			
		elseif rel1 == "object"
			push!(opts, "object")
			
		elseif rel1 == "unit verb"
			push!(opts, "verb")
		end
	end
	string("class=\"", join(opts, " "), "\"")
end


"""Select a color to use for item `idx` by 
mod'ing a list of colors.  Add one to avoid
zero indexes.
$(SIGNATURES)
"""
function groupcolorforint(idx::Int; colors = defaultpalette)
	if idx == 0
		""
	else
		modded = mod(length(colors), idx) + 1
		colors[modded]
	end
end

"""Choose a color from a list of colors based on group number component of
the token's verbal unit identifier.
$(SIGNATURES)
"""
function groupcolorfortoken(tkn::TokenAnnotation; colors = defaultpalette)
	if isnothing(tkn.verbalunit) ||	endswith(tkn.verbalunit, "nothing") || endswith(tkn.verbalunit, ".0")
		""
	else
		rgb = groupcolor(tkn.verbalunit, colors = colors)
		"style=\"color: $(rgb)\""
	end
end

"""Choose a color from a list of colors based on the convention of ending the identifier
for a `VerbalUnitAnnotation` with a number.
$(SIGNATURES)
"""
function groupcolor(vu::VerbalUnitAnnotation; colors = defaultpalette)
	groupcolor(vu.id, colors = colors)
end

"""Choose a color from a list of colors based on the convention of ending the identifier
for a `VerbalUnitAnnotation` with a number.
$(SIGNATURES)
"""
function groupcolor(groupid::T; colors = defaultpalette) where T <: AbstractString
	re = r".+\."
	digits = replace(groupid, re => "")
	idx = parse(Int, digits) 
	groupcolorforint(idx, colors = colors)
end

