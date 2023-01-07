#= 1. Required settings.
=#
outputdir = joinpath(pwd(), "lysias1")
textlabel = "Lysias 1"
annotations_url = "https://raw.githubusercontent.com/neelsmith/GreekSyntax/main/data/Lysias1_annotations.cex"


#= 2. Optionally, define your own CSS.
=#
using GreekSyntax
css_text = GreekSyntax.defaultcss()


#= 3. Good to go!  The rest of this script should run
without any further modification.
=#
pngdir = joinpath(outputdir, "pngs")
mkpath(pngdir)


using Downloads
(sentences,groups,tokens) = Downloads.download(url) |> readlines |> readdelimited



using Kroki
using CitableBase, CitableText, CitableCorpus









csselement = "<style>\n" * csstext * "\n</style>"
open(joinpath(outputdir, "syntax.css"), "w") do io
    write(io, GreekSyntax.defaultcss())
end

#<h3>Key to functional highlighting</h3


function wrap_page(title, content)
    """<html><head><title>$(title)</title><link rel=\"stylesheet\" href=\"syntax.css\"></head>
    
    <body>$(content)</body></html>"""
end

nxt = ""
prev = ""

for (idx, s) in enumerate(sentences)
    #pngout = mermaiddiagram(s, tokens, format = "png")
    #write(joinpath(pngdir, "sentence_$(idx).png"), pngout)

    if idx == 1
        nxtpsg = sentences[idx + 1].range |> passagecomponent
        nxt = "<a href=\"./$(nxtpsg).html\">$(nxtpsg)</a>"
       
        prev = ""
        
    elseif idx == length(sentences)
        
        nxt = ""

        prevpsg = sentences[idx - 1].range |> passagecomponent
        prev = "<a href=\"./$(prevpsg)\">$(prevpsg)</a>"


    else
        nxtpsg = sentences[idx + 1].range |> passagecomponent
        nxt = "<a href=\"./$(nxtpsg).html\">$(nxtpsg)</a>"
        prevpsg = sentences[idx - 1].range |> passagecomponent
        prev = "<a href=\"./$(prevpsg).html\">$(prevpsg)</a>"
    end

    psg = passagecomponent(s.range)
    hdg = "<h1>Lysias 1, sentence $(idx), $(psg)</h1>"
    nav = "<p class=\"nav\">$(prev) | $(nxt)</p>"
    lnk = "<img src=\"pngs/sentence_$(idx).png\" alt=\"Syntax diagram, sentence $(idx)\"/>"
    key = sovkey()

    txtdisplay = "<h2>Indented by level of subordination</h2><div class=\"passage\">" * htmltext_indented(s, groups, tokens, sov = true, vucolor = false) * "</div>"
    

    txtdisplay2 = "<h2>Colored by verbal expression</h2><div class=\"passage\">" * htmltext(s, tokens, sov = true, vucolor = true) * "</div>"


    pagehtml = hdg * nav * key * txtdisplay * txtdisplay2 * "<h2>Diagrammed syntactically</h2>" * lnk
    open(joinpath(outputdir, "$(psg).html"), "w") do io
        write(io, wrap_page(pagehtml))
    end
end
