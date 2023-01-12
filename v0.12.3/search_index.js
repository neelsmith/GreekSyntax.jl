var documenterSearchIndex = {"docs":
[{"location":"metrics/#Metrics-of-syntactic-complexity","page":"Metrics of syntactic complexity","title":"Metrics of syntactic complexity","text":"","category":"section"},{"location":"metrics/","page":"Metrics of syntactic complexity","title":"Metrics of syntactic complexity","text":"Explanatory introduction TBA: see API listings for basic docstrings.","category":"page"},{"location":"metrics/#Tokens","page":"Metrics of syntactic complexity","title":"Tokens","text":"","category":"section"},{"location":"metrics/","page":"Metrics of syntactic complexity","title":"Metrics of syntactic complexity","text":"distance: number of lexical tokens from t1 to its syntactic connection in a sentence\ndisplacement: number of lexical tokens between t1 to its syntactic connection in a sentence","category":"page"},{"location":"metrics/#Verbal-expressions","page":"Metrics of syntactic complexity","title":"Verbal expressions","text":"","category":"section"},{"location":"metrics/","page":"Metrics of syntactic complexity","title":"Metrics of syntactic complexity","text":"span: distance from first to last token in group\ncohesion: proportion of tokens with span belonging to group \ndisplacement: number of groups between start and end of span ","category":"page"},{"location":"metrics/#Sentences","page":"Metrics of syntactic complexity","title":"Sentences","text":"","category":"section"},{"location":"metrics/","page":"Metrics of syntactic complexity","title":"Metrics of syntactic complexity","text":"maxdepth: maximum syntactic level of a sentence\nmaxtokendistance\navgtokendistance\nmaxgroupdistance\navggroupdistance","category":"page"},{"location":"api/#API-documentation","page":"API docs","title":"API documentation","text":"","category":"section"},{"location":"api/#Working-with-sentences","page":"API docs","title":"Working with sentences","text":"","category":"section"},{"location":"api/","page":"API docs","title":"API docs","text":"groupsforsentence\ntokensforsentence\nsentencesforurn\nsentencerange","category":"page"},{"location":"api/#GreekSyntax.groupsforsentence","page":"API docs","title":"GreekSyntax.groupsforsentence","text":"Extract from a vector of VerbalUnitAnnotations all the verbal units that belong to sentence sa.\n\ngroupsforsentence(sa, groups)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.tokensforsentence","page":"API docs","title":"GreekSyntax.tokensforsentence","text":"Find all tokens in tknannotations belonging to sentence s.\n\ntokensforsentence(s, tknannotations)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.sentencesforurn","page":"API docs","title":"GreekSyntax.sentencesforurn","text":"Find sentence in a vector sentence annotations containing the token identified by CtsUrn u.\n\nsentencesforurn(u, sentences, tknannotations)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.sentencerange","page":"API docs","title":"GreekSyntax.sentencerange","text":"Find CTS URN for range of tokens in orthotokens where orthotokens is a vector of analyzed tokens as produced by Orthography's tokenize function.\n\nsentencerange(orthotokens)\n\n\n\n\n\n\nFind CTS URN for range of tokens in tokenlist where tokenlist is a vector of annotated tokens.\n\nsentencerange(tokenlist)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#Working-with-verbal-expressions-and-tokens","page":"API docs","title":"Working with verbal expressions and tokens","text":"","category":"section"},{"location":"api/","page":"API docs","title":"API docs","text":"tokensforgroup\nsentenceforgroup\ngroupfortoken\nsentencefortoken","category":"page"},{"location":"api/#GreekSyntax.tokensforgroup","page":"API docs","title":"GreekSyntax.tokensforgroup","text":"Find all tokens belonging to a given verbal unit.\n\ntokensforgroup(group, tokens)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.sentenceforgroup","page":"API docs","title":"GreekSyntax.sentenceforgroup","text":"Find sentence that group belongs to.\n\nsentenceforgroup(group, sentences)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.groupfortoken","page":"API docs","title":"GreekSyntax.groupfortoken","text":"Find the VerbalUnitAnnotation object for a given token.\n\ngroupfortoken(tkn, groups)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.sentencefortoken","page":"API docs","title":"GreekSyntax.sentencefortoken","text":"Find the SentenceAnnotation for a token t.\n\nsentencefortoken(t, groups, sentences)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#Syntactic-metrics","page":"API docs","title":"Syntactic metrics","text":"","category":"section"},{"location":"api/","page":"API docs","title":"API docs","text":"\ndistance\ndisplacement\ndisplacedby\ncohesion\nspan\nspansize\nmaxdepth\nmaxtokendistance\navgtokendistance\nmaxtokendisplacement\navgtokendisplacement\nmaxgroupdisplacement\navggroupdisplacement","category":"page"},{"location":"api/#GreekSyntax.distance","page":"API docs","title":"GreekSyntax.distance","text":"Find number of tokens from tkn to its syntactic connection.\n\ndistance(tkn, sentence, tknlist)\n\n\n. \n\n\n\n\n\nFind number of tokens from tkn to its syntactic connection.\n\ndistance(tkn, groups, sentences, tknlist)\n\n\n. \n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.displacement","page":"API docs","title":"GreekSyntax.displacement","text":"Find number of tokens between tkn and its syntactic connection.\n\ndisplacement(tkn, s, tknlist)\n\n\n. \n\n\n\n\n\nFind number of tokens between tkn and its syntactic connection.\n\ndisplacement(tkn, groups, sentences, tknlist)\n\n\n. \n\n\n\n\n\nFind number of other groups occurring within span of grp.\n\ndisplacement(grp, s, tokens)\n\n\n\n\n\n\nFind number of other groups occurring within span of grp.\n\ndisplacement(grp, sentences, tokens)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.displacedby","page":"API docs","title":"GreekSyntax.displacedby","text":"List other groups appearing between first and last tokens belonging to group grp.\n\ndisplacedby(grp, s, tokens)\n\n\n\n\n\n\nList other groups appearing between first and last tokens belonging to group grp.\n\ndisplacedby(grp, sentences, tokens)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.cohesion","page":"API docs","title":"GreekSyntax.cohesion","text":"Compute the proportion of tokens within the  span of grp that  belonging to the group.\n\ncohesion(grp, sentences, tokens)\n\n\n\n\n\n\nCompute the proportion of tokens within the  span of grp that  belonging to the group.\n\ncohesion(grp, s, tokens)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.span","page":"API docs","title":"GreekSyntax.span","text":"Find indexes within lexical tokens of sentence s the first and last token belonging to group grp.\n\nspan(grp, s, tokens)\n\n\n\n\n\n\nFind indexes within lexical tokens of the sentence grp belongs to of the first and last tokens of group grp.\n\nspan(grp, sentences, tokens)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.spansize","page":"API docs","title":"GreekSyntax.spansize","text":"Find the number of tokens included in the span of grp.\n\nspansize(grp, s, tokens)\n\n\n\n\n\n\nFind the number of tokens included in the span of grp.\n\nspansize(grp, sentences, tokens)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.maxdepth","page":"API docs","title":"GreekSyntax.maxdepth","text":"Find maximum depth of subordination in sentence s.\n\nmaxdepth(s, groups)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.maxtokendistance","page":"API docs","title":"GreekSyntax.maxtokendistance","text":"Find maximum distance between syntactically related tokens in a single sentence.\n\nmaxtokendistance(s, tknlist)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.avgtokendistance","page":"API docs","title":"GreekSyntax.avgtokendistance","text":"Find average distance between syntactically related tokens.\n\navgtokendistance(s, tknlist)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.maxtokendisplacement","page":"API docs","title":"GreekSyntax.maxtokendisplacement","text":"Find maximum displacement between syntactically related tokens.\n\nmaxtokendisplacement(s, tknlist)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.avgtokendisplacement","page":"API docs","title":"GreekSyntax.avgtokendisplacement","text":"Find average displacement between syntactically related tokens.\n\navgtokendisplacement(s, tknlist)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.maxgroupdisplacement","page":"API docs","title":"GreekSyntax.maxgroupdisplacement","text":"Find maximum displacement between verbal expressions.\n\nmaxgroupdisplacement(s, groups, tokens)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.avggroupdisplacement","page":"API docs","title":"GreekSyntax.avggroupdisplacement","text":"Find average displacement between verbal expressions.\n\navggroupdisplacement(s, groups, tokens)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#Writing-HTML-and-mermaid-diagrams","page":"API docs","title":"Writing HTML and mermaid diagrams","text":"","category":"section"},{"location":"api/","page":"API docs","title":"API docs","text":"htmltext\nhtmltext_indented\nhtmlgroup\nhtmlgrouplist\nsovkey\nmermaiddiagram","category":"page"},{"location":"api/#GreekSyntax.htmltext","page":"API docs","title":"GreekSyntax.htmltext","text":"Compose HTML string for tokens included  in u.\n\nhtmltext(\n    u,\n    sentencelist,\n    tknannotations;\n    sov,\n    vucolor,\n    syntaxtips,\n    colors,\n    connectorlist\n)\n\n\n\n\n\n\nCompose HTML string for the annotated sentence sa using data from a vector of token annotations.  Boolean flags for sov and vucolor provoke CSS additions for Subject-Object-Verb highlight, and for color coding by verbal unit.\n\nhtmltext(\n    sa,\n    tknannotations;\n    sov,\n    vucolor,\n    colors,\n    syntaxtips,\n    connectorids\n)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.htmltext_indented","page":"API docs","title":"GreekSyntax.htmltext_indented","text":"Compose HTML string for the annotated sentence sa indented by level of subordination. Formatting relies on data from a vector of token annotations and annotations on verbal units.\n\nhtmltext_indented(\n    sa,\n    groups,\n    tknannotations;\n    sov,\n    vucolor,\n    palette,\n    syntaxtips,\n    connectorids\n)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.htmlgroup","page":"API docs","title":"GreekSyntax.htmlgroup","text":"Compose an HTML span for the verbal annotation vu.\n\nhtmlgroup(vu; palette)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.htmlgrouplist","page":"API docs","title":"GreekSyntax.htmlgrouplist","text":"Compose an HTML ordered list for verbal units belonging to sentence sa.\n\nhtmlgrouplist(sa, groups; palette)\n\n\n\n\n\n\nCompose an HTML ordered list for the verbal annotations vulist.\n\nhtmlgrouplist(vulist; palette)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.sovkey","page":"API docs","title":"GreekSyntax.sovkey","text":"Compose an HTML unordered list illustrating each CSS class used in marking span elements.\n\nsovkey()\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.mermaiddiagram","page":"API docs","title":"GreekSyntax.mermaiddiagram","text":"Compose diagram in Mermaid format of the syntactic relations in sentence sa.   Output formats can be text, jpg, png or svg.\n\nmermaiddiagram(sa, tknannotations; format)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#Internal-functions-(not-exported)","page":"API docs","title":"Internal functions (not exported)","text":"","category":"section"},{"location":"api/","page":"API docs","title":"API docs","text":"Sentences:","category":"page"},{"location":"api/","page":"API docs","title":"API docs","text":"GreekSyntax.connectorindexes\nGreekSyntax.sentenceindexfornode\nGreekSyntax.syntactictypes","category":"page"},{"location":"api/#GreekSyntax.connectorindexes","page":"API docs","title":"GreekSyntax.connectorindexes","text":"Find a starting and ending index withint tknannotations for connecting words annotated for sentence s.\n\nconnectorindexes(s, tknannotations)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.sentenceindexfornode","page":"API docs","title":"GreekSyntax.sentenceindexfornode","text":"Find index in a vector sentence annotations of the sentence containing the token identified by CtsUrn leafnode.\n\nsentenceindexfornode(leafnode, sentences, tknannotations)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.syntactictypes","page":"API docs","title":"GreekSyntax.syntactictypes","text":"Find list of distinct syntactic types in sentence s.\n\nsyntactictypes(s, groups)\n\n\n\n\n\n\n","category":"function"},{"location":"api/","page":"API docs","title":"API docs","text":"Tokens:","category":"page"},{"location":"api/","page":"API docs","title":"API docs","text":"GreekSyntax.depthfortoken\nGreekSyntax.filterbylevel\nGreekSyntax.passagefromtoken","category":"page"},{"location":"api/#GreekSyntax.depthfortoken","page":"API docs","title":"GreekSyntax.depthfortoken","text":"Find syntactic depth of token tkn.\n\ndepthfortoken(tkn, groups)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.filterbylevel","page":"API docs","title":"GreekSyntax.filterbylevel","text":"Find all tokens at level of subordination <= depth.\n\nfilterbylevel(depth, groups, tokens)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.passagefromtoken","page":"API docs","title":"GreekSyntax.passagefromtoken","text":"Map a TokenAnnotation to a CitablePassage cited at the token level.\n\npassagefromtoken(tkn)\n\n\n\n\n\n\n","category":"function"},{"location":"api/","page":"API docs","title":"API docs","text":"Composing HTML:","category":"page"},{"location":"api/","page":"API docs","title":"API docs","text":"GreekSyntax.tipsfortoken\nGreekSyntax.htmltoken\nGreekSyntax.classesfortoken\nGreekSyntax.groupcolorforint\nGreekSyntax.groupcolorfortoken\nGreekSyntax.groupcolor","category":"page"},{"location":"api/#GreekSyntax.tipsfortoken","page":"API docs","title":"GreekSyntax.tipsfortoken","text":"Compose a tooltips attribute documenting the syntactic relation of token t.\n\ntipsfortoken(t, tkns, isconnector)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.htmltoken","page":"API docs","title":"GreekSyntax.htmltoken","text":"Compose string for a token, wrapping lexical tokens in an HTML span.  Based on lexical type and context indicated by inprefix flag, prefixes the resulting string with a leading space or not.\n\nhtmltoken(\n    t,\n    tokens,\n    inprefix,\n    connectingword,\n    add_sov,\n    add_color;\n    colors,\n    syntaxtips\n)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.classesfortoken","page":"API docs","title":"GreekSyntax.classesfortoken","text":"Compose an HTML class attribute for a lexical token.\n\nclassesfortoken(t, isconnector; syntaxtips, sov)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.groupcolorforint","page":"API docs","title":"GreekSyntax.groupcolorforint","text":"Select a color to use for item idx by  mod'ing a list of colors.  Add one to avoid zero indexes.\n\ngroupcolorforint(idx; colors)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.groupcolorfortoken","page":"API docs","title":"GreekSyntax.groupcolorfortoken","text":"Choose a color from a list of colors based on group number component of the token's verbal unit identifier.\n\ngroupcolorfortoken(tkn; colors)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#GreekSyntax.groupcolor","page":"API docs","title":"GreekSyntax.groupcolor","text":"Choose a color from a list of colors based on the convention of ending the identifier for a VerbalUnitAnnotation with a number.\n\ngroupcolor(vu; colors)\n\n\n\n\n\n\nChoose a color from a list of colors based on the convention of ending the identifier for a VerbalUnitAnnotation with a number.\n\ngroupcolor(groupid; colors)\n\n\n\n\n\n\n","category":"function"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"using GreekSyntax, Downloads\nurl = \"https://raw.githubusercontent.com/neelsmith/eagl-texts/main/annotations/Lysias1_annotations.cex\"\n(sentences, groups, tokens) = Downloads.download(url) |> readlines |> readdelimited\nlength(sentences)","category":"page"},{"location":"structures/#Working-with-sentences,-verbal-expressions-and-tokens","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"","category":"section"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"The GreekSyntax package includes many functions documented in the API page on this site.  This page highlights a few functions relating annotations in the hierarchy of sentences, verbal expressions, and tokens, to each other.","category":"page"},{"location":"structures/#Sentence","page":"Working with sentences, verbal expressions and tokens","title":"Sentence","text":"","category":"section"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"Find verbal expressions belonging to a particular sentence:","category":"page"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"s1 = sentences[1]\ns1groups = groupsforsentence(s1, groups)\ntypeof(s1groups)","category":"page"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"Find tokens belonging to a particular sentence:","category":"page"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"s1tokens = tokensforsentence(s1, tokens)\ntypeof(s1tokens)","category":"page"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"Find lexical tokens belonging to a particular sentence:","category":"page"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"s1tokens = lexicalforsentence(s1, tokens)\ntypeof(s1tokens)","category":"page"},{"location":"structures/#Verbal-expression","page":"Working with sentences, verbal expressions and tokens","title":"Verbal expression","text":"","category":"section"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"Find tokens belonging to a particular verbal expression:","category":"page"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"g1 = groups[1]\ng1tokens = tokensforgroup(g1, tokens)\ntypeof(g1tokens)","category":"page"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"Find the sentence a verbal expression belongs to:","category":"page"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"g1sentence = sentenceforgroup(g1, sentences)","category":"page"},{"location":"structures/#Token","page":"Working with sentences, verbal expressions and tokens","title":"Token","text":"","category":"section"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"Find the group a token belongs to:","category":"page"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"t1 = tokens[1]\ngroupfortoken(t1, groups)","category":"page"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"Find the sentence a token belongs to:","category":"page"},{"location":"structures/","page":"Working with sentences, verbal expressions and tokens","title":"Working with sentences, verbal expressions and tokens","text":"sentencefortoken(t1, groups, sentences)","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"root = pwd() |> dirname |> dirname","category":"page"},{"location":"read/#Reading-an-annotated-text-from-a-delimited-text-source","page":"Read an annotated text from a delimited-text source","title":"Reading an annotated text from a delimited-text source","text":"","category":"section"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"The readdelimited function takes a Vector of delimited-text strings and parses them into annotations on sentences, verbal expressions, and individual tokens.  (See the page on delimited-text format for details of its structure.)","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"The test/data directory of this repository has a test file with syntactic annotations on sentences from Lysias 1.","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"f = joinpath(root, \"test\", \"data\", \"Lysias1.6ff.cex\")","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"You can read it with the standard Julia function readlines, and pass this directly to readdelimited. The result is a tuple with three vectors respectively containing annotations for sentences, verbal expressions and individual tokens.","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"using GreekSyntax\n(sentences, verbalunits, tokens) = readlines(f) |> readdelimited\nlength(sentences)","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"length(verbalunits)","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"length(tokens)","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"It is equally easy to retrieve a source from a URL.  Here is a  set of annottions from the eagl-texts repository:","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"url = \"https://raw.githubusercontent.com/neelsmith/eagl-texts/main/annotations/Lysias1_annotations.cex\"\n\nusing Downloads\n(remote_sentences, remote_verbalunits, remote_tokens) = Downloads.download(url) |> readlines |> readdelimited\nlength(remote_sentences)","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"length(remote_verbalunits)","category":"page"},{"location":"read/","page":"Read an annotated text from a delimited-text source","title":"Read an annotated text from a delimited-text source","text":"length(remote_tokens)","category":"page"},{"location":"serialization/#Delimited-text-format","page":"Appendix: delimited-text format","title":"Delimited-text format","text":"","category":"section"},{"location":"serialization/#Structure","page":"Appendix: delimited-text format","title":"Structure","text":"","category":"section"},{"location":"serialization/","page":"Appendix: delimited-text format","title":"Appendix: delimited-text format","text":"line-oriented plain text\nempty lines and comments (starting with //) are ignored\nlines are segmented by block labels\nblock labels begin with #!\n#!sentences\n#!verbal_units\n#!tokens\nwithin each type of block, one header line and 1 or more data lnes lines of delimited text with specified columns for each block type","category":"page"},{"location":"serialization/#Examples","page":"Appendix: delimited-text format","title":"Examples","text":"","category":"section"},{"location":"serialization/#sentence","page":"Appendix: delimited-text format","title":"sentence","text":"","category":"section"},{"location":"serialization/","page":"Appendix: delimited-text format","title":"Appendix: delimited-text format","text":"#!sentences\nsentence|sequence|connector\nurn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1-1.6.46a|10|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.2","category":"page"},{"location":"serialization/#verbal-expression","page":"Appendix: delimited-text format","title":"verbal expression","text":"","category":"section"},{"location":"serialization/","page":"Appendix: delimited-text format","title":"Appendix: delimited-text format","text":"#!verbal_units\nvuid|syntactic_type|semantic_type|depth|sentence\n1.6.1-1.6.46a.1|intransitive|Independent clause|1|urn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1-1.6.46a","category":"page"},{"location":"serialization/#token","page":"Appendix: delimited-text format","title":"token","text":"","category":"section"},{"location":"serialization/","page":"Appendix: delimited-text format","title":"Appendix: delimited-text format","text":"#!tokens\nurn|tokentype|text|verbalunit|node1|node1relation|node2|node2relation\nurn:cts:greekLit:tlg0540.tlg001.omar_tokens:1.6.1|lexical|ἐγὼ|1.6.1-1.6.46a.1|20|subject|nothing|nothing","category":"page"},{"location":"#GreekSyntax.jl","page":"Overview","title":"GreekSyntax.jl","text":"","category":"section"},{"location":"","page":"Overview","title":"Overview","text":"The GreekSyntax package implements the simple model of ancient Greek syntax  presented at https://neelsmith.github.io/GreekSyntax/.","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"It defines types for:","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"annotations on sentences\nannotations on verbal expressions within a sentence\nannotations on lexical tokens with a verbal expression","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"It includes functions to:","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"read/write delimited-text files recording syntactic annotations\ncompose a HTML visualizations of text syntactically highlighted in a variety of ways\nvisualize syntax graphically with Mermaid diagrams","category":"page"},{"location":"","page":"Overview","title":"Overview","text":"The next pages provide a few examples of how to use these functions.  These are followed by fuller API listings, and a summary of the delimited file format that the GreekSyntax package writes to and reads from.","category":"page"},{"location":"html/#HTML-CSS-conventions","page":"Composing HTML and CSS","title":"HTML + CSS conventions","text":"","category":"section"},{"location":"html/","page":"Composing HTML and CSS","title":"Composing HTML and CSS","text":"The GreekSyntax package includes functions that compose HTML for incorporation in web pages.  The HTML and attached CSS classes produced by these functions are intentionally minimal, to facilitate incorporating the content and adapting its visual styling to its context.","category":"page"},{"location":"html/#Passages-of-Greek-text","page":"Composing HTML and CSS","title":"Passages of Greek text","text":"","category":"section"},{"location":"html/","page":"Composing HTML and CSS","title":"Composing HTML and CSS","text":"These functions format passages of Greek in HTML:","category":"page"},{"location":"html/","page":"Composing HTML and CSS","title":"Composing HTML and CSS","text":"htmltext formats a continuous passage of text\nhtmltext_indented formats the verbal expressions in a passage of text hierarchically indented by level of syntactic subordination","category":"page"},{"location":"html/","page":"Composing HTML and CSS","title":"Composing HTML and CSS","text":"Both functions produce a single div with an attribute class=\"passage\". Within that div, htmltext_indented hierarchically wraps verbal expressions in an HTML blockquote with attribute class=\"subordination\".","category":"page"},{"location":"html/","page":"Composing HTML and CSS","title":"Composing HTML and CSS","text":"Each lexical token is wrapped in a span.  If the sov parameter is true, a class attribute from the following list be added.  CSS settings can then define visual highlight for these classes.  The class attribute may include any one of the following values:","category":"page"},{"location":"html/","page":"Composing HTML and CSS","title":"Composing HTML and CSS","text":"connector: for tokens indentified as connecting words, joining the sentence to its larger context\nverb: for a unit verb.  Note that, in addition to finite verb forms, this includes constructions like infinitives in indirect statement, and circumstantial or attributive participles.\nsubject: for the grammatical subject of a unit verb.\nobject: for the object of a unit verb.  Note that the case used will depend on the construction of the lexeme used for the unit verb, and need not be limited to the accusative case.","category":"page"},{"location":"html/","page":"Composing HTML and CSS","title":"Composing HTML and CSS","text":"In addition, if the vucolor parameter is true, a style element is added to each lexical token assigned to a verbal expresion (or verbal unit).  The style element defines a foreground color drawn from a list of RGB values.","category":"page"},{"location":"html/#Information-about-verbal-expressions","page":"Composing HTML and CSS","title":"Information about verbal expressions","text":"","category":"section"},{"location":"html/","page":"Composing HTML and CSS","title":"Composing HTML and CSS","text":"TBA","category":"page"}]
}
