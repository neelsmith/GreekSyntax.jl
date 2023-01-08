
"""Parse delimited string `s` into a `TokenAnnotation`.
$(SIGNATURES)
"""
function token(s::T, ortho::LiteraryGreekOrthography; delimiter = "|") where T <: AbstractString
	parts = split(s, delimiter)

	
	urn = isnothing(parts[1]) ? nothing : CtsUrn(parts[1])
	# 5-8
	node1 = parts[5] == "nothing" ? nothing : parts[5]
	node1rel = parts[6] == "nothing" ? nothing : parts[6]
	node2 = parts[7] == "nothing" ? nothing : parts[7]
	node2rel = parts[8] == "nothing" ? nothing : parts[8]
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
function token(s::T; delimiter = "|") where T <: AbstractString
	token(s, literaryGreek(), delimiter = delimiter)
end