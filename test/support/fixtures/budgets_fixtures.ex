defmodule LiveBudget.BudgetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveBudget.Budgets` context.
  """

  @doc """
  Generate a budget.
  """
  def budget_fixture(attrs \\ %{}) do
    {:ok, budget} =
      attrs
      |> Enum.into(%{
        end_at: ~U[2024-07-02 10:41:00Z],
        name: "some name",
        start_at: ~U[2024-07-02 10:41:00Z],
        type: :weekly,
        user_id: 1
      })
      |> LiveBudget.Budgets.create_budget()

    budget
  end

  @doc """
  Generate a budget_line.
  """
  def budget_line_fixture(attrs \\ %{}) do
    {:ok, budget_line} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        concept: "some concept"
      })
      |> LiveBudget.Budgets.create_budget_line()

    budget_line
  end
end
