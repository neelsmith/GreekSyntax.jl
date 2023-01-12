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

    tknidx = originindex(sa, tknannotations) - 1
    impliedids = []
    for t in lexicalforsentence(sa, tknannotations)
        tknidx = tknidx + 1

        if isnothing(t.node1relation) || isnothing(t.node1)
            # skip
            		
        elseif t.node1 == "0" # asyndeton
            push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node1relation, "|0[asyndeton];"))

        else
            n1int = parse(Int, t.node1) 
            if n1int > length(lextokens) && ! in(n1int, impliedids)
                push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node1relation, "| ", n1int + zero, "[implied];"))
            else
                push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node1relation, "| ", n1int + zero, "[", lextokens[n1int].text,  "];"))
            end
            

			if  isnothing(t.node2) || isempty(t.node2)
                 # skip
			else
                
                n2int = parse(Int, t.node2)
                if n2int > length(lextokens) && ! in(n1int, impliedids)
                    # PUSH AN IMPLIED LINE
                    push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node2relation, "| ", n2int + zero, "[implied];"))
                else
                    push!(graphlines, string(tknidx, "[", t.text, "]", " --> |", t.node2relation, "| ",  n2int + zero, "[", lextokens[n2int].text,  "];"))
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