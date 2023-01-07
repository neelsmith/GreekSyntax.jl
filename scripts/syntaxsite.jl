#= This scripts downloads a delimited-text file with syntactic
annotations, and for each annotated sentence generates a `png` image for its syntax diagram, and a web page 

Each web page includes:

- 2 divs of class `passage`, with two different text displays of the passage.  Each div is accompanied by a div of class `key` with a key
to interpreting the visual formatting of the passage.
- 1 div of class `diagram` with a link to the png file for this sentence.

=#


#= 1. Three required settings:
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

# CSS file to link to in web pages:
csselement = "<style>\n" * css_text * "\n</style>"
open(joinpath(outputdir, "syntax.css"), "w") do io
    write(io, GreekSyntax.defaultcss())
end

# Directory where we'll write PNGs to link to:
pngdir = joinpath(outputdir, "pngs")
mkpath(pngdir)

"""Wrap page title and body content in HTML elements,
and include link to syntax.css.
"""
function wrap_page(title, content)
    """<html>
    <head>
    <title>$(title)</title>
    <link rel=\"stylesheet\" href=\"syntax.css\">
    </head>
    <body>$(content)</body>
    </html>"""
end

using Downloads
(sentences, groups, tokens) = Downloads.download(url) |> readlines |> readdelimited

nxt = ""
prev = ""
for (idx, sentence) in enumerate(sentences)
    # Write png for page:
    pngout = mermaiddiagram(sentence, tokens, format = "png")
    write(joinpath(pngdir, "sentence_$(idx).png"), pngout)

    # Compose navigation links for page:
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
    nav = "<p class=\"nav\">$(prev) | $(nxt)</p>"


    # Compose parts of page content:
    psg = passagecomponent(sentence.range)
    pagetitle = "$(textlabel), sentence $(sentence.sequence), $(psg)"
    hdg = "<h1>$(pagetitle)</h1>"
    

    key1 = "<div class=\"key\"><strong>Highlighting</strong>:" *  GreekSyntax.sovkey() * "</div>"
    txtdisplay1 = "<h2>Indented by level of subordination</h2><div class=\"passage\">" * htmltext_indented(s, groups, tokens, sov = true, vucolor = false) * "</div>"


    pagegroups = groupsforsentence(sentence, groups)
    key2 = "<div class=\"key\"><strong>Color code</strong>:" * GreekSyntax.htmlgrouplist(pagegroups) * "</div>"
    txtdisplay2 = "<h2>Colored by verbal expression</h2><div class=\"passage\">" * htmltext(s, tokens, sov = true, vucolor = true) * "</div>"

    imglnk = "<img src=\"pngs/sentence_$(idx).png\" alt=\"Syntax diagram, sentence $(idx)\"/>"
    diagram = "<div class=\"diagram\"><h2>Diagrammed syntactically</h2>" * imglink * "</div>"
    
    # String all the parts together!
    bodycontent = hdg * nav * key1 * txtdisplay1 * key2 * txtdisplay2 * diagram

    open(joinpath(outputdir, "$(psg).html"), "w") do io
        write(io, wrap_page(title, bodycontent))
    end
end
