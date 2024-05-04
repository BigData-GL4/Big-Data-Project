import os


def shuffle_data(data, output_folder="Data"):
    shuffled_data = data.sample(frac=1)  # Shuffle using sample with frac=1

    # Ensure output folder exists (create if needed)
    os.makedirs(output_folder, exist_ok=True)  # Create folder if it doesn't exist

    # Generate a random filename (optional, modify if needed)
    filename = f"shuffled_measles.csv"

    # Save the shuffled data to a CSV file in the specified folder
    shuffled_data.to_csv(os.path.join(output_folder, filename), index=False)


if __name__ == "__main__":
    import pandas as pd

    # Load the data from the CSV file
    data = pd.read_csv("Data/all-measles-rates.csv")

    # Shuffle the data and save it to a new file
    shuffle_data(data)