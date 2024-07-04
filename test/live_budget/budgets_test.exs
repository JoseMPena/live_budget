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
      assert Budgets.list_budgets(%{user_id: budget.user_id}) |> Enum.map(& &1.id) == [
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

  describe "budget_lines" do
    alias LiveBudget.Budgets.BudgetLine

    @invalid_attrs %{amount: nil, concept: nil, budget_id: nil, category_id: nil}

    setup do
      budget = insert(:budget)

      budget_line =
        insert(:budget_line, budget: budget)

      %{budget_line: budget_line, user: budget.user, budget: budget}
    end

    test "list_budget_lines/0 returns all budget_lines", %{
      budget_line: budget_line,
      budget: budget
    } do
      assert Budgets.list_budget_lines(%{budget_id: budget.id}) |> Enum.map(& &1.id) == [
               budget_line.id
             ]
    end

    test "get_budget_line!/1 returns the budget_line with given id", %{budget_line: budget_line} do
      assert Budgets.get_budget_line!(budget_line.id).id == budget_line.id
    end

    test "create_budget_line/1 with valid data creates a budget_line" do
      valid_attrs = params_with_assocs(:budget_line)
      assert {:ok, %BudgetLine{} = budget_line} = Budgets.create_budget_line(valid_attrs)
      assert budget_line.amount == Decimal.new(valid_attrs.amount)
      assert budget_line.concept == valid_attrs.concept
      assert budget_line.budget_id == valid_attrs.budget_id
      assert budget_line.category_id == valid_attrs.category_id
    end

    test "create_budget_line/1 with invalid data returns error changeset" do
      assert {:error,
              %Ecto.Changeset{
                errors: [
                  concept: {"can't be blank", _},
                  amount: {"can't be blank", _},
                  budget_id: {"can't be blank", _},
                  category_id: {"can't be blank", _}
                ]
              }} = Budgets.create_budget_line(@invalid_attrs)
    end

    test "update_budget_line/2 with valid data updates the budget_line", %{
      budget_line: budget_line
    } do
      update_attrs = %{amount: "456.7", concept: "some updated concept"}

      assert {:ok, %BudgetLine{} = budget_line} =
               Budgets.update_budget_line(budget_line, update_attrs)

      assert budget_line.amount == Decimal.new("456.7")
      assert budget_line.concept == "some updated concept"
    end

    test "update_budget_line/2 with invalid data returns error changeset", %{
      budget_line: budget_line
    } do
      assert {:error, %Ecto.Changeset{}} = Budgets.update_budget_line(budget_line, @invalid_attrs)
    end

    test "delete_budget_line/1 deletes the budget_line", %{budget_line: budget_line} do
      assert {:ok, %BudgetLine{}} = Budgets.delete_budget_line(budget_line)
      assert_raise Ecto.NoResultsError, fn -> Budgets.get_budget_line!(budget_line.id) end
    end

    test "change_budget_line/1 returns a budget_line changeset", %{budget_line: budget_line} do
      assert %Ecto.Changeset{} = Budgets.change_budget_line(budget_line)
    end
  end
end
