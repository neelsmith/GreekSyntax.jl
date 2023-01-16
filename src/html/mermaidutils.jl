mermaidformats = ["png", "jpg", "svg"]


"""Compose diagram in Mermaid format of the syntactic relations in sentence `sa`.  
Output formats can be `text`, `jpg`, `png` or `svg`.
$(SIGNATURES)
"""
function mermaiddiagram(sa::SentenceAnnotation, tknannotations::Vector{TokenAnnotation}; format = "text")
    graphlines = [
		"graph BT;",
		"classDef implicit fill:#f96,stroke:#333;"
	]
    
    lextokens = lexicalforsentence(sa, tknannotations)
    zero = originindex(sa, tknannotations) - 1
    tknidx =  zero
    impliedids = []
    for t in lexicalforsentence(sa, tknannotations)
        tknidx = tknidx + 1

        if isnothing(t.node1relation) || isnothing(t.node1)
            # skip
            		
        elseif t.node1 == "0" # asyndeton
            push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node1relation, "|0[asyndeton];"))

        else
           
            if t.node1 > length(lextokens) && ! in(t.node1, impliedids)
                push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node1relation, "| ", t.node1 + zero, "[implied];"))
            else
                push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node1relation, "| ", t.node1 + zero, "[", lextokens[t.node1].text,  "];"))
            end
            

			if  isnothing(t.node2) || isempty(t.node2)
                 # skip
			else
                if t.node2 > length(lextokens) && ! in(t.node2, impliedids)
                    # PUSH AN IMPLIED LINE
                    push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node2relation, "| ", t.node2 + zero, "[implied];"))
                else
                    push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node2relation, "| ",  t.node2 + zero, "[", lextokens[t.node2].text,  "];"))
                end
			end
        end
    end
    
    if format == "text"
        join(graphlines, "\n")
    else
        lc = lowercase(format)
        if lc in mermaidformats
            mermgraph = mermaid"""$(join(graphlines,"\n"))"""
            render(mermgraph, lc)
        end
    end
end