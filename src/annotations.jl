struct VerbalUnitAnnotation
	id
	semantic_type
	syntactic_type
	depth::Int
end

struct SentenceAnnotation
	range::CtsUrn
	connector::Union{CtsUrn, Nothing}
end

struct TokenAnnotation
	urn::CtsUrn
	tokentype
	text
	verbalunit
	node1
	node1relation
	node2
	node2relation
end