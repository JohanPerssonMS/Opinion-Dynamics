function update_opinions(opinions, L, model, dist, prop_o, k, m, counter)
    n = length(opinions)
    rightmost_neighbour = 1
    leftmost_neighbour  = 1
    neighbour_opinion_sum = opinions[1]
    new_opinions = zeros(n)
    r = radius(n, L, model, dist, prop_o, k, m)
    for i = 1:n
        old_rightmost_neighbour = rightmost_neighbour
        old_leftmost_neighbour = leftmost_neighbour
        # Find the leftmost neighbor
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
