import csv
from random import shuffle
from time import sleep

def generate_streaming_data(filename, delay=2):


    with open(filename, 'r') as csvfile:
        reader = csv.reader(csvfile)
        data = list(reader)  # Read all rows into a list
        shuffle(data)  # Randomly shuffle the data for a stream-like behavior

    for row in data:
        yield row
        sleep(delay)  # Introduce delay between yielding rows

# Example usage
for row in generate_streaming_data("../Data/shuffled_measles.csv"):
    print(row)