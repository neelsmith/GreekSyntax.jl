

"""Find number of tokens from `tkn` to its syntactic connection.
$(SIGNATURES). 
"""
function distance(tkn::TokenAnnotation, sentence::SentenceAnnotation, tknlist::Vector{TokenAnnotation})::Union{Int, Nothing}
    lex = lexicalforsentence(sentence, tknlist)
	if isnothing(tkn.node1) || tkn.node1 == "nothing" 
		nothing
	else
		tokenindex = findfirst(t -> t == tkn, lex)
	
	
		relatedindex = tkn.node1
		if isnothing(tokenindex) || relatedindex == 0
			nothing
		else
			@debug("Token $(tkn.text) is at position $(tokenindex) and connected to $(tkn.node1) $(lex[relatedindex].text) by $(tkn.node1relation)")
			tokenindex - relatedindex |> abs
		end
	end
end

"""Find number of tokens from `tkn` to its syntactic connection.
$(SIGNATURES). 
"""
function distance(tkn::TokenAnnotation, groups::Vector{VerbalUnitAnnotation}, sentences::Vector{SentenceAnnotation}, tknlist::Vector{TokenAnnotation})
	s = sentencefortoken(tkn, groups, sentences)
	distance(tkn, s, tknlist)
end

"""Find number of tokens between `tkn` and its syntactic connection.
$(SIGNATURES). 
"""
function displacement(tkn::TokenAnnotation, s::SentenceAnnotation,  tknlist::Vector{TokenAnnotation})
	dist = distance(tkn, s, tknlist)
	isnothing(dist) ? nothing : dist - 1
end

"""Find number of tokens between `tkn` and its syntactic connection.
$(SIGNATURES). 
"""
function displacement(tkn::TokenAnnotation, groups::Vector{VerbalUnitAnnotation}, sentences::Vector{SentenceAnnotation}, tknlist::Vector{TokenAnnotation})
	s = sentencefortoken(tkn, groups, sentences)
	displacement(tkn, s, tknlist)
end