#= This script downloads a delimited-text file with syntactic annotations, and for each annotated sentence generates a `png` image for its syntax diagram, and a web page linking to the image.

Each web page includes:

- 2 divs of class `passage`, with two different text displays of the passage.  Each div is accompanied by a div of class `key` with a key
to interpreting the visual formatting of the passage.
- 1 div of class `diagram` with a link to the png file for this sentence.

=#
originaldir = pwd()
@info("Starting from directory $(originaldir)")

#= 1. Three required settings:
=#
outputdir = joinpath(originaldir, "debug", "lysias1_site")
textlabel = "Lysias 1"
annotations_url = "https://raw.githubusercontent.com/neelsmith/GreekSyntax/main/data/Lysias1_annotations.cex"
@info("Using output directory $(outputdir)")

# set up environment:
using Pkg

workspace = tempdir()
cd(workspace)
Pkg.activate(workspace)
Pkg.add("GreekSyntax")
Pkg.add("Downloads")
Pkg.add("CitableText")
Pkg.add("Kroki")
Pkg.update()


#= 2. Optionally, define your own CSS.
=#
using GreekSyntax
css_text = GreekSyntax.defaultcss()
page_css = GreekSyntax.pagecss()


#= 3. Good to go!  The rest of this script should run
without any further modification.
=#

# Directory where we'll write PNGs to link to:
pngdir = joinpath(outputdir, "pngs")
mkpath(pngdir)
@info("Created directory $(pngdir)")

# CSS files to link to in web pages:
open(joinpath(outputdir, "syntax.css"), "w") do io
    write(io, GreekSyntax.defaultcss())
end
open(joinpath(outputdir, "page.css"), "w") do io
    write(io, GreekSyntax.pagecss())
end

"""Wrap page title and body content in HTML elements,
and include link to syntax.css.
"""
function wrap_page(title, content)
    """<html>
    <head>
    <title>$(title)</title>
    <link rel=\"stylesheet\" href=\"syntax.css\">
    <link rel=\"stylesheet\" href=\"page.css\">
    </head>
    <body>$(content)</body>
    </html>"""
end

using Downloads
(sentences, groups, tokens) = Downloads.download(annotations_url) |> readlines |> readdelimited

using CitableText # for manipulating CTS URNS
nxt = ""
prev = ""
for (idx, sentence) in enumerate(sentences)
    @info("$(idx). Writing page for $(sentence.range)...")
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
        prev = "<a href=\"./$(prevpsg).html\">$(prevpsg)</a>"

    else
        nxtpsg = sentences[idx + 1].range |> passagecomponent
        nxt = "<a href=\"./$(nxtpsg).html\">$(nxtpsg)</a>"

        prevpsg = sentences[idx - 1].range |> passagecomponent
        prev = "<a href=\"./$(prevpsg).html\">$(prevpsg)</a>"
    end
    nav = "<p class=\"nav\">$(prev) | $(nxt)</p>"


    # Compose parts of page content:
    psg = passagecomponent(sentence.range)
    pagetitle = "$(textlabel),  $(psg)"
    hdg = "<h1>$(pagetitle)</h1>"
    subhead = "<h2>Sentence $(sentence.sequence)</h2>"
    
    plaintext = htmltext(sentence.range, sentences, tokens, sov = false, vucolor = false)


    key1 = "<div class=\"key right\"><strong>Highlighting</strong>:" *  GreekSyntax.sovkey() * "</div>"
    txtdisplay1 = "<div class=\"passage\">" * htmltext_indented(sentence, groups, tokens, sov = true, vucolor = false) * "</div>"


    pagegroups = GreekSyntax.groupsforsentence(sentence, groups)
    key2 = "<div class=\"key left\"><strong>Color code</strong>:" * GreekSyntax.htmlgrouplist(pagegroups) * "</div>"
    txtdisplay2 = "<div class=\"passage\">" * htmltext(sentence, tokens, sov = true, vucolor = true) * "</div>"

    imglink = "<img src=\"pngs/sentence_$(idx).png\" alt=\"Syntax diagram, sentence $(idx)\"/>"
    diagram = "<div class=\"diagram\">" * imglink * "</div>"
    
    # String all the parts together!
    htmlparts = [hdg, nav, subhead, plaintext, txtdisplay1, txtdisplay2, key1, key2, diagram]
    bodycontent = join(htmlparts, "\n\n")

    open(joinpath(outputdir, "$(psg).html"), "w") do io
        write(io, wrap_page(pagetitle, bodycontent))
    end
end

cd(originaldir)
@info("Done: wrote $(length(sentences)) HTML pages linked to accompanying PNG file in $(outputdir). (Now working in $(pwd()).)")
