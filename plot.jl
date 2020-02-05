using Pkg
Pkg.add("PyPlot")
using PyPlot
PyPlot.clf()
rows = size(d)[1]
columns = size(d)[2]

for i in 1:rows
    x = collect(1:columns-1)
    y = (d[i,1:end-1])
    plt.plot(x, y, linewidth=2.0, linestyle="-")
end

plt.legend()
gcf()
#savefig("C:\\Users\\johan\\OneDrive\\Dokument\\Opinion Dynamics\\Julia\\n6.png")

#=
if rows < 1e3
    every_nth = Int(rows)
elseif rows < 1e6
    every_nth = Int(round(rows/1e2))
else
    every_nth = Int(round(rows/1e4))
end

for i in 1:range(1, length=Int8(every_nth), stop=rows)
    x = collect(1:columns-1)
    y = (d[i,1:end-1])
    plt.plot(x, y, linewidth=2.0, linestyle="-")
end
plt.legend()
gcf()
=#
