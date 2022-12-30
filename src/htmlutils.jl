"""Compose HTML string for the annotated sentence `sa` using
data from a vector of token annotations.  Boolean flags for `sov`
and `vucolor` provoke CSS additions for Subject-Object-Verb highlight,
and for color coding by verbal unit.
$(SIGNATURES)
"""
function htmltext(sa::SentenceAnnotation, tknannotations::Vector{TokenAnnotation}; sov = true, vucolor = true, palette = [])
	colors = isempty(palette)  ? ["#79A6A3;", "#E5B36A;", "#C7D7CA;", "#E7926C;", "#D29DC0;", "#C2D6C4;", "#D291BC;", "E7DCCA;", "#FEC8D8;", "#F5CF89;","#F394AF;"] : palette

	# HTML strings:
	formatted = []
	(sentencetokens, connectorids, origin) = tokensforsentence(sa, tknannotations)

	tknidx = origin - 1
	for t in sentencetokens
		tknidx = tknidx + 1

		if t.tokentype == "lexical"			
			isconnector = tknidx in connectorids
			classes = sov ? classesfortoken(t, isconnector) : ""
			styles = vucolor ? groupcolorfortoken(t, colors) : ""
			
			push!(formatted, " <span $(classes) $(styles)>"  * t.text * "</span>")
			
		else
			push!(formatted, t.text)
		end
	end
	join(formatted,"")
end



"""Compose an HTML class attribute for lexical tokens.
$(SIGNATURES)
"""
function classesfortoken(t, isconnector)
	opts = []
	if isconnector
		push!(opts, "connector")
	end
	rel1 = lowercase(t.node1relation)
	if rel1 == "subject"
		push!(opts, "subject")
		
	elseif rel1 == "object"
		push!(opts, "object")
		
	elseif rel1 == "unit verb"
		push!(opts, "verb")
	end
		
	string("class=\"", join(opts, " "), "\"")
end

"""Choose a color from a list of colors based on group number component of
the token's verbal unit identifier.
$(SIGNATURES)
"""
function groupcolorfortoken(tkn, colors)
	re = r".+\."
	if endswith(tkn.verbalunit, "nothing") || endswith(tkn.verbalunit, ".0")
		""
	else
		digits = replace(tkn.verbalunit, re => "")
		idx = parse(Int, digits) 
		modded = mod(length(colors), idx) + 1
		"style=\"color: $(colors[modded])\""
	end
end



"""Compose HTML string for the annotated sentence `sa` indented by level of subordination.
Formatting relies on data from a vector of token annotations and annotations on verbal units.
$(SIGNATURES)
"""
function htmltext_indented(sa::SentenceAnnotation, 	groups::Vector{VerbalUnitAnnotation}, tknannotations::Vector{TokenAnnotation};
	sov = true, vucolor = true, palette = [])
	   colors = isempty(palette)  ? ["#79A6A3;", "#E5B36A;", "#C7D7CA;", "#E7926C;", "#D29DC0;", "#C2D6C4;", "#D291BC;", "E7DCCA;", "#FEC8D8;", "#F5CF89;","#F394AF;"] : palette
   
	   # HTML strings:
	   indentedtext = ["<blockquote class=\"subordination\">"]
   
	   (sentencetokens, connectorids, origin) = GreekSyntax.tokensforsentence(sa, tknannotations)
   
   
	   local currindent = 0
	   tknidx = origin - 1
	   for t in sentencetokens
		   tknidx = tknidx + 1
		   isconnector = tknidx in connectorids
		   classes = sov ? GreekSyntax.classesfortoken(t, isconnector) : ""
		   styles = vucolor ? GreekSyntax.groupcolorfortoken(t, colors) : ""
		   
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
				   push!(indentedtext,  repeat("<blockquote class=\"subordination\">", matchingdepth) * "<strong>$(matchingdepth)</strong>. " * " "  )
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