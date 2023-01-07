using GreekSyntax
using Kroki
using CitableBase, CitableText, CitableCorpus

url = "https://raw.githubusercontent.com/neelsmith/GreekSyntax/main/data/Lysias1_annotations.cex"

using Downloads
(sentences,groups,tokens) = Downloads.download(url) |> readlines |> readdelimited

outputdir = joinpath(pwd(), "debug", "generated")
pngdir = joinpath(outputdir, "pngs")
mkpath(pngdir)


csselement = "<style>\n" * GreekSyntax.defaultcss() * "\n</style>"
open(joinpath(outputdir, "greek.css"), "w") do io
    write(io, GreekSyntax.defaultcss())
end

function sovkey()
    """
<h3>Key to functional highlighting</h3>
<ul>
<li><span class="connector">connecting words</span>
<li><span class="verb">unit verb</span>
<li><span class="subject">subject</span>
<li><span class="object">object</span>
</ul>
</p>
"""
end

function wrap_page(s)
    """<html><head><link rel=\"stylesheet\" href=\"greek.css\"></head>
    
    <body>$(s)</body></html>"""
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
