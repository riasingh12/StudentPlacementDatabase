import psycopg2
import tkinter
from tkinter import ttk

def initialize_database():
    try:
        # Connect to an existing database
        connection = psycopg2.connect(user="postgres", password="postgres7", host="127.0.0.1", port="5432", database="postgres")
        cursor = connection.cursor()
        cursor.execute(open("placementValues.sql", "r").read())

    except Exception as e:
        print("Error while connecting to PostgreSQL:", e)

    else:
        cursor.close()
        connection.close()
        print("Starting Database created")

class DisplayWindow:
    def __init__(self, items, query, heading) -> None:
        self.window = tkinter.Tk()
        self.window.title(heading)
        self.window.minsize(width=1000, height=600)
        self.window.config(padx=100, pady=50) #add padding

        operations_label = tkinter.Label(self.window, text=query, font=("Helvetica", 16, "bold"))
        operations_label.grid(column=0, row=1, pady=(0, 30), columnspan=100)

        for i in range(len(items)):
            for j in range(len(items[i])):
                tkinter.Label(
                    self.window,
                    text=items[i][j],
                    font=("Helvetica", 12, "normal")
                ).grid(
                    column=j,
                    row=(2 + i),
                    pady=(0, 10),
                    padx=(15, 15),
                    sticky="W"
                )


initialize_database()

window = tkinter.Tk()
window.title("Frontend Placement Office")
window.minsize(width=700, height=600)
# window.config(padx=100, pady=50)

####### Scrollbar stuff #########
main_frame = tkinter.Frame(window)
main_frame.pack(fill="both", expand=1)

my_canvas = tkinter.Canvas(main_frame)
my_canvas.pack(side="left", fill="both", expand=1)

my_scrollbar = ttk.Scrollbar(main_frame, orient="vertical", command=my_canvas.yview)
my_scrollbar.pack(side="right", fill="y")

my_canvas.configure(yscrollcommand=my_scrollbar.set)
my_canvas.bind("<Configure>", lambda e:my_canvas.configure(scrollregion=my_canvas.bbox("all")))

second_frame = tkinter.Frame(my_canvas)

my_canvas.create_window((0, 0), window=second_frame, anchor="nw")
# scroll bar stuff ends

operations_label = tkinter.Label(second_frame, text="Placement Database", foreground = "#%02x%02x%02x" % (7,47,95),font=("Helvetica", 20, "bold","underline"))
operations_label.grid(column=2, row=1, pady=(5, 30)) #to actually show the element on screen, my_label.pack(side="left") this works too

queries_label = tkinter.Label(second_frame, text="Custom queries", foreground = "#%02x%02x%02x" % (7,47,95),font=("Helvetica", 14, "bold", "underline"))
queries_label.grid(column=0, row=2, columnspan=2, pady=(0, 10), padx=(15, 15))

options_label = tkinter.Label(second_frame, text="Options",foreground = "#%02x%02x%02x" % (7,47,95), font=("Helvetica", 14, "bold", "underline"))
options_label.grid(column=3, row=2, pady=(0, 10), padx=(15, 15))

my_input = tkinter.Entry(second_frame, width="60")
my_input.grid(column=1, row=3, columnspan=2, padx=(15, 15))

def execute_query(query):
    try:
        # Connect to an existing database
        connection = psycopg2.connect(user="postgres", password="postgres7", host="127.0.0.1", port="5432", database="postgres")
        cursor = connection.cursor()

        cursor.execute(query)
        rows = cursor.fetchall()
        DisplayWindow(rows, query, "Result")

    except Exception as e:
        print("Error while connecting to PostgreSQL", e)

    else:
        cursor.close()
        connection.close()
        print("PostgreSQL connection is closed")

def custom_query():
    input_text = my_input.get()
    execute_query(input_text)

execute_button = tkinter.Button(second_frame, text="Execute", command=custom_query, foreground = 'red')
execute_button.grid(column=3, row=3)

print_database = [
    "Student",
    "Faculty",
    "College",
    "Department",
    "Degree",
    "Internship",
    "Project",
    "Company",
    "Placement"
    ]

print_database_sql = [
    "SELECT * FROM student;",
    "SELECT * FROM faculty;",
    "SELECT * FROM college;",
    "SELECT * FROM department;",
    "SELECT * FROM degree;",
    "SELECT * FROM internship;",
    "SELECT * FROM project;",
    "SELECT * FROM company;",
    "SELECT * FROM placement;",
]

start = 5
tkinter.Label(second_frame, text="Relations",foreground = "#%02x%02x%02x" % (7,47,95), font=("Helvetica", 14, "bold", "underline")).grid(column=1, row= 4, pady=(30, 10))

def button_trigger3(idx):
    execute_query(print_database_sql[idx])

