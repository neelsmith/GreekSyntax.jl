"""Find CTS URN for range of tokens in sentence `s`
where `s` is a vector of analyzed tokens as produced
by `Orthography`'s `tokenize` function.
"""
function sentencerange(s)
	baseurn = droppassage(s[1][1].urn)
	opener = passagecomponent(s[1][1].urn)
	closer = passagecomponent(s[end][1].urn)
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
function tokensforsentence(sa::SentenceAnnotation, tknannotations::Vector{TokenAnnotation})
	# Find indices for tokens indexed to this sentence:
	tkncorp = map(tknannotations) do t
		CitablePassage(t.urn, t.text)
	end |> CitableTextCorpus
	slice = CitableCorpus.indexurn(sa.range, tkncorp)
	origin = slice[1]

	connectorslice = CitableCorpus.indexurn(sa.connector, tkncorp)
	connectorids = connectorslice[1]:connectorslice[end]
	(tknannotations[origin:slice[2]], connectorids, origin)
end



"""Extract from a vector of `VerbalUnitAnnotation`s all the verbal units that
belong to sentence `sa`.
$(SIGNATURES)
"""
function groupsforsentence(sa::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation})
	filter(vu -> vu.sentence == sa.range, groups)
end


function sentenceindexfornode(leafnode::CtsUrn, sentences::Vector{SentenceAnnotation}, tknannotations::Vector{TokenAnnotation})::Int
	groupedtokens = []
	for (i, s) in enumerate(sentences)
		(sentencetkns, connection, origin) = tokensforsentence(s, tknannotations)
		urnstrings = map(t -> string(t.urn), sentencetkns) 	
		push!(groupedtokens, (index = i, ids = urnstrings))
	end
	matches = filter(groupedtokens) do grp
		string(leafnode) in grp[2]
	end
	
	if length(matches) == 1
		"FOUND IT!"
		matches[1].index
	else
		@warn("No luck.  matches: $(length(matches))")
		0
	end
end



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


"""Find all tokens belonging to a given verbal unit.
$(SIGNATURES)
"""
function tokensforgroup(group::VerbalUnitAnnotation, tokens::Vector{TokenAnnotation})
	filter(tokens) do t
		t.verbalunit == group.id
	end
end