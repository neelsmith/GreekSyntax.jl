function mermaidsyntax(sa::SentenceAnnotation, tknannotations::Vector{TokenAnnotation})
    graphlines = [
		"graph BT;",
		"classDef implicit fill:#f96,stroke:#333;"
	]

    (sentencetokens, connectorids, origin) = tokensforsentence(sa, tknannotations)
    tknidx = origin - 1
    for t in sentencetokens
        tknidx = tknidx + 1

        if isnothing(t.node1relation)
            # skip
        else
            #push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node1relation, "| ", t.node1, "[", syndf[parse(Int, r.node1), :token], "];"))
			if ! isnothing(asynidx) && string(asynidx) == r.node1
				push!(graphlines, "class $(tknidx) implicit;")
			end
			if  isnothing(r.node2) || isempty(r.node2)
			else
				#push!(graphlines, string(r.reference, "[", r.token, "]", " --> |", r.node2rel, "| ", r.node2, "[", syndf[parse(Int, r.node2), :token], "];"))
			end

        end
    end
    graphstr = join(graphlines, "\n")
end