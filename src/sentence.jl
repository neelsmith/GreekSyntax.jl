
"""Annotations on a sentence:

1. range of tokens it comprises
2. sentence sequence within its context
3. connecting word(s)
"""
struct SentenceAnnotation
	range::CtsUrn
	sequence::Int
	connector::Union{CtsUrn, Nothing}
end

"""Implement equality testing on `SentenceAnnotation`s.
$(SIGNATURES)
"""
function ==(s1::SentenceAnnotation, s2::SentenceAnnotation)
	s1.range == s2.range &&
	s1.sequence == s2.sequence &&
	s1.connector == s2.connector
end

"""Compose delimited-text representation of a `SentenceAnnotation`.
$(SIGNATURES)
"""
function delimited(sa::SentenceAnnotation; delimiter = "|")
	if isnothing(sa.connector)
		string(sa.range,delimiter,sa.sequence,delimiter, "")
	else
		string(sa.range,delimiter,sa.sequence,delimiter, sa.connector)
	end
end

"""Compose delimited-text representation of a vector of `SentenceAnnotation`s.
$(SIGNATURES)
"""
function delimited(sentlist::Vector{SentenceAnnotation}; delimiter = "|")
	hdr = "sentence|sequence|connector\n"
	hdr * join(map(s -> delimited(s), sentlist), "\n") * "\n" 
end

"""Parse delimited string `s` into a `SentenceAnnotation`."""
function sentence(s; delimiter = "|")
	parts = split(s, delimiter)
	SentenceAnnotation(
		CtsUrn(parts[1]), 
		parse(Int, parts[2]),
		CtsUrn(parts[3])
	)
end

"""Tokenize a corpus, and chunk the resulting vector of tokens by sentence. The result is a vector of `NamedTuple`s with a URN and a sequence number. 
The URN is a range of tokens.
$(SIGNATURES)
"""
function parsesentences(c::CitableTextCorpus, ortho::T;	
	terminators = [".", ":", ";"]) where T <: OrthographicSystem
    tokens = tokenize(c, ortho)
	parsesentences(tokens, terminators = terminators)
end

"""Tokenize a vector of analyzed tokens, and chunk by sentence. The result is a vector of `NamedTuple`s with a URN and a sequence number. 
The URN is a range of tokens.
$(SIGNATURES)
"""
function parsesentences(v::Vector{Tuple{CitablePassage,TokenCategory}}; terminators = [".", ":", ";"])
	sentenceindex =  []

	currenttext = v[1][1].urn |> droppassage
	sentencecount = 0
	rangeopener = ""
	for tkn in v
		if droppassage(tkn[1].urn) != currenttext
			currenttext = droppassage(tkn[1].urn)
            sentencecount = 0
			if ! isempty(rangeopener)
                rangeu = addpassage(currenttext, string(rangeopener, "-", 	passagecomponent(n[1].urn)))
            end
		end

		if tkn[1].text in terminators
			sentencecount = sentencecount + 1
			if isempty(rangeopener)
                @error("Syntax error: empty sentence at token $(n)")
            end

			rangeu = addpassage(currenttext, string(rangeopener, "-", 	passagecomponent(tkn[1].urn)))
			push!(sentenceindex, (urn = rangeu, sequence = sentencecount))
			rangeopener = ""
		else
			if isempty(rangeopener)
				rangeopener = passagecomponent(tkn[1].urn)
			end
		end
	
	end
	sentenceindex
end
