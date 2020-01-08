function dynamics(n, L, model, dist, prop_o, k, m, time_steps)
    opinions = start_pos(dist, n, L)
    opinion_matrix = opinions
    recent_opinions = zeros(n)
    counter = 1
    while counter < time_steps
    #while sum(abs.(recent_opinions - opinions)) > 10e-12
    #while maximum(opinions)-minimum(opinions) >= 1
        recent_opinions = opinions
        if model == "homo"
            opinions = update_homo(opinions, L, model, dist, prop_o, k, m, counter)
        elseif model == "prop"
            opinions = update_proportion_open(opinions, L, model, dist, prop_o, k, m, counter)
        elseif model == "open c"
            opinions = update_open(opinions, L, model, dist, prop_o, k, m, counter)
        elseif model == "open r"
            opinions = update_open(opinions, L, model, dist, prop_o, k, m, counter)
        else
            println("Wrong model")
            break
        end
        opinion_matrix = vcat(opinion_matrix, opinions)
        counter = counter + 1
    end
    opinion_matrix = reshape(opinion_matrix, (n, counter))
    #println("Number of clusters: ", length(unique(opinion_matrix[:,end])))
    #if model == "prop"
    #    println("Number of open-minded clusters: ", length(unique(opinion_matrix[:,end])) - Int(length(r) - sum(r)))
    #end
    froozen = opinion_matrix[:,end]==opinion_matrix[:,end-1]
    return opinion_matrix, counter, length(unique(opinion_matrix[:,end])), froozen
end
d, counter, clusters = dynamics(9, 4.5, "homo", "equi", 0.7, 0.9, 0, 100)
