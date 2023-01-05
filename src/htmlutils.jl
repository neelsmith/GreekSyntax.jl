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

"""Compose HTML string for the annotated sentence `sa` using
data from a vector of token annotations.  Boolean flags for `sov`
and `vucolor` provoke CSS additions for Subject-Object-Verb highlight,
and for color coding by verbal unit.
$(SIGNATURES)
"""
function htmltext(sa::SentenceAnnotation, tknannotations::Vector{TokenAnnotation}; sov = true, vucolor = true, colors = defaultpalette)
	
	# HTML strings:
	formatted = []
	(sentencetokens, connectorids, origin) = tokeninfoforsentence(sa, tknannotations)

	tknidx = origin - 1
	for t in sentencetokens
		tknidx = tknidx + 1

		if t.tokentype == "lexical"			
			isconnector = tknidx in connectorids
			classes = sov ? classesfortoken(t, isconnector) : ""
			styles = vucolor ? groupcolorfortoken(t, colors = colors) : ""
			
			push!(formatted, " <span $(classes) $(styles)>"  * t.text * "</span>")
			
		else
			push!(formatted, t.text)
		end
	end
	join(formatted,"")
end


"""Compose HTML string for the annotated sentence `sa` indented by level of subordination.
Formatting relies on data from a vector of token annotations and annotations on verbal units.
$(SIGNATURES)
"""
function htmltext_indented(sa::SentenceAnnotation, 	groups::Vector{VerbalUnitAnnotation}, tknannotations::Vector{TokenAnnotation};
	sov = true, vucolor = true, palette = defaultpalette)
	# HTML strings:
	indentedtext = ["<blockquote class=\"subordination\">"]

	(sentencetokens, connectorids, origin) = GreekSyntax.tokeninfoforsentence(sa, tknannotations)

	local currindent = 0
	tknidx = origin - 1
	for t in sentencetokens
		tknidx = tknidx + 1
		isconnector = tknidx in connectorids
		classes = sov ? GreekSyntax.classesfortoken(t, isconnector) : ""
		styles = vucolor ? groupcolorfortoken(t, colors = palette) : ""
		
		vumatches = filter(groups) do vu
			vu.id == t.verbalunit
		end
		
		if isempty(vumatches)
			@warn("No match found for verbal unit $(t.verbalunit)")
		else
			matchingdepth = vumatches[1].depth
			if currindent == matchingdepth
				#push!(indentedtext, " $(t.text)")
				if t.tokentype == "lexical"			
					push!(indentedtext, " <span $(classes) $(styles)>"  * t.text * "</span>")
				else
					push!(indentedtext, " $(t.text)")
				end
				
		
			else
				if (currindent != 0)
					push!(indentedtext, repeat("</blockquote>", currindent))
				end
				push!(indentedtext,  repeat("<blockquote class=\"subordination\">", matchingdepth) * "<span class=\"ref\">$(matchingdepth)</span> " * " "  )
				currindent = matchingdepth

				
				#push!(indentedtext, " $(t.text)")
				
				if t.tokentype == "lexical"			
					push!(indentedtext, " <span $(classes) $(styles)>"  * t.text * "</span>")
				else
					push!(indentedtext, " $(t.text)")
				end
			end
		end
	end
	push!(indentedtext,"</blockquote>")
	join(indentedtext)
end


"""Compose an HTML span for the verbal annotation `vu`.
$(SIGNATURES)
"""
function htmlgroup(vu::VerbalUnitAnnotation; palette = defaultpalette)
	color = groupcolor(vu, colors = palette)
	"<span style=\"color: $(color);\">$(vu.syntactic_type)</span> ($(vu.semantic_type) verb)"
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
	for vu in vulist
		push!(outputlines, string("<li>", htmlgroup(vu, palette = palette),"</li>" ))
	end
	push!(outputlines, "</ol>")
	join(outputlines, "\n")
end


"""Compose an HTML class attribute for a lexical token.
$(SIGNATURES)
"""
function classesfortoken(t::TokenAnnotation, isconnector)
	opts = []
	if isconnector
		push!(opts, "connector")
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
	modded = mod(length(colors), idx) + 1
	colors[modded]
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

