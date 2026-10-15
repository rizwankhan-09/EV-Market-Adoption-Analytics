
import pandas as pd
from pathlib import Path

# Find the main project folder
project_path = Path(__file__).resolve().parent.parent

# Set the CSV file location
file_path = (
    project_path
    / "data"
    / "raw"
    / "Electric Vehicle Sales by State in India.csv"
)

# Load the CSV into a DataFrame
df = pd.read_csv(file_path)

print("Dataset loaded successfully!")
print("First 5 rows:")
print(df.head())

print("\nDataset shape:")
print(df.shape)

print("\nColumn names:")
print(df.columns.tolist())

print("\nDataset information:")
df.info()

print("\n--- DATA QUALITY CHECK ---")

# 1. Check missing values
print("\nMissing values:")
print(df.isnull().sum())

# 2. Check exact duplicate rows
print("\nDuplicate rows:")
print(df.duplicated().sum())

# 3. Check data types
print("\nData types:")
print(df.dtypes)

# 4. Check year range
print("\nYear range:")
print(df["Year"].min(), "-", df["Year"].max())

# 5. Check zero sales records
print("\nZero sales records:")
print((df["EV_Sales_Quantity"] == 0).sum())

# 6. Check negative sales records
print("\nNegative sales records:")
print((df["EV_Sales_Quantity"] < 0).sum())

# Investigate sales quantity
print("\n--- SALES QUANTITY ANALYSIS ---")

print("\nSales quantity summary:")
print(df["EV_Sales_Quantity"].describe())

print("\nZero vs non-zero records:")
print(
    df["EV_Sales_Quantity"]
    .eq(0)
    .value_counts()
)

print("\nRecords by year:")
print(
    df.groupby("Year")["EV_Sales_Quantity"]
    .agg(["count", "sum"])
)

print("\nSales by vehicle category:")
print(
    df.groupby("Vehicle_Category")["EV_Sales_Quantity"]
    .agg(["count", "sum"])
    .sort_values("sum", ascending=False)
)
# Check zero-sales records by year
zero_df = df[df["EV_Sales_Quantity"] == 0]

print("\nZero-sales records by year:")
print(zero_df.groupby("Year").size())

print("\nZero-sales records by vehicle category:")
print(zero_df.groupby("Vehicle_Category").size().sort_values(ascending=False))

print("\nUnique vehicle categories:")
print(df["Vehicle_Category"].unique())

print("\nUnique vehicle types:")
print(df["Vehicle_Type"].unique())
# Check whether each date matches its year and month
print("\n--- DATE VALIDATION ---")

df["Date"] = pd.to_datetime(df["Date"], errors="coerce")

print("Invalid dates:", df["Date"].isna().sum())

print(
    "Year mismatch:",
    (df["Date"].dt.year != df["Year"]).sum()
)

print(
    "Month mismatch:",
    (
        df["Date"].dt.month
        != pd.to_datetime(
            df["Month_Name"],
            format="%b",
            errors="coerce"
        ).dt.month
    ).sum()
)

# Check repeated combinations
keys = [
    "Date",
    "State",
    "Vehicle_Class",
    "Vehicle_Category",
    "Vehicle_Type"
]

print(
    "\nRepeated business-key rows:",
    df.duplicated(subset=keys).sum()
)
