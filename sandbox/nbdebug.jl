using GreekSyntax

data = joinpath(pwd(), "test", "data", "Lysias1.6ff.cex") |> readlines

(s,g,t) = readdelimited(data)

s1 = s[1]

htmltext(s1, t)


htmltext_indented(s1, g, t)