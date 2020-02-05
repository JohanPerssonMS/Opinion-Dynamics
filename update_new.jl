function update_new(opinions, L, model, dist, prop_o, k, m, counter)
    n = length(opinions)
    l_N  = 1
    r_N = 1
    l_N_previous = l_N
    r_N_previous = r_N
    previous_opinion_sum = opinions[1]
    epsilon = sqrt(eps())
#=
    if counter == 1
        global r_prop = radius(n, L, model, dist, prop_o, k, m)
        r = r_prop
    else
        r = r_prop
    end
=#
    r = r = ones(1, n)
    for i in 1:n
        if opinions[i] - opinions[1] < r[i] + epsilon
            l_N = 1
        else
            while opinions[i] - opinions[l_N] > r[i] + epsilon
                l_N = l_N + 1
            end
        end
        if opinions[n] - opinions[i] < r[i] + epsilon
            r_N = n
        else
            while opinions[r_N] - opinions[i] < r[i] + epsilon
                r_N = r_N + 1
            end
        end
    end
end
