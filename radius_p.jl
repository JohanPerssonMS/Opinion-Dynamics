function radius_p(n, L, model, dist, prop_o, k, m)
    opinions = start_pos(dist, n, L)
    r = zeros(n)
    for i in collect(3:5:n)
        r[i] = Int(1)
    end

    #while sum(r) < round(n*prop_o, digits = 0)
    #    r[rand(1:n)] = Int(1)
    #end
    return r
end
radius_p(1000000, 5, "open r", "equi", 0.5, 1, 0)
