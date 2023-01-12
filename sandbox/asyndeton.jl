using GreekSyntax
f = joinpath("..", "eagl-texts", "annotations", "Lysias1_annotations.cex")
(sentences, groups, tokens) = readlines(f) |> readdelimited

s = sent
#htmltext_indented(sentenceannotation, verbalunits, intermediatetokens, vucolor = false) 