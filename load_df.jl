# load excel
# Ladda grejerna i packages
loaded_df = CSV.read("C:\\Users\\johan\\OneDrive\\Dokument\\Opinion Dynamics\\Julia\\df_to_julia.csv")

cluster_dist_40 = sum(loaded_df.min_diff[1:130])
cluster_dist_80 = sum(loaded_df.min_diff[131:260])
#cluster_dist_90 = sum(loaded_df.min_diff[133:198])
