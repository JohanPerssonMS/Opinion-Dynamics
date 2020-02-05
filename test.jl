A1 = [1,2,0,0,4,0] #The default type is Array{Int64,1}
B1 = eltype(A1)[] #Define the type of the 0 element array B with the type of A
#B1 = eltype(typeof(A))[] this is also valid
for i=1:endof(A1)
    if A1[i] != 0
        push!(B1::Array{Int64,1},i::Int64)
    end
end
println(B1)
typeof(B1)
