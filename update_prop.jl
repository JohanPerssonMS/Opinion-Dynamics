function update_prop(opinions, L, model, dist, prop_o, k, m, counter)
    n = length(opinions)
    rightmost_neighbour = 1
    leftmost_neighbour  = 1
    neighbour_opinion_sum = opinions[1]
    new_opinions = zeros(n)
    if counter == 1
        global r_prop = radius(n, L, model, dist, prop_o, k, m)
        r = r_prop
    else
        r = r_prop
    end
    for i = 1:n
        if r[i] == 0
            new_opinions[i] = opinions[i]
            continue
        else
        old_rightmost_neighbour = rightmost_neighbour
        old_leftmost_neighbour = leftmost_neighbour
        # Find the leftmost neighbor
    end
        if opinions[i] - opinions[1] < 1
            leftmost_neighbour = 1
        else()
            while opinions[i] - opinions[leftmost_neighbour] > r[i] + sqrt(eps())
                leftmost_neighbour = leftmost_neighbour + 1
            end
        end
        # Find the rightmost neighbor
        while opinions[rightmost_neighbour] - opinions[i] <= r[i] + sqrt(eps())
            rightmost_neighbour = rightmost_neighbour + 1
            if rightmost_neighbour == n+1
                break
            end
        end
        rightmost_neighbour = rightmost_neighbour - 1
        # Adding new neighbours
        for j = (old_rightmost_neighbour + 1):rightmost_neighbour
            neighbour_opinion_sum = neighbour_opinion_sum + opinions[j]
        end
        # Removing old neighbours
        for j = old_leftmost_neighbour:(leftmost_neighbour - 1)
            neighbour_opinion_sum = neighbour_opinion_sum - opinions[j]
        end
        new_opinions[i] = neighbour_opinion_sum/(rightmost_neighbour - leftmost_neighbour + 1)
    end
    return new_opinions
end
