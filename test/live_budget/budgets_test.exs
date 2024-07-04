defmodule LiveBudget.BudgetsTest do
  use LiveBudget.DataCase
  import LiveBudget.Factory

  alias LiveBudget.Budgets
  alias LiveBudget.Utils.Dates

  describe "budgets" do
    alias LiveBudget.Budgets.Budget

    @invalid_attrs %{name: nil, type: nil, start_at: nil, end_at: nil, user_id: nil}

    setup do
      user = insert(:user)
      budget = insert(:budget, user: user) |> Ecto.reset_fields([:user])
      %{budget: budget, user: user}
    end

    test "list_budgets/1 returns all budgets from a user", %{budget: budget} do
      assert Budgets.list_budgets(%{user_id: budget.user_id}) |> Enum.map(fn x -> x.id end) == [
               budget.id
             ]

      another_user = insert(:user)
      assert Budgets.list_budgets(%{user_id: another_user.id}) == []
    end

    test "get_budget!/1 returns the budget with given id", %{budget: budget} do
      assert Budgets.get_budget!(budget.id).id == budget.id
    end

    test "create_budget/1 with valid data creates a budget", %{user: user} do
      valid_attrs = params_for(:budget, user_id: user.id)
      assert {:ok, %Budget{} = budget} = Budgets.create_budget(valid_attrs)
      assert budget.name == valid_attrs.name
      assert budget.start_at == valid_attrs.start_at
      assert budget.end_at == valid_attrs.end_at

      assert budget.user_id == user.id
    end

    test "create_budget/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Budgets.create_budget(@invalid_attrs)
    end

    test "update_budget/2 with valid data updates the budget", %{budget: budget} do
      update_attrs = %{
        name: "some updated name"
      }

      assert {:ok, %Budget{} = budget} = Budgets.update_budget(budget, update_attrs)
      assert budget.name == "some updated name"
    end

    test "update_budget/2 with invalid data returns error changeset", %{budget: budget} do
      assert {:error, %Ecto.Changeset{}} = Budgets.update_budget(budget, @invalid_attrs)
      assert budget.id == Budgets.get_budget!(budget.id).id
    end

    test "delete_budget/1 deletes the budget", %{budget: budget} do
      assert {:ok, %Budget{}} = Budgets.delete_budget(budget)
      assert_raise Ecto.NoResultsError, fn -> Budgets.get_budget!(budget.id) end
    end

    test "change_budget/1 returns a budget changeset", %{budget: budget} do
      assert %Ecto.Changeset{} = Budgets.change_budget(budget)
    end
  end

  describe "sample budgets" do
    setup do
      %{user: insert(:user)}
    end

    test "creates a sample budget successfully", %{user: user} do
      {:ok, budget} = Budgets.create_sample_budget(user.id)

      assert is_map(budget)
      assert budget.name == "My First Budget"
      assert Dates.utc_beginning_of_month() == budget.start_at
      assert Dates.utc_end_of_month() == budget.end_at
      assert budget.user_id == user.id
    end
  end
end
