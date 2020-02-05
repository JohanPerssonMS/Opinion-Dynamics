#using(Pkg)
#Pkg.add("DataFrames")
#using DataFrames
#Pkg.add("CSV")
#using CSV
#df_k_m = DataFrame(n = Int[], L = Float64[], model = String[],(
#dist = String[]), prop_openm = Float64[], k = Float64[], m = Float64[],(
#clusters = Int[]), open_minded_cl = Int[], time_steps = Int[], froozen = Bool[], min_diff = Float64[], max_diff = Float64[])
df = DataFrame(n = Int[], L = Float64[], model = String[],(
dist = String[]), prop_openm = Float64[],(
clusters = Int[]), open_minded_cl = Int[], time_steps = Int[], froozen = Bool[], open_cl1 = Float64[], open_cl2 = Float64[], cl1 = Int[], cl2 = Int[])


#n = 12
#L = 2.5
model = "prop"
dist = "unif"
#prop_o = 0.5
k = 0.9
m = 0
open_cl1 = 0
open_cl2 = 0
#time_steps = 10
for u in collect(1:5)
for time_steps in [50]
    for L in [9]
        for n in [Int(1e4)]
            for prop_o in [0.5] #collect(0.1:0.1:0.9)
            d, counter, clusters, froozen, open_cl, od, cl1, cl2 = dynamics_p(n, L, model, dist, prop_o, k, m, time_steps)
            sorterade = sort(unique(d[:,end]))
            differens = ones(n-1)*L
                for i in 2:length(sorterade)
                    differens[i-1] = sorterade[i] - sorterade[i-1]
                end
            min_diff = minimum(differens)
            max_diff = sorterade[end] - sorterade[1]
            #max_diff = maximum(unique(d[:,end]))-minimum(unique(d[:,end]))
            if model == "prop"
                    op_c = length(unique(d[:,end])) - Int(round(n*(1-prop_o),digits=0))
                else
                    op_c = length(unique(d[:,end]))
            end
            if length(open_cl) == 1
                open_cl1 = open_cl[1]
                open_cl2 = -1
            elseif length(open_cl) == 2
                open_cl1 = open_cl[1]
                open_cl2 = open_cl[2]
            else
                open_cl1 = -1
                open_cl2 = -1
            end
            push!(df, (n, L, model, dist, prop_o, clusters, op_c, time_steps, froozen, open_cl1, open_cl2, cl1[1], cl2[1]))
            end
            end
        end
    end
end
#end
CSV.write("dataframe.csv", df)
print(df)
#d, counter, clusters, froozen = dynamics(10, 2, model, dist, prop_o, k, m)
#show(df, allrows=true)
