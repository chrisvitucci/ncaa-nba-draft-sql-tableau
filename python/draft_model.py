import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler

# Load data
df = pd.read_csv("draft_players.csv")

# Create draft outcome label
df["draft_result"] = df["pick_tier"].apply(
    lambda x: 1 if x in ["Top 3", "Lottery", "1st Round"] else 0
)

# Select features (from SQL insights)
features = [
    "PTS",
    "FGA",
    "efg_pct",
    "threep_pct",
    "TRB",
    "AST",
    "TOV"
]

X = df[features].dropna()
y = df.loc[X.index, "draft_result"]

# Train-test split
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.25, random_state=42
)

# Scale features (important for logistic regression)
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# Train model
model = LogisticRegression()
model.fit(X_train_scaled, y_train)

# Output coefficients
coefficients = pd.DataFrame({
    "Feature": features,
    "Coefficient": model.coef_[0]
}).sort_values(by="Coefficient", ascending=False)

print("Logistic Regression Coefficients:")
print(coefficients)

# Model accuracy
accuracy = model.score(X_test_scaled, y_test)
print("\nModel accuracy on test set:", round(accuracy, 3))
