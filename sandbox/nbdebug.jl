using GreekSyntax

data = joinpath(dirname(pwd()), "GreekSyntax","pluto","output","Lysias_1_round_trip.cex") |> readlines

(s,g,t) = readdelimited(data)

s1 = s[1]

htmltext(s1, t)


htmltext_indented(s1, g, t)