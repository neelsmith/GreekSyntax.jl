function mermaiddiagram(sa::SentenceAnnotation, tknannotations::Vector{TokenAnnotation})
    graphlines = [
		"graph BT;",
		"classDef implicit fill:#f96,stroke:#333;"
	]

    (sentencetokens, connectorids, origin) = GreekSyntax.tokensforsentence(sa, tknannotations)
    lextokens = filter(sentencetokens) do t
        t.tokentype == "lexical"
    end
    zero = origin - 1

    impliedids = []
    tknidx = 0
    for t in lextokens
        tknidx = tknidx + 1

        if isnothing(t.node1relation) || isnothing(t.node1)
            # skip
        else
            n1int = parse(Int, t.node1) 
            if n1int > length(lextokens) && ! in(n1int, impliedids)
                # PUSH AN IMPLIED LINE
                push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node1relation, "| ", t.node1, "[implied];"))
            else
                push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node1relation, "| ", t.node1 , "[", lextokens[n1int].text,  "];"))
            end
            

			# HANDLE ASYNDETON:
			#if ! isnothing(asynidx) && string(asynidx) == r.node1
			#	push!(graphlines, "class $(tknidx) implicit;")
			# end

			if  isnothing(t.node2) || isempty(t.node2)
                 # skip
			else
                
                n2int = parse(Int, t.node2)
                push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node2relation, "| ", t.node1, "[", lextokens[n2int].text,  "];"))
			end
        end
    end
    graphstr = join(graphlines, "\n")
end