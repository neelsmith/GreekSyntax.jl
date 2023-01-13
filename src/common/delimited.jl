
function readdelimited(v::Vector{T}) where T <: AbstractString
    #; ortho::{O <: OrthographicSystem} ) #where T <: AbstractString, O <: OrthographicSystem
    nocomments = filter(ln -> ! startswith(ln, "//"), v)

    sentences = SentenceAnnotation[]
    vus = VerbalUnitAnnotation[]
    tokens = TokenAnnotation[]

    currentblock = ""
    headerseen = false
    for ln in filter(l -> ! isempty(l), nocomments)
        if startswith(ln, "#!")
            currentblock = ln
            headerseen = false
            @debug("Current block now $(currentblock)")
        
        elseif headerseen == false
            headerseen = true
        else
            if currentblock == "#!sentences"
                push!(sentences, sentence(ln))
            elseif currentblock == "#!verbal_units"
                push!(vus, verbalunit(ln))
            elseif currentblock == "#!tokens"
                push!(tokens, token(ln))
            else
                @error("Syntax error in delimited-text file: unrecognized context for line $(ln)")
            end
        end
    end
    (sentences, vus, tokens)
end


"""Compose delimited-text representation of a DataFrame with annotations
about verbal units. 
`df` is a DataFrame with four fields for verbal unit ID, semantic type,
syntactic type and depth of subordination.
$(SIGNATURES)
"""
function vucex(df; delimiter = "|")
	hdr = "vuid|semantic_type|syntactic_type|depth"
	lines = ["#!verbal_unit", hdr]
	
	for row in eachrow(df)	
		push!(lines, 
			join([row.passage, 		
				lowercase(row.semantic_type),
				lowercase(row.syntactic_type),
				row.depth], 
				delimiter))
	end
	join(lines, "\n")
	
end


"""Compose delimited-text representation of annotations about a sentence. 
`df` is a DataFrame with four fields for verbal unit ID, semantic type,
syntactic type and depth of subordination.
$(SIGNATURES)
"""
function sentencecex(s; delimiter = "|")
	senturn = sentencerange(s)
	hdr = "sentence$(delimiter)connector"
	lines = ["#!sentences", hdr]
	if isnothing(connectorid) 
		push!(lines, string(senturn, delimiter, nothing) )
	else
		connectorurn = sentence[connectorid][1].urn
		push!(lines, string(senturn, delimiter, connectorurn))
	end
	join(lines, "\n")
end    