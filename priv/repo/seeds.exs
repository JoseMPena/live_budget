# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LiveBudget.Repo.insert!(%LiveBudget.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LiveBudget.Categories

[
  %{icon: "income.png", name: "Income", description: "", code: "INCOME"},
  %{icon: "transfer_in.png", name: "Inbound Transfer", description: "", code: "TRANSFER_IN"},
  %{icon: "transfer_out.png", name: "Outbound Transfer", description: "", code: "TRANSFER_OUT"},
  %{icon: "loan_debt.png", name: "Loan/Debt Payments", description: "", code: "LOAN_PAYMENTS"},
  %{icon: "bank_fees.png", name: "Bank Fees", description: "", code: "BANK_FEES"},
  %{icon: "entertainment.png", name: "Entertainment", description: "", code: "ENTERTAINMENT"},
  %{icon: "food_and_drinks.png", name: "Food and Drink", description: "", code: "FOOD_AND_DRINK"},
  %{icon: "commerce.png", name: "Commerce", description: "", code: "GENERAL_MERCHANDISE"},
  %{icon: "housing_expense.png", name: "Home/Housing", description: "", code: "HOME_IMPROVEMENT"},
  %{icon: "medical_expense.png", name: "Medical", description: "", code: "MEDICAL"},
  %{icon: "personal_care.png", name: "Personal Care", description: "", code: "PERSONAL_CARE"},
  %{icon: "services.png", name: "Services", description: "", code: "GENERAL_SERVICES"},
  %{
    icon: "government_ngos.png",
    name: "Government and ONGs",
    description: "",
    code: "GOVERNMENT_AND_NON_PROFIT"
  },
  %{icon: "transportation.png", name: "Transportation", description: "", code: "TRANSPORTATION"},
  %{icon: "travel.png", name: "Travel", description: "", code: "TRAVEL"},
  %{
    icon: "rent_utilities.png",
    name: "Rent and Utilities",
    description: "",
    code: "RENT_AND_UTILITIES"
  }
]
|> Enum.each(fn attrs -> Categories.create_category(attrs) end)
