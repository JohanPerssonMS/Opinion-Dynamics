import matplotlib
matplotlib.use('TkAgg')

import tkinter as tk
import matplotlib.pyplot as plt
from update import *
from radius import *
from start import *

def run_plot():
    if model.get() == 'Chose model':
        print('Chose model and run again.')
        return
   
    s, counter, r = update(int(e1.get()), int(e2.get()), str(distribution.get()), str(model.get()), float(e3.get()), float(e4.get()), float(e5.get()))
    nr_clusters = len(np.unique(s[counter-1,:]))
    print("Number of clusters", nr_clusters)
    if c.get() == 1:
        # Plot radii at t = 0    
        start_position = start(int(e1.get()), int(e2.get()), str(distribution.get()))
        rad = radius(int(e1.get()), int(e2.get()), float(e4.get()), float(e5.get()), str(model.get()), float(e3.get()), start_position)
        rad_fig = plt.figure('Radii at t = 0')
        ax = rad_fig.add_subplot(111)
        line, = ax.plot(start_position, rad, lw=2)
        ax.set_xlabel("Agent position (continuous)")
        ax.set_ylabel("Radii (continuous)")

    if p.get() == 1:
        # Plot opinion dynamics
        for i in range(counter):
           plt.figure('Opinion dynamics')
           plt.plot(np.reshape(s[i,0:int(e1.get())],(1,int(e1.get()))),np.full((1,int(e1.get())),i),'ro',markersize=9)
           plt.plot([0,int(e2.get())],[i,i],'-k')
           plt.xlabel('Agent position (continuous)')
           plt.ylabel('Time (discrete)')
           plt.yticks(np.arange(0, counter, 1))
           values, index, numbers = np.unique(s[i,:], return_index = True, return_counts = True)
           if i == 0:
               continue
           for j in range(len(values)):
               plt.text(values[j], i, numbers[j], fontsize=14)
           plt.show
           
    if p_horizontal.get() == 1:
            plt.figure('Opinion dynamics vertical')            
            t = np.linspace(0, counter-1, counter)
            for agent in range(int(e1.get())):
                plt.plot(t, s[:, agent])
                plt.xlabel('Time (discrete)')
                plt.ylabel('Agent position (continuous)')
            plt.show
    
# Values to be defined by user in GUI
            
master = tk.Tk()
master.geometry('600x300+550+100')  
master.title('Opinion dynamics')  

tk.Label(master,text="Agents: n", anchor="w", width=12).grid(row=0)
tk.Label(master,text="Interval: L", anchor="w", width=12).grid(row=1)
tk.Label(master,text="Distibution", anchor="w", width=12).grid(row=2)
tk.Label(master,text="Model", anchor="w", width=12).grid(row=3)

distribution = tk.StringVar(master)
model = tk.StringVar(master)

e1 = tk.Entry(master, width=20)
e2 = tk.Entry(master, width=20)
e1.insert(10, 12) # default value
e2.insert(10, 2)

distribution.set("Equidistant[0,L]") # default value
model.set("Chose model")
d = tk.OptionMenu(master, distribution, "U(0,L)", "N(mean=L/2, st.d.=L/4) cut tails","Equidistant[0,L]")
m = tk.OptionMenu(master, model, "Homogeneous", "Proportion open", "Open right", "Open center")

