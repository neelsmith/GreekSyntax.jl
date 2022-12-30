
struct SentenceAnnotation
	range::CtsUrn
	sequence::Int
	connector::Union{CtsUrn, Nothing}
end


function delimited(sa::SentenceAnnotation; delimiter = "|")
	if isnothing(sa.connector)
		string(sa.range,delimiter,sa.sequence,delimiter, "")
	else
		string(sa.range,delimiter,sa.sequence,delimiter, sa.connector)
	end
end

"""Tokenize a corpus, and chunk the resulting vector of tokens by sentence. The result is a vector of `NamedTuple`s with a URN and a sequence number. 
The URN is a range of tokens.
$(SIGNATURES)
"""
function parsesentences(c::CitableTextCorpus; ortho::T,	terminators = [".", ":", ";"]) where T <: OrthographicSystem

    tokens = tokenize(c, ortho)
	sentenceindex =  []

	currenttext = c.passages[1].urn |> droppassage
	sentencecount = 0
	rangeopener = ""
	for tkn in tokens
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
			
		else
			if isempty(rangeopener)
				rangeopener = passagecomponent(tkn[1].urn)
			end
		end
	
	end
	sentenceindex
end
