
import pandas as pd
from pathlib import Path

# 1.main project folder
project_path = Path(__file__).resolve().parent.parent

# 2. input and output file paths
raw_path = (
    project_path
    / "data"
    / "raw"
    / "Electric Vehicle Sales by State in India.csv"
)

output_path = (
    project_path
    / "data"
    / "processed"
    / "ev_sales_cleaned.csv"
)

# 3.  original dataset
df = pd.read_csv(raw_path)

print("Original dataset shape:", df.shape)

# 4. Convert columns to correct data types
df["Date"] = pd.to_datetime(df["Date"], errors="raise")
df["Year"] = df["Year"].astype("int64")

df["EV_Sales_Quantity"] = pd.to_numeric(
    df["EV_Sales_Quantity"],
    errors="raise"
)

# 5. Remove extra spaces from text columns
text_columns = df.select_dtypes(include=["object"]).columns

for column in text_columns:
    df[column] = df[column].str.strip()

# 6. Validate important conditions
assert df["Date"].notna().all()
assert df["Year"].notna().all()
assert (df["EV_Sales_Quantity"] >= 0).all()

# 7. Save the cleaned dataset
df.to_csv(output_path, index=False)

print("\nCleaning completed successfully!")
print("Cleaned dataset shape:", df.shape)
print("Saved file:", output_path)

print("\nMissing values after cleaning:")
print(df.isnull().sum())

# Verify the saved CSV
print("\n--- SAVED FILE VERIFICATION ---")

check_df = pd.read_csv(output_path)

print("Saved file shape:", check_df.shape)
print("Columns:", check_df.columns.tolist())
print("Duplicate rows:", check_df.duplicated().sum())
print("Missing values:", check_df.isnull().sum().sum())

print("\nFirst 5 rows of saved file:")
print(check_df.head())