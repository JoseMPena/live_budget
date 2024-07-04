defmodule LiveBudget.Factory do
  use ExMachina.Ecto, repo: LiveBudget.Repo
  use LiveBudget.AccountFactory
  use LiveBudget.BudgetFactory
  use LiveBudget.CategoriesFactory
end
