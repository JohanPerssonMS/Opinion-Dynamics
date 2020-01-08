function radius(n, L, model, dist, prop_o, k, m)
    opinions = start_pos(dist, n, L)
    if model == "homo"
        r = ones(1, n)
    elseif model == "prop"
        r = collect(1:n) - collect(1:n)
        while sum(r) < round(n*prop_o, digits = 0)
            r[rand(1:n)] = Int(1)
        end
    elseif model == "open r"
        r = k .* opinions .+ m
    elseif model == "open c"
        index = 0
        for i in 1:length(opinions)
            if opinions[i] <= maximum(opinions)/2
                index = index + 1
            else
                break
            end
        end
        radius_left = k .* opinions[1:index]
        radius_right = -k .* (opinions[index+1:end] .- L/2) .+ k.*L/2
        r = [radius_left; radius_right]
        #r = r./L .+ m # Scale
        r = r ./ L
        r = r .+ m
    else
        println("Wrong model")
        r = []
    end
    return r
end
#radius(12, 5, "open r", "equi", 0.5, 1, 0)
