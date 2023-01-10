#1: directory where output will be written
outputdir = joinpath(pwd(), "scratchpad", "reader")
#2: title for your text
textlabel = "Hyginus, Fabulae"
#3:  source for your syntactic annotations.
annotations_file = joinpath( "..", "eagl-texts", "annotations", "Hyginus_annotations.cex")
#annotations_url = "https://raw.githubusercontent.com/neelsmith/GreekAndLatinSyntax/main/data/Lysias1_annotations.cex"
isfile(annotations_file)



using GreekSyntax
(sentences, groups, tokens) = annotations_file |> readlines |> readdelimited


# Directory where we'll write PNGs to link to:
pngdir = joinpath(outputdir, "pngs")
mkpath(pngdir)
@info("Created directory $(pngdir)")

# CSS files to link to in web pages:
open(joinpath(outputdir, "syntax.css"), "w") do io
    write(io, GreekSyntax.defaultcss() * "\n")
end
open(joinpath(outputdir, "page.css"), "w") do io
    write(io, GreekSyntax.pagecss())
end

using CitableText # for manipulating CTS URNS
using Dates

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

"""Compose navigation links for page with index `idx`.
"""
function navlinks(idx::Int, sentencelist::Vector{SentenceAnnotation})
    nxt = ""
    prev = ""
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
end

"""Compose HMTL page for sentence number `idx`.
"""
function webpage(idx, sentences, groups, tokens)
    sentence = sentences[idx]
    @info("$(idx). Writing page for $(sentence.sequence) == $(sentence.range)...")

    # Compose parts of page content:

    #  Heading and subheading
    psg = passagecomponent(sentence.range)
    pagetitle = "$(textlabel),  $(psg)"
    hdg = "<h1>$(pagetitle)</h1>"
    subhead = "<h2>Sentence $(sentence.sequence)</h2>"
     
    # navigation links
    nav = navlinks(idx, sentences)

    # Continuous text view:
    plaintext = htmltext(sentence.range, sentences, tokens, sov = false, vucolor = false, syntaxtips = true)


    # Text colored by verbal expression:
    key1 = "<div class=\"key right\"><strong>Highlighting</strong>:" *  GreekSyntax.sovkey() * "</div>"
    txtdisplay1 = "<div class=\"passage\">" * htmltext_indented(sentence, groups, tokens, sov = true, vucolor = false) * "</div>"

    # Text indented by level of subordination
    pagegroups = GreekSyntax.groupsforsentence(sentence, groups)
    key2 = "<div class=\"key left\"><strong>Color code</strong>:" * GreekSyntax.htmlgrouplist(pagegroups) * "</div>"
    txtdisplay2 = "<div class=\"passage\">" * htmltext(sentence, tokens, sov = true, vucolor = true) * "</div>"

    # Syntax diagram (pre-generated PNG)
    @info("Linking to image for $(sentence.sequence) == $(sentence.range)")
    imglink = "<img src=\"pngs/sentence_$(sentence.sequence).png\" alt=\"Syntax diagram, sentence $(sentence.sequence)\"/>"
    diagram = "<div class=\"diagram\">" * imglink * "</div>"
    
    m = now() |> monthname
    d = now() |> day
    y = now() |> year
    footer = "<footer>DEBUG THIS STUFF></footer>"

    # String all the parts together!
    htmlparts = [hdg, nav, subhead, plaintext, txtdisplay1, txtdisplay2, key1, key2, diagram, footer]
    bodycontent = join(htmlparts, "\n\n")
    wrap_page(pagetitle, bodycontent)
end


function publishsentence(num, sentences, groups, tokens; pngdir = pngdir, outdir = outputdir)
    idx = findfirst(s -> s.sequence == num, sentences)
    # Write png for page:
    sentence = sentences[idx]
    @info("Composing diagram for sentence $(num) == $(sentence.range)")
    pngout = mermaiddiagram(sentence, tokens, format = "png")
    write(joinpath(pngdir, "sentence_$(sentence.sequence).png"), pngout)

    psg = passagecomponent(sentence.range)
    pagehtml = webpage(idx, sentences, groups, tokens)
    open(joinpath(outputdir, "$(psg).html"), "w") do io
        write(io, pagehtml)
    end
    @info("Done: wrote HTML page for sentence $(num) in $(outputdir) as $(psg).html.")
end


function publishall(sentences, groups, tokens)
    for sentence in sentences
        publishsentence(sentence.sequence, sentences, groups, tokens)   
    end
    @info("Done: wrote $(length(sentences)) HTML pages linked to accompanying PNG file in $(outputdir). (Now in $(pwd()))")
end

publishall(sentences, groups, tokens)


# This works if you want to republish a specific sentence identified
# by its sequence number:
#publishsentence(1198, sentences, groups, tokens)  

