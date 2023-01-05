"""Find CTS URN for range of tokens in `orthotokens`
where `orthotokens` is a vector of analyzed tokens as produced
by `Orthography`'s `tokenize` function.
"""
function sentencerange(orthotokens)
	baseurn = droppassage(orthotokens[1][1].urn)
	opener = passagecomponent(orthotokens[1][1].urn)
	closer = passagecomponent(orthotokens[end][1].urn)
	addpassage(baseurn, string(opener, "-", closer))
end

"""Find CTS URN for range of tokens in `tokenlist`
where `tokenlist` is a vector of annotated tokens.
"""
function sentencerange(tokenlist::Vector{TokenAnnotation})
	baseurn = droppassage(tokenlist[1].urn)
	opener = passagecomponent(tokenlist[1].urn)
	closer = passagecomponent(tokenlist[end].urn)
	addpassage(baseurn, string(opener, "-", closer))
end

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

"""Extract from a vector of `TokenAnnotation`s all the tokens that
belong to sentence `sa`.
$(SIGNATURES)
"""
function tokeninfoforsentence(sa::SentenceAnnotation, tknannotations::Vector{TokenAnnotation})
	# Find indices for tokens indexed to this sentence:
	tkncorp = map(tknannotations) do t
		CitablePassage(t.urn, t.text)
	end |> CitableTextCorpus
	slice = CitableCorpus.indexurn(sa.range, tkncorp)
	if isempty(slice)
		@error("Couldn't slice empty array for $(sa.range)")
	end
	@debug("Slicing $(slice)")
	origin = slice[1]

	connectorslice = CitableCorpus.indexurn(sa.connector, tkncorp)
	connectorids = isempty(connectorslice) ?  [] : connectorslice[1]:connectorslice[end]
	(tknannotations[origin:slice[2]], connectorids, origin)
end

s"""Extract from a vector of `VerbalUnitAnnotation`s all the verbal units that
belong to sentence `sa`.
$(SIGNATURES)
"""
function groupsforsentence(sa::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation})
	filter(vu -> vu.sentence == sa.range, groups)
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