for query_idx3 in range(len(print_database)):
    tkinter.Label(
                    second_frame,
                    text=print_database[query_idx3],
                    font=("Helvetica", 8, "normal")
                ).grid(
                    column=1,
                    columnspan=2,
                    row=(start + query_idx3),
                    pady=(10, 10),
                    padx=(30, 30),
                )
    tkinter.Button(second_frame, text="Show",foreground = 'red', command=lambda query_idx3=query_idx3: button_trigger3(query_idx3)).grid(column=3, row=(start + query_idx3))



######################### Simple queries ################################

simple_queries = [
    "Display all the details of students who have a CGPA greater than or equal to 9.",
    "Select the names of all the faculty members in the CSE department.",
    "Select all details of colleges with the college name as ‘BITS PILANI’.",
    "Display the degree names and specializations available in the ECE department.",
    "Display details about internships offered to students in college with college id PES.",
    "Display all the internships given, sorted according to project ID."
    ]
simple_queries_sql = [
    "SELECT * FROM Student WHERE cgpa >= 9;",
    "SELECT faculty_name FROM Faculty WHERE Dept_id='CSE';",
    "SELECT * FROM College WHERE college_name = 'BITS PILANI';",
    "SELECT degree_name,specialization FROM Degree WHERE dept_id = 'ECE';",
    "SELECT * FROM Internship WHERE college_id = 'PES';",
    "SELECT * FROM Internship ORDER BY project_id;"
]

start += len(print_database) + 1
tkinter.Label(second_frame, text="Simple Queries",foreground = "#%02x%02x%02x" % (7,47,95), font=("Helvetica", 14, "bold", "underline")).grid(column=1, row= (start - 1), pady=(30, 10))

def button_trigger(idx):
    execute_query(simple_queries_sql[idx])
for query_idx in range(len(simple_queries)):
    tkinter.Label(
                    second_frame,
                    text=simple_queries[query_idx],
                    font=("Helvetica", 8, "normal")
                ).grid(
                    column=1,
                    columnspan=2,
                    row=(start + query_idx),
                    pady=(10, 10),
                    padx=(30, 30),
                )

    tkinter.Button(second_frame, text="Execute", foreground = 'red', command=lambda query_idx=query_idx: button_trigger(query_idx)).grid(column=3, row=(start + query_idx))


######################### Complex queries ################################

complex_queries = [
    "Display all the details of students who have internships.",
    "Display names of companies which have not provided any internship or placement.",
    "Display names of companies who have offered placements to students with a CTC > 100000.",
    "Display names of faculty who are not incharge of any placements.",
    "Display names of the students who are working on an app as their project for their internship.",
    "Display the number of students who are working on an internship project which involves making a website.",
    "Display the number of degrees offered by each department.",
    "Find the name of the student with the highest CGPA."
    ]

complex_queries_sql = [
    """select * from student where student.SRN in (
    select internship.SRN from internship);""",
    """select company_name from company where company_id not in
    (select company_id from placement union select company_id from internship);""",
    """select company_name from company where company.company_id in (select placement.company_id
    from placement join (select * from placement where (placement.CTC > 100000))
    student on student.SRN = placement.SRN);""",
    """select faculty_name from faculty where faculty.faculty_id in (select faculty_id from faculty 
    except select faculty_id from placement);""",
    """select student_name from student join (select SRN,college_id from internship where internship.project_id in 
    (select project_id from project where upper(project_name) like '%APP')) new_table
    on new_table.SRN = student.SRN and new_table.college_id = student.college_id;""",
    """select count(*) from project where upper(project_name) like '%WEBSITE';""",
    """select dept_name, count from department
    join (select dept_id, count(*) from degree group by dept_id) new_table on new_table.dept_id = department.dept_id;""",
    """select student_name, max from student join (select max(cgpa) from student) new_table on new_table.max=student.cgpa;"""
]

start += len(simple_queries) + 1
tkinter.Label(second_frame, text="Complex Queries", foreground = "#%02x%02x%02x" % (7,47,95), font=("Helvetica", 14, "bold", "underline")).grid(column=1, row=(start - 1), pady=(30, 10))

def button_trigger2(idx):
    execute_query(complex_queries_sql[idx])

for query_idx2 in range(len(complex_queries)):
    tkinter.Label(
                    second_frame,
                    text=complex_queries[query_idx2],
                    font=("Helvetica", 8, "normal")
                ).grid(
                    column=1,
                    columnspan=2,
                    row=(start + query_idx2),
                    pady=(10, 10),
                    padx=(30, 30),
                )
    tkinter.Button(second_frame, text="Execute", foreground = "red",command=lambda query_idx2=query_idx2: button_trigger2(query_idx2)).grid(column=3, row=(start + query_idx2))

window.mainloop()
