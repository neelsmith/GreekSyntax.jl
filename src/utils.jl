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


function vuidfortoken(senttokens, groupmappingsdf)
	# find group ref for token
	local tpsg = senttokens[1][1].urn |> passagecomponent
	psgmatches = filter(row -> row.passage == tpsg, groupmappingsdf)
	psgint = psgmatches[1, :group]
	psgint
	string(passagecomponent(sentencerange(senttokens)), ".", psgint)	
end