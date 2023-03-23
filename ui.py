from tkinter import *
from tkinter import filedialog
import os
import fileinput


def selectApiPath():
    op = master.directory = filedialog.askdirectory()
    print(op)
    api_path.delete("1.0", "end")
    api_path.insert('1.0', op)


def selectCxrPath():
    op = master.directory = filedialog.askdirectory()
    print(op)
    cxr_path.delete("1.0", "end")
    cxr_path.insert('1.0', op)


def path():
    print('hello')
    apihub = api_path.get("1.0", "end")
    cxr = cxr_path.get("1.0", "end")
    replacepath(apihub, cxr)
    label4.config(text="variables replaced")
    os.system("./full-deploy.sh")
    label5.config(text="started deployment")


def replacepath(apihub, cxr):
    apienv = f"'{apihub.strip()}/apihub.env'"
    psqlenv = f"'{apihub.strip()}/psql.env'"
    cxrenv = f"'{cxr.strip()}/cxr.env'"

    apiyml = f"'{apihub.strip()}/apihub.yml'"
    cxryml = f"'{cxr.strip()}/cxr.yml'"
    workeryml = f"'{cxr.strip()}/workers.yml'"

    file_path = '/qureupdate/misc/var.py'
    replacement_values = {
        'apienv': apienv,
        'psqlenv': psqlenv,
        'cxrenv': cxrenv,
        'apiyml': apiyml,
        'cxryml': cxryml,
        'workeryml': workeryml,
    }
# Loop through the file and replace the values
    for line in fileinput.input(file_path, inplace=True):
        for key, value in replacement_values.items():
            if key in line:
                line = f'{key}={value}\n'
                break
        print(line, end='')


def selection():
    if radio.get() == 1:
        selection = 'online mode selected'
    else:
        selection = 'offline mode selected'
    label.config(text=selection)


master = Tk()
radio = IntVar()
master.configure()
master.geometry("600x600")
master.title("Updater")
headlabel = Label(master, text='UPDATER', fg='black')
label = Label(master)
label4 = Label(master)
label5 = Label(master)
label6 = Label(master)


label1 = Label(master, text=" apihub path ", fg='black')
label2 = Label(master, text="cxr path", fg='black')
label3 = Label(master, text="mode of installation", fg='black')


headlabel.grid(row=0, column=1)

# padx keyword argument used to set padding along x-axis .
label1.grid(row=1, column=0, padx=10)
label2.grid(row=3, column=0, padx=10)
label3.grid(row=5, column=0, padx=10)

api_path = Text(master, height=1, width=25, font="lucida 13")
cxr_path = Text(master, height=1, width=25, font="lucida 13")


# padx keyword argument used to set padding along x-axis .
# pady keyword argument used to set padding along y-axis .
api_path.grid(row=1, column=1, padx=10, pady=10)
cxr_path.grid(row=3, column=1, padx=10, pady=10)

online = Radiobutton(master, text="online", variable=radio,
                     value=1, command=selection)
offline = Radiobutton(master, text="offline",
                      variable=radio, value=2, command=selection)


online.grid(row=5, column=1)
offline.grid(row=5, column=2)


button1 = Button(master, text="Update", bg="red", fg="black", command=path)


open_button1 = Button(master, text='select path', command=selectApiPath)
open_button2 = Button(master, text='select path', command=selectCxrPath)


button1.grid(row=7, column=1, padx=10)
open_button1.grid(row=1, column=3, padx=10)
open_button2.grid(row=3, column=3, padx=10)

label.grid(row=9, column=1, padx=10, pady=10)
label4.grid(row=11, column=1, padx=10, pady=10)
label5.grid(row=13, column=1, padx=10, pady=10)
label6.grid(row=15, column=1, padx=10, pady=10)


mainloop()
