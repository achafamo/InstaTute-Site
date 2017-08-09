import datefinder
import datetime
import requests

def createEvents(filename, className):
    #class_time = get_time(filename)
    dates = []
    with open(filename, 'r') as f:
        for line in f:
            #print line
            matches = datefinder.find_dates(line)

            for match in matches:
                event = Event(className, line, match)
                print event.start_date
                dates.append(event)
    return dates
    #After done getting the events, I need to post this to some url on
def get_time(filename):
    #should get the class time of the class for the given syllabus
    pass



class Event:
    def __init__(self, name, description, start_date, end_date = None):
        self.name = name
        self.description = description
        self.start_date = start_date
        if end_date:
            self.end_date = end_date
    def __str__(self):
        return self.name + " " + self.description + " " + " " +str(self.start_date)
if __name__ == '__main__':		
    events = createEvents("syllabus.txt", "Game Theory")
    url = 'http://localhost/3000/events/create'

    for event in events:
        print event
   
    #need to
    event_params = {"event_params": events[-1]}
    res = requests.post(url, data=event_params)
    print(res.text)
    #if time part is 0 make it equal to classtime		
    #figure out how to access text file from remote database

