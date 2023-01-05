
"""Compose a string value for type of token, for use in
writing delimited-text representation of annotations.
"""
function typelabel(tkntype)
	if string(typeof(tkntype)) == "Orthography.LexicalToken"
		"lexical"
	elseif string(typeof(tkntype)) == "Orthography.PunctuationToken"
		"punctuation"
	elseif string(typeof(tkntype)) == "Orthography.UnanalyzedToken"
		"unanalyzed"
	else
		"unrecognized"
	end
end




"""Find index in a vector sentence annotations of the sentence
containing the token identified by CtsUrn `leafnode`.
$(SIGNATURES)
"""
function sentenceindexfornode(leafnode::CtsUrn, sentences::Vector{SentenceAnnotation}, tknannotations::Vector{TokenAnnotation})::Int
	groupedtokens = []
	for (i, s) in enumerate(sentences)
		(sentencetkns, connection, origin) = tokeninfoforsentence(s, tknannotations)
		urnstrings = map(t -> string(t.urn), sentencetkns) 	
		push!(groupedtokens, (index = i, ids = urnstrings))
	end
	matches = filter(groupedtokens) do grp
		string(leafnode) in grp[2]
	end
	
	if length(matches) == 1
		matches[1].index
	else
		@warn("Failed to find unique match for $(leafnode).  matches: $(length(matches))")
		0
	end
end


"""Select sentences contained by or overlapping with a text passage
defined by CtsUrn `u`.
$(SIGNATURES)
"""
function sentencesforurn(u::CtsUrn, sentences::Vector{SentenceAnnotation}, tknannotations::Vector{TokenAnnotation})
	tkncorpus = map(tkn -> CitablePassage(tkn.urn, tkn.text), tknannotations) |> CitableTextCorpus
	
	idx = CitableCorpus.indexurn(u,tkncorpus)
	if length(idx) == 1
		soloindex = sentenceindexfornode(tkncorpus.passages[idx[1]].urn, sentences, tknannotations)
		sentences[soloindex]

	elseif length(idx) == 2
		startindex = sentenceindexfornode(tkncorpus.passages[idx[1]].urn, sentences, tknannotations)
		endindex = sentenceindexfornode(tkncorpus.passages[idx[2]].urn, sentences, tknannotations)
		sentences[startindex:endindex]
	else
		@warn("No syntactically annotated sentences found for $(u)")
		[]
	end
	
end


"""Find the `VerbalUnitAnnotation` object for a given token.
$(SIGNATURES)
"""
function groupfortoken(tkn::TokenAnnotation, groups::Vector{VerbalUnitAnnotation})
	groupmatches = filter(g -> g.id == tkn.verbalunit, groups)
	if length(groupmatches) ==  1
		groupmatches[1]
	elseif length(groupmatches) > 1
		@warn("Multiple matches found for token $(tkn.urn) with verbal unit $(tkn.verbalunit)! ")
		nothing
	else
		@warn("No group found for token $(tkn.urn) with verbal unit $(tkn.verbalunit) ")
		nothing
	end
end

function depthfortoken(tkn::TokenAnnotation, groups::Vector{VerbalUnitAnnotation})
	grp = groupfortoken(tkn, groups)
	isnothing(grp) ? nothing : grp.depth
end


"""Find maximum depth of subordination in sentnec `s`.
$(SIGNATURES)
"""
function maxdepthforsentence(s::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation}, tokens::Vector{TokenAnnotation})
	senttokens = tokeninfoforsentence(s, tokens)
	map(t -> depthfortoken(t, groups), senttokens)
end


"""Find all tokens belonging to a given verbal unit.
$(SIGNATURES)
"""
function tokensforgroup(group::VerbalUnitAnnotation, tokens::Vector{TokenAnnotation})
	filter(tokens) do t
		t.verbalunit == group.id
	end
end

"""Map a `TokenAnnotation` to a `CitablePassage` cited
at the token level.
$(SIGNATURES)
"""
function passagefromtoken(tkn::TokenAnnotation)::CitablePassage
	CitablePassage(tkn.urn, string(tkn.text))
end


"""Find all tokens at level of subordination <= `depth`.
$(SIGNATURES)
"""
function filterbylevel(depth::Int, groups::Vector{VerbalUnitAnnotation}, tokens::Vector{TokenAnnotation})
	filter(tokens) do tkn
	    grp = groupfortoken(tkn, groups)
	    !isnothing(grp) && grp.depth <= threshhold && grp.depth != 0
	end
end