# Widgets as a function of model #        
def model_chosen(*args):
    global e3
    global e4
    global e5
    t = model.get()
    if t == 'Proportion open':
        e3label = tk.Label(master,text="Prop. open.", anchor="w", width=12).grid(row=4)
        e3 = tk.Entry(master, width=20)
        e3.insert(10, 0.5)
        e3.grid(row=4, column=1)    
        def remove_widgets(*args):
            e3.grid_remove()   
            e3label = tk.Label(master,text="", anchor="w", width=12).grid(row=4)
        model.trace("w", remove_widgets)
        # Add and remove values in order to run update (row 12) with all entries
        e4 = tk.Entry(master, width=20)
        e4.insert(10, 0.5)
        e4.grid(row=4, column=1)
        e4.grid_remove()  
        e5 = tk.Entry(master, width=20)
        e5.insert(10, 0.5)
        e5.grid(row=4, column=1)
        e5.grid_remove()       
    elif t == 'Open center':    
        # Add and remove values in order to run update (row 12) with all entries
        e3 = tk.Entry(master, width=20)
        e3.insert(10, 0.5)
        e3.grid(row=4, column=1)
        e3.grid_remove()  
        
        # Add relevant values
        e4label = tk.Label(master,text="Slope: k", anchor="w", width=12).grid(row=4,column=0)
        e4 = tk.Entry(master, width=15)
        e4.insert(10, 1)
        e4.grid(row=4, column=1)
        
        e5label = tk.Label(master,text="Shift: m", anchor="w", width=12).grid(row=5,column=0)
        e5 = tk.Entry(master, width=15)
        e5.insert(10, 0)
        e5.grid(row=5, column=1)
        
        def remove_widgets(*args):
            e4.grid_remove() 
            e5.grid_remove()
            e4label = tk.Label(master,text="", anchor="w", width=12).grid(row=4)
            e5label = tk.Label(master,text="", anchor="w", width=12).grid(row=5)
        model.trace("w", remove_widgets)
    elif t == 'Open right':
        # Add and remove values in order to run update (row 12) with all entries
        e3 = tk.Entry(master, width=20)
        e3.insert(10, 0.5)
        e3.grid(row=4, column=1)
        e3.grid_remove()  
        
        # Add relevant values
        e4label = tk.Label(master,text="Slope: k", anchor="w", width=12).grid(row=4,column=0)
        e4 = tk.Entry(master, width=15)
        e4.insert(10, 1)
        e4.grid(row=4, column=1)
        
        e5label = tk.Label(master,text="Shift: m", anchor="w", width=12).grid(row=5,column=0)
        e5 = tk.Entry(master, width=15)
        e5.insert(10, 0)
        e5.grid(row=5, column=1)
        def remove_widgets(*args):
            e4.grid_remove() 
            e5.grid_remove()
            e4label = tk.Label(master,text="", anchor="w", width=12).grid(row=4)
            e5label = tk.Label(master,text="", anchor="w", width=12).grid(row=5)
        model.trace("w", remove_widgets)
    elif t == 'Homogeneous':
        # Add and remove values in order to run update (row 12) with all entries
        e3 = tk.Entry(master, width=20)
        e3.insert(10, 0.5)
        e3.grid(row=4, column=1)
        e3.grid_remove()  
        e4 = tk.Entry(master, width=20)
        e4.insert(10, 0.5)
        e4.grid(row=4, column=1)
        e4.grid_remove()  
        e5 = tk.Entry(master, width=20)
        e5.insert(10, 0.5)
        e5.grid(row=4, column=1)
        e5.grid_remove()           
model.trace("w", model_chosen)
################################################################
# Checkbox for radii plot
c = tk.BooleanVar() 
c.set(False)
c_box = tk.Checkbutton(master, text="Show radii at time = 0", variable=c)
c_box.grid(row = 6, column = 1)

# Checkbox for opinion dynamics plot
p = tk.BooleanVar() 
p.set(False)
p_box = tk.Checkbutton(master, text="Plot dynamics for small n", variable=p)
p_box.grid(row = 7, column = 1)

# Checkbox for opinion dynamics plot
p_horizontal = tk.BooleanVar() 
p_horizontal.set(True)
p_horizontal_box = tk.Checkbutton(master, text="Plot dynamics for large n", variable=p_horizontal)
p_horizontal_box.grid(row = 8, column = 1)

e1.grid(row=0, column=1)
e2.grid(row=1, column=1)
d.grid(row=2, column=1, sticky = tk.W, pady = 4)
m.grid(row=3, column=1, sticky = tk.W, pady = 4)

tk.Button(master,text='Show',command=run_plot).grid(row=9,column=1,sticky=tk.SE,pady=4)
tk.mainloop()


