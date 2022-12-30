
function formatsentenceBW(sa::SentenceAnnotation, tkns)
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
end;