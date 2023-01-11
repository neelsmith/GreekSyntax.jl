

"""Find number of tokens from `tkn` to its syntactic connection.
$(SIGNATURES). 
"""
function distance(tkn::TokenAnnotation, sentence::SentenceAnnotation, tknlist::Vector{TokenAnnotation})::Union{Int, Nothing}
    lex = lexicalforsentence(sentence, tknlist)
	if isnothing(tkn.node1) || tkn.node1 == "nothing" 
		nothing
	else
		tokenindex = findfirst(t -> t == tkn, lex)
	
	
		relatedindex =  parse(Int, tkn.node1)
		if relatedindex == 0
			nothing
		else
			@debug("Token $(tkn.text) is at position $(tokenindex) and connected to $(tkn.node1) $(lex[relatedindex].text) by $(tkn.node1relation)")
			tokenindex - relatedindex |> abs
		end
	end
end

"""Find number of tokens between `tkn` and its syntactic connection.
$(SIGNATURES). 
"""
function displacement(tkn::TokenAnnotation, s::SentenceAnnotation,  tknlist::Vector{TokenAnnotation})
	distance(tkn, s, tknlist) - 1
end

