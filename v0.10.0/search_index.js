var documenterSearchIndex = {"docs":
[{"location":"structures/#Working-with-sentences,-verbal-expressions-and-tokens","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"","category":"section"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"many functions let you organize related material. examples:\nfinding verbal expressions belonging to a particular sentence\nfinding tokens belonging to a particular sentence or verbal expression\nfinding information about the sentence or verbal expression a particular token belongs to\n","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"root = pwd() |> dirname |> dirname","category":"page"},{"location":"read/#Reading-an-annotated-text-from-a-delimited-text-source","page":"Read an annotated text from a delimited-text source","title":"Reading an annotated text from a delimited-text source","text":"","category":"section"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"The readdelimited function takes a Vector of delimited-text strings and parses them into annotations on sentences, verbal expressions, and individual tokens.  (See the page on delimited-text format for details of its structure.)","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"The test/data directory of this repository has a test file with syntactic annotations on sentences from Lysias 1.","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"f = joinpath(root, \"test\", \"data\", \"Lysias1.6ff.cex\")","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"You can read it with the standard Julia function readlines, and pass this directly to readdelimited. The result is a tuple with three vectors respectively containing annotations for sentences, verbal expressions and individual tokens.","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"using GreekSyntax\n(sentences, verbalunits, tokens) = readlines(f) |> readdelimited\nlength(sentences)","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"length(verbalunits)","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"length(tokens)","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"It is equally easy to retrieve a source from a URL.  Here is the same dataset:","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"url = \"https://raw.githubusercontent.com/neelsmith/GreekSyntax.jl/main/test/data/Lysias1.6ff.cex\"\n\nusing Downloads\n(remote_sentences, remote_verbalunits, remote_tokens) = Downloads.download(url) |> readlines |> readdelimited\nlength(remote_sentences)","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"length(remote_verbalunits)","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"length(remote_tokens)","category":"page"},{"location":"serialization/#Delimited-text-format","page":"Delimited-text format","title":"Delimited-text format","text":"","category":"section"},{"location":"serialization/#Structure","page":"Delimited-text format","title":"Structure","text":"","category":"section"},{"location":"serialization/","page":"Delimited-text format","title":"Delimited-text format","text":"line-oriented plain text\nempty lines and comments (starting with //) are ignored\nlines are segmented by block labels\nblock labels begin with #!\n#!sentences\n#!verbal_units\n#!tokens\nwithin each type of block, one header line and 1 or more data lnes lines of delimited text with specified columns for each block type","category":"page"},{"location":"serialization/#Examples","page":"Delimited-text format","title":"Examples","text":"","category":"section"},{"location":"serialization/#sentence","page":"Delimited-text format","title":"sentence","text":"","category":"section"},{"location":"serialization/","page":"Delimited-text format","title":"Delimited-text format","text":"#!sentences\nsentence|sequence|connector\nurn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1-1.6.46a|10|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.2","category":"page"},{"location":"serialization/#verbal-expression","page":"Delimited-text format","title":"verbal expression","text":"","category":"section"},{"location":"serialization/","page":"Delimited-text format","title":"Delimited-text format","text":"#!verbal_units\nvuid|syntactic_type|semantic_type|depth|sentence\n1.6.1-1.6.46a.1|intransitive|Independent clause|1|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1-1.6.46a","category":"page"},{"location":"serialization/#token","page":"Delimited-text format","title":"token","text":"","category":"section"},{"location":"serialization/","page":"Delimited-text format","title":"Delimited-text format","text":"#!tokens\nurn|tokentype|text|verbalunit|node1|node1relation|node2|node2relation\nurn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1|lexical|ἐγὼ|1.6.1-1.6.46a.1|20|subject|nothing|nothing","category":"page"},{"location":"#GreekSyntax.jl","page":"Overview","title":"GreekSyntax.jl","text":"","category":"section"},{"location":"","page":"Overview","title":"Overview","text":"The GreekSyntax package implements the simple model of ancient Greek syntax  presented at https://neelsmith.github.io/GreekSyntax/.","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"It defines types for:","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"annotations on sentences\nannotations on verbal expressions within a sentence\nannotations on lexical tokens with a verbal expression","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"It includes functions to:","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"read/write delimited-text files recording syntactic annotations\ncompose a HTML visualizations of text syntactically highlighted in a variety of ways\nvisualize syntax graphically with Mermaid diagrams","category":"page"},{"location":"html/#HTML-CSS-conventions","page":"HTML + CSS conventions","title":"HTML + CSS conventions","text":"","category":"section"},{"location":"html/","page":"HTML + CSS conventions","title":"HTML + CSS conventions","text":"The GreekSyntax package includes functions that compose HTML for incorporation in web pages.  The HTML and attached CSS classes produced by these functions are intentionally minimal, to facilitate incorporating the content and adapting its visual styling to its context.","category":"page"},{"location":"html/#Passages-of-Greek-text","page":"HTML + CSS conventions","title":"Passages of Greek text","text":"","category":"section"},{"location":"html/","page":"HTML + CSS conventions","title":"HTML + CSS conventions","text":"These functions format passages of Greek in HTML:","category":"page"},{"location":"html/","page":"HTML + CSS conventions","title":"HTML + CSS conventions","text":"htmltext formats a continuous passage of text\nhtmltext_indented formats the verbal expressions in a passage of text hierarchically indented by level of syntactic subordination","category":"page"},{"location":"html/","page":"HTML + CSS conventions","title":"HTML + CSS conventions","text":"Both functions produce a single div with an attribute class=\"passage\". Within that div, htmltext_indented hierarchically wraps verbal expressions in an HTML blockquote with attribute class=\"subordination\".","category":"page"},{"location":"html/","page":"HTML + CSS conventions","title":"HTML + CSS conventions","text":"Each lexical token is wrapped in a span.  If the sov parameter is true, a class attribute from the following list be added.  CSS settings can then define visual highlight for these classes.  The class attribute may include any one of the following values:","category":"page"},{"location":"html/","page":"HTML + CSS conventions","title":"HTML + CSS conventions","text":"connector: for tokens indentified as connecting words, joining the sentence to its larger context\nverb: for a unit verb.  Note that, in addition to finite verb forms, this includes constructions like infinitives in indirect statement, and circumstantial or attributive participles.\nsubject: for the grammatical subject of a unit verb.\nobject: for the object of a unit verb.  Note that the case used will depend on the construction of the lexeme used for the unit verb, and need not be limited to the accusative case.","category":"page"},{"location":"html/","page":"HTML + CSS conventions","title":"HTML + CSS conventions","text":"In addition, if the vucolor parameter is true, a style element is added to each lexical token assigned to a verbal expresion (or verbal unit).  The style element defines a foreground color drawn from a list of RGB values.","category":"page"},{"location":"html/#Information-about-verbal-expressions","page":"HTML + CSS conventions","title":"Information about verbal expressions","text":"","category":"section"},{"location":"html/","page":"HTML + CSS conventions","title":"HTML + CSS conventions","text":"TBA","category":"page"}]
}