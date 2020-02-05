import pandas as pd

df = pd.ExcelFile(r'C:\Users\johan\OneDrive\Dokument\Opinion Dynamics\Julia\Data collection proportion open.xlsx').parse('n diff, L diff&Large, p=0.5')
df.L