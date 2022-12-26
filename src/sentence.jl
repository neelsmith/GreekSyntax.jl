
struct SentenceAnnotation
	range::CtsUrn
	connector::Union{CtsUrn, Nothing}
end


"""Parse delimited string `s` into a `SentenceAnnotation`."""
function sentence(s; delimiter = "|")
	parts = split(s, delimiter)
	SentenceAnnotation(CtsUrn(parts[1]), CtsUrn(parts[2]))
end

"""Tokenize a corpus, and chunk the resulting vector of tokens by sentence.  The result is pair of vectors of equal length: the first vector is a list of CTS URNs for each sentence (cited as 
a range at the token level), and the second is a vector of analyzed tokens. 
$(SIGNATURES)
"""
function tokensbysentence(c::CitableTextCorpus; ortho = literaryGreek()) 

    tokens = tokenize(c, ortho)
	baseurn = c.passages[1].urn |> droppassage
	finals = [".", ":", ";"]
	rangeopener = ""

	sentenceurls = []
	sentencecontents = []
	currentsentence = []	
	for n in tokens
    	if n[1].text in finals
        	rangeu = addpassage(baseurn, string(rangeopener, "-", 	passagecomponent(n[1].urn)))
	        push!(sentenceurls, rangeu)

			push!(currentsentence, n)
			push!(sentencecontents, currentsentence)
			currentsentence = []
			
	    else
			if isempty(rangeopener)
	        	rangeopener = passagecomponent(n[1].urn)
	    	end
			push!(currentsentence, n)
		end
	end
	(sentenceurls,sentencecontents)
    
end