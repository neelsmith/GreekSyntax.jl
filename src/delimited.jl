
function parsedelimited(v::Vector{T}) where T <: AbstractString
    nocomments = filter(ln -> ! startswith(ln, "//"), v)

    sentences = SentenceAnnotation[]
    vus = VerbalUnitAnnotation[]
    tokens = TokenAnnotation[]

    currentblock = ""
    headerseen = false
    for ln in filter(l -> ! isempty(l), nocomments)
        if startswith(ln, "#!")
            currentblock = ln
            headerseen = false
            @debug("Current block now $(currentblock)")
        
        elseif headerseen == false
            headerseen = true
        else
            if currentblock == "#!sentences"
                push!(sentences, sentence(ln))
            elseif currentblock == "#!verbal_units"
                push!(vus, verbalunit(ln))
            elseif currentblock == "#!tokens"
                push!(tokens, token(ln))
            else
                @error("Syntax error in delimited-text file: unrecognized context for line $(ln)")
            end
        end
    end
    (sentences, vus, tokens)
end


    