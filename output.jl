#using(Pkg)
#Pkg.add("DataFrames")
#using DataFrames
#Pkg.add("CSV")
#using CSV
df = DataFrame(n = Int[], L = Float64[], model = String[],(
dist = String[]), prop_openm = Float64[], k = Float64[], m = Float64[],(
clusters = Int[]), open_minded_cl = Int[], time_steps = Int[], froozen = Bool[], min_diff = Float64[])

#n = 12
#L = 2.5
model = "prop"
dist = "equi"
prop_o = 0.5
k = 0.9
m = 0
#time_steps = 10
for time_steps in [200, 400]
    for L in collect(4.5:0.05:5.5)
        for n in [Int(1e5), Int(1e6)]
            for prop_o in [0.5, 1]
            d, counter, clusters, froozen = dynamics(n, L, model, dist, prop_o, k, m, time_steps)
            sorterade = sort(unique(d[:,end]))
            differens = ones(n-1)*L
                for i in 2:length(sorterade)
                    differens[i-1] = sorterade[i] - sorterade[i-1]
                end
            min_diff = minimum(differens)
            #max_diff = maximum(unique(d[:,end]))-minimum(unique(d[:,end]))
            if model == "prop"
                    op_c = length(unique(d[:,end])) - Int(round(n*(1-prop_o),digits=0))
                else
                    op_c = length(unique(d[:,end]))
                end
            push!(df, (n, L, model, dist, prop_o, k, m, clusters, op_c, time_steps, froozen, min_diff))            end
            end
        end
    end
#end
CSV.write("dataframe.csv", df)
print(df)
#d, counter, clusters, froozen = dynamics(10, 2, model, dist, prop_o, k, m)
#show(df, allrows=true)
