import wget
variabs = ['air']
for vvv in variabs:
    for i in range(2000,2010):
        !wget ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.dailyavgs/surface/{vvv}.sig995.{i}.nc