"""Parse delimited string `s` into a `VerbalUnitAnnotation`.
$(SIGNATURES)
"""
function verbalunit(s, ortho::LiteraryGreekOrthography; delimiter = "|", threshhold = 1.0, strict = true)
	parts = split(s, delimiter)

	syntype =  if parts[2] == "nothing"
		nothing
	else
		tidiedup = validatedvutype(string(parts[2]), threshhold = threshhold)
	 	if  isnothing(tidiedup)
		
			if strict
				throw(DomainError(parts[2], "Invalid value for syntactic type of verbal expression  $(parts[1]): $(parts[2])"))
			else
				@error("Invalid value for syntactic type of verbal expression  $(parts[1]): $(parts[2])")
				tidiedup
			end

		else
			tidiedup
		end
	end
	semtype =  if parts[3] == "nothing"
		nothing
	else
		tidiedup = validatedverbsemantics(string(parts[3]), threshhold = threshhold)
	 	if  isnothing(tidiedup)
			
			if strict
				throw(DomainError(parts[3], "Invalid value for semantic type of verbal expression $(parts[1]): $(parts[3])"))
			else
				@error("Invalid value for semantic type of verbal expression  $(parts[1]): $(parts[3])")
				tidiedup
			end
		else
			tidiedup
		end
	end

	VerbalUnitAnnotation(parts[1],
		syntype,
		semtype,
		parse(Int, parts[4]),
		CtsUrn(parts[5])
	)
end

"""Parse delimited string `s` into a `VerbalUnitAnnotation`.
$(SIGNATURES)
"""
function verbalunit(s; delimiter = "|", threshhold = 1.0, strict = true)
	verbalunit(s, literaryGreek(), delimiter = delimiter, threshhold = threshhold, strict = strict)
end