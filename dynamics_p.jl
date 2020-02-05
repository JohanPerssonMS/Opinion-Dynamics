function dynamics_p(n, L, model, dist, prop_o, k, m, time_steps)
    opinions = start_pos(dist, n, L)
    r = radius_p(n, L, model, dist, prop_o, k, m)
    opinion_matrix = opinions
    recent_opinions = zeros(n)
    counter = 1
    while counter < time_steps
    #while sum(abs.(recent_opinions - opinions)) > 10e-12
    #while maximum(opinions)-minimum(opinions) >= 1
        opinions = update_p(opinions, L, model, dist, prop_o, k, m, counter, r)
        opinion_matrix = vcat(opinion_matrix, opinions)
        counter = counter + 1
    end
    opinion_matrix = reshape(opinion_matrix, (n, counter))
    #println("Number of clusters: ", length(unique(opinion_matrix[:,end])))
    #if model == "prop"
    #    println("Number of open-minded clusters: ", length(unique(opinion_matrix[:,end])) - Int(length(r) - sum(r)))
    #end
    froozen = opinion_matrix[:,end]==opinion_matrix[:,end-1]

    # Get open_minded_cl positions
    if model == "prop"
        to_delete = findall(x->x==0, r)
        opinion_matrix_open = opinion_matrix[setdiff(1:end, to_delete), :]
        #print(unique(opinion_matrix[:,end]))
        # Get cluster sizes, N.B. code holds only for 2 clusters.
        cluster2 = sum(x->x>opinion_matrix_open[1,end], opinion_matrix_open[:,end], dims=1)
        cluster1 = round(n*prop_o, digits = 0) - cluster2[1]
    end
    return opinion_matrix, counter, length(unique(opinion_matrix[:,end])), froozen, unique(opinion_matrix_open[:,end]), opinion_matrix_open, Int(cluster1[1]), Int(cluster2[1])
end
d, counter, clusters, froozen, open_cl, od, cl1, cl2 = dynamics_p(1000000, 9, "prop", "equi", 0.5, 0.9, 0, 40)
