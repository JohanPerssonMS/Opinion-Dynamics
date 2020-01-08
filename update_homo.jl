function update_homo(opinions, L, model, dist, prop_o, k, m, counter)
    n = length(opinions)
    l_N  = 1
    r_N = 1
    l_N_previous = l_N
    r_N_previous = r_N
    previous_opinion_sum = opinions[1]
    epsilon = sqrt(eps())
    new_opinions = zeros(n)
    r = ones(1, n)
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
            r_N = r_N - 1
        end
        previous_opinion_sum = (previous_opinion_sum + sum(opinions[r_N_previous+1:r_N]) - sum(opinions[l_N_previous:l_N-1]))
        new_opinions[i] = previous_opinion_sum/(r_N - l_N + 1)
        l_N_previous = l_N
        r_N_previous = r_N
    end
    return new_opinions
end
#new_o = update_homo(opinions, 2, "homo", "equi", 1, 1, 1, 0)
