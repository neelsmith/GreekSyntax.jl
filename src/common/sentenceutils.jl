"""Find CTS URN for range of tokens in `orthotokens`
where `orthotokens` is a vector of analyzed tokens as produced
by `Orthography`'s `tokenize` function.
$(SIGNATURES)
"""
function sentencerange(orthotokens)
	baseurn = droppassage(orthotokens[1][1].urn)
	opener = passagecomponent(orthotokens[1][1].urn)
	closer = passagecomponent(orthotokens[end][1].urn)
	addpassage(baseurn, string(opener, "-", closer))
end

"""Find CTS URN for range of tokens in `tokenlist`
where `tokenlist` is a vector of annotated tokens.
$(SIGNATURES)
"""
function sentencerange(tokenlist::Vector{TokenAnnotation})
	baseurn = droppassage(tokenlist[1].urn)
	opener = passagecomponent(tokenlist[1].urn)
	closer = passagecomponent(tokenlist[end].urn)
	addpassage(baseurn, string(opener, "-", closer))
end


"""Find sentence in a vector sentence annotations containing the token identified by CtsUrn `u`.
$(SIGNATURES)
"""
function sentencesforurn(u::CtsUrn, sentences::Vector{SentenceAnnotation}, tknannotations::Vector{TokenAnnotation})
	tkncorpus = map(tkn -> CitablePassage(tkn.urn, tkn.text), tknannotations) |> CitableTextCorpus
	
	idx = CitableCorpus.indexurn(u,tkncorpus)

	if isempty(idx)
		@warn("No syntactically annotated sentences found for $(u)")
		[]
	elseif length(idx) == 1
		soloindex = sentenceindexfornode(tkncorpus.passages[idx[1]].urn, sentences, tknannotations)
		[sentences[soloindex]]

	else # length(idx) == 2
		startindex = sentenceindexfornode(tkncorpus.passages[idx[1]].urn, sentences, tknannotations)
		endindex = sentenceindexfornode(tkncorpus.passages[idx[2]].urn, sentences, tknannotations)
		sentences[startindex:endindex]
	end
	
end

"""Extract from a vector of `VerbalUnitAnnotation`s all the verbal units that belong to sentence `sa`.
$(SIGNATURES)
"""
function groupsforsentence(sa::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation})
	filter(vu -> vu.sentence == sa.range, groups)
end


"""Find all tokens in `tknannotations` belonging to sentence `s`.
$(SIGNATURES)
"""
function tokensforsentence(s::SentenceAnnotation, tknannotations::Vector{TokenAnnotation})
	# Find indices for tokens indexed to this sentence:
	tkncorp = map(tknannotations) do t
		CitablePassage(t.urn, t.text)
	end |> CitableTextCorpus
	slice = CitableCorpus.indexurn(s.range, tkncorp)
	if isempty(slice)
		@error("Couldn't slice empty array for $(s.range)")
	end
	@debug("Slicing $(slice)")
	origin = slice[1]
	tknannotations[origin:slice[2]]
end


"""Find all lexical tokens in `tknannotations` belonging to sentence `s`
$(SIGNATURES)
"""
function lexicalforsentence(s::SentenceAnnotation, tknannotations::Vector)
	filter(tokensforsentence(s, tknannotations)) do t
		t.tokentype == "lexical"
	end
end

"""Find a starting and ending index withint `tknannotations` for connecting words
annotated for sentence `s`.
$(SIGNATURES)	
"""
function connectorindexes(s::SentenceAnnotation, tknannotations::Vector{TokenAnnotation})
	if isnothing(s.connector)
		[]
		
	else
		# Find indices for tokens indexed to this sentence:
		tkncorp = map(tknannotations) do t
			CitablePassage(t.urn, t.text)
		end |> CitableTextCorpus
		slice = CitableCorpus.indexurn(s.range, tkncorp)
		if isempty(slice)
			@error("Couldn't slice empty array for $(s.range)")
		end
		@debug("Slicing $(slice)")	

		connectorslice = CitableCorpus.indexurn(s.connector, tkncorp)
		connectorids = isempty(connectorslice) ?  [] : connectorslice[1]:connectorslice[end]
		connectorids
	end
end


"""Find index in `tknannotations`  of the first token belonging
to sentence `s`.
$(SIGNATURES)
"""
function originindex(s::SentenceAnnotation, tknannotations::Vector{TokenAnnotation})
	# Find indices for tokens indexed to this sentence:
	tkncorp = map(tknannotations) do t
		CitablePassage(t.urn, t.text)
	end |> CitableTextCorpus
	slice = CitableCorpus.indexurn(s.range, tkncorp)
	if isempty(slice)
		@error("Couldn't slice empty array for $(s.range)")
	end
	@debug("Slicing $(slice)")
	origin = slice[1]

	# Find indices for tokens indexed to this sentence:
	tkncorp = map(tknannotations) do t
		CitablePassage(t.urn, t.text)
	end |> CitableTextCorpus
	slice = CitableCorpus.indexurn(s.range, tkncorp)
	if isempty(slice)
		@error("Couldn't slice empty array for $(s.range)")
	end
	@debug("Slicing $(slice)")
	origin = slice[1]
end


"""Find index in a vector sentence annotations of the sentence
containing the token identified by CtsUrn `leafnode`.
$(SIGNATURES)
"""
function sentenceindexfornode(leafnode::CtsUrn, sentences::Vector{SentenceAnnotation}, tknannotations::Vector{TokenAnnotation})::Int
	groupedtokens = []
	for (i, s) in enumerate(sentences)
		urnstrings = map(t -> string(t.urn), tokensforsentence(s, tknannotations))
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


"""Find list of distinct syntactic types in sentence `s`.
$(SIGNATURES)
"""
function syntactictypes(s::SentenceAnnotation, groups::Vector{VerbalUnitAnnotation})
	sentgroups = groupsforsentence(s, groups)
	map(g -> g.syntactic_type, sentgroups) |> unique
end