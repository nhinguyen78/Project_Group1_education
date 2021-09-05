import csv
import os
import random
from datetime import datetime
import time
from decimal import Decimal
from faker import Faker


fake = Faker()

def str_time_prop(start, end, time_format, prop):

    stime = time.mktime(time.strptime(start, time_format))
    etime = time.mktime(time.strptime(end, time_format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(time_format, time.localtime(ptime))

def random_date(start, end, prop):
    return str_time_prop(start, end, '%m/%d/%Y', prop)


def create_csv_file_Transaction_Info():
    # pdb.set_trace()
    time_stampe = datetime.now().strftime("%Y_%m_%d-%I_%M_%S_%p")
    raw_path = os.path.dirname(__file__)
    with open(f'{raw_path}\CoursesData-{time_stampe}.csv', 'w', newline='') as csvfile:
        fieldnames = ['Index','Transaction_ID','Instructor_Name',
        'Date of Birth', 'Course_Name', 'Gender', 
        'Rating_class', 'Student_Name', 'Class_recommendation', 'Email', 
        'Instructor_rating', 'Final_Score', 'Registered_date']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        RECORD_COUNT = 2000
        writer.writeheader()
        for i in range(RECORD_COUNT):
            writer.writerow(
                {
                    'Index': i,
                    'Transaction_ID': fake.random_int(1,2000),
                    'Instructor_Name': random.choice(['Erik Hawkins, Ph.D','Lauren Davis, Master','Patrick Duran, Ph.D','Teresa Norris, Ph.D','Chad Giles, Ph.D',
                    'Matthew Hunter, Master','Mrs. Julia Herman, Master','Kristina Wilson, Ph.D','Ryan Hamilton, Ph.D','Richard Donovan, Master','Nicholas Sanchez, Ph.D','Paul Jones, Ph.D']),
                    'Course_Name': random.choice([
                        'Artificial intelligence course','Machine learning course','Network Security Course','Moral Hacking Course','Website optimization course','Full Stack Developer Course','Web Development Course',
                        'Php and MySQL','Advanced UI Design','Graphic Design', 
                        'ONLINE_Artificial intelligence course','ONLINE_Machine learning course','ONLINE_Network Security Course','ONLINE_Moral Hacking Course','ONLINE_Website optimization course','ONLINE_Full Stack Developer Course','ONLINE_Web Development Course',
                        'ONLINE_Php and MySQL','ONLINE_Advanced UI Design','ONLINE_Graphic Design']),
                    'Student_Name': fake.name(),
                    'Gender':random.choice(['Male', 'Female']),
                    'Email': fake.email(),
                    'Date_of_Birth': random_date("1/1/2017", "6/1/2021", random.random()),
                    'Final_Score': fake.random_int(1,10),
                    'Instructor_rating': fake.random_int(1,5),
                    'Rating_class': fake.random_int(1,5),
                    'Class_recommendation':random.choice(['Yes', 'No']),
                    'Registered_date': random_date("1/1/2017", "6/1/2021", random.random())
                    
                }
)
            
dir_path = os.path.dirname(os.path.abspath(__file__))

DimCourse = f'{dir_path}\\workingFolder\\DimCourse.csv'
DimInstructor = f'{dir_path}\\workingFolder\\DimInstructor.csv'
DimStudent = f'{dir_path}\\workingFolder\\DimStudent.csv'
FactTransaction = f'{dir_path}\\workingFolder\\FactTransaction.csv'
 
def create_empty_table():
    with open(DimCourse, 'w', newline='') as WorkingFolder:
        fieldnames = ['Course_ID','Course_Name']
        writer = csv.DictWriter(WorkingFolder, fieldnames=fieldnames)
        writer.writeheader()
 
    with open(DimInstructor, 'w', newline='') as WorkingFolder:
        fieldnames = ['Instructor_ID','Instructor_Name','Instructor_rank', 'Ranked_change']
        writer = csv.DictWriter(WorkingFolder, fieldnames=fieldnames)
        writer.writeheader() 
 
    with open(DimStudent, 'w', newline='') as WorkingFolder:
        fieldnames = ['Student_ID', 'Student_Name', 'Email', 'Date_of_birth', 'Gender', 'StartDate', 'EndDate']
        writer = csv.DictWriter(WorkingFolder, fieldnames=fieldnames)
        writer.writeheader()
 
    with open(FactTransaction, 'w', newline='') as WorkingFolder:
        fieldnames = ['Transaction_ID', 'Instructor_ID', 'Student_ID', 'Course_Name', 'Rating_class',
        'Class_recommendation', 'Final_Score', 'Instructor_rating', 'Registered_date']
        writer = csv.DictWriter(WorkingFolder, fieldnames=fieldnames)
        writer.writeheader()
              

if __name__ == '__main__':
    t1 = datetime.now()
    print('Creating data...')
    create_empty_table()
    t2 = datetime.now()
    print(f"Done in time {t2-t1}")
