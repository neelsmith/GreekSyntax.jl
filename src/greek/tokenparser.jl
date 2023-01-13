
"""Parse delimited string `s` into a `TokenAnnotation`.
$(SIGNATURES)
"""
function token(s::T, ortho::LiteraryGreekOrthography; delimiter = "|", threshhold = 1.0) where T <: AbstractString
	parts = split(s, delimiter)
	urn = parts[1] == "nothing" ? nothing : CtsUrn(parts[1])

	# 5-8 are optional pairs of an integer index + a controlled vocabulary term
	node1 = parts[5] == "nothing" ? nothing : parse(Int, parts[5])
	node2 = parts[7] == "nothing" ? nothing : parse(Int, parts[7])

	node1rel =  if parts[6] == "nothing"
		nothing
	else
		tidiedup = validatedrelation(string(parts[6]), threshhold = threshhold)
	 	if  isnothing(tidiedup)
			@error("Invalid value for syntactic relation: $(parts[6])")
		else
			tidiedup
		end
	end
	node2rel =   if parts[8] == "nothing"
		nothing
	else
		tidiedup = validatedrelation(string(parts[8]), threshhold = threshhold)
	 	if  isnothing(tidiedup)
			@error("Invalid value for syntactic relation: $(parts[8])")
		else
			tidiedup
		end
	end

	TokenAnnotation(
		urn,
		parts[2],
		parts[3],
		parts[4],
		node1,
		node1rel,
		node2,
		node2rel
	)
end


"""Parse delimited string `s` into a `TokenAnnotation`.
$(SIGNATURES)
"""
function token(s::T; delimiter = "|", threshhold = 1.0) where T <: AbstractString
	token(s, literaryGreek(), delimiter = delimiter, threshhold = threshhold)
end