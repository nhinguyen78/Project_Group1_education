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
        'Class_Type', 'Date of Birth', 'Course_Name', 'Gender', 
        'Rating_class', 'Student_Name', 'Class_recommendation', 'Email', 
        'Instructor_rating', 'Instructor_level', 'Final_Score', 'Registered_date']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        RECORD_COUNT = 2000
        writer.writeheader()
        for i in range(RECORD_COUNT):
            writer.writerow(
                {
                    'Index': i,
                    'Transaction_ID': fake.random_int(1,2000),
                    'Instructor_Name': random.choice(['Erik Hawkins','Lauren Davis','Patrick Duran','Teresa Norris','Chad Giles',
                    'Matthew Hunter','Mrs. Julia Herman','Kristina Wilson','Ryan Hamilton','Richard Donovan','Nicholas Sanchez','Paul Jones',
                    'Dr. Kenneth Patterson MD','Toni Williams','Sarah Henry','Heather Hoffman','Zachary Holland','Jennifer Kelly',
                    'Robert Campbell','Jonathan Fisher']),
                    'Instructor_rating': fake.random_int(1,5),
                    'Rating_class': fake.random_int(1,5),
                    'Class_recommendation':random.choice(['Yes', 'No']),
                    'Class_Type': random.choice(['Online', 'Offline']),
                    'Registered_date': random_date("1/1/2017", "6/1/2021", random.random())
                    
                }
)

if __name__ == '__main__':
    print('Creating a fake data...')
    create_csv_file_Transaction_Info()
