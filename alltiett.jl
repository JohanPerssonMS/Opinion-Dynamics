# Coda nuova.
n = 1000
L = 9
dist = "unif"

# Create start opinions.
opinions = zeros(n)
if dist == "equi"
    opinions = range(0, stop=L, length=n)
elseif dist == "unif"
    opinions = sort(L*rand(n))

# Create radius vector.
r = zeros(n)
# It the radii are to be distributed equidistanly:
for i in collect(3:5:n)
    r[i] = Int(1)
end
# If the radii are to be distributed uniformly:
#while sum(r) < round(n*prop_o, digits = 0)
#    r[rand(1:n)] = Int(1)
#end
end

# Update opinions
epsilon = sqrt(eps())
new_opinions = zeros(n)

for time_steps < 30
    for i in 1:n
        l_N = 1
        r_N = 1
        l_N_previous = l_N
        r_N_previous = r_N
        previous_opinion_sum = opinions[1]

        if r[i] == 0
            new_opinions[i] = opinions[i]
        else
            if opinions[i] - opinions[1] <= r[i] + epsilon
                l_N = 1
            else
                while opinions[i] - opinions[l_N] >= r[i] + epsilon
                    l_N = l_N + 1
                end
            end
            if opinions[n] - opinions[i] <= r[i] + epsilon
                r_N = n
            else
                while opinions[r_N] - opinions[i] <= r[i] + epsilon
                    r_N = r_N + 1
                end
                r_N = r_N - 1
                print(i)
            end
            previous_opinion_sum = (previous_opinion_sum + sum(opinions[r_N_previous+1:r_N]) - sum(opinions[l_N_previous:l_N-1]))
            new_opinions[i] = previous_opinion_sum/(r_N - l_N + 1)
            l_N_previous = l_N
            r_N_previous = r_N
        end
    end
    return new_opinions
    end
end
#new_o = update_proportion_open(opinions, 2, "prop", "equi", 1, 1, 1, 0)
