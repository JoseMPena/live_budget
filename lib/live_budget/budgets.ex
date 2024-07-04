defmodule LiveBudget.Budgets do
  @moduledoc """
  The Budgets context.
  """

  import Ecto.Query, warn: false
  alias LiveBudget.Repo
  alias LiveBudget.Filters
  alias LiveBudget.Utils.Dates

  alias LiveBudget.Budgets.Budget
  alias LiveBudget.Categories
  alias LiveBudget.Categories.Category

  @doc """
  Returns the list of budgets for a user.

  ## Examples

      iex> list_budgets(filters)
      [%Budget{}, ...]

  """
  def list_budgets(filters) when is_map(filters) do
    Budget
    |> Filters.filter_budgets_with(filters)
    |> Repo.all()
  end

  @doc """
  Gets a single budget.

  Raises `Ecto.NoResultsError` if the Budget does not exist.

  ## Examples

      iex> get_budget!(123)
      %Budget{}

      iex> get_budget!(456)
      ** (Ecto.NoResultsError)

  """
  def get_budget!(id), do: Repo.get!(Budget, id)

  @doc """
  Creates a budget.

  ## Examples

      iex> create_budget(%{field: value})
      {:ok, %Budget{}}

      iex> create_budget(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_budget(attrs \\ %{}) do
    %Budget{}
    |> Budget.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a budget.

  ## Examples

      iex> update_budget(budget, %{field: new_value})
      {:ok, %Budget{}}

      iex> update_budget(budget, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_budget(%Budget{} = budget, attrs) do
    budget
    |> Budget.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a budget.

  ## Examples

      iex> delete_budget(budget)
      {:ok, %Budget{}}

      iex> delete_budget(budget)
      {:error, %Ecto.Changeset{}}

  """
  def delete_budget(%Budget{} = budget) do
    Repo.delete(budget)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking budget changes.

  ## Examples

      iex> change_budget(budget)
      %Ecto.Changeset{data: %Budget{}}

  """
  def change_budget(%Budget{} = budget, attrs \\ %{}) do
    Budget.changeset(budget, attrs)
  end

  def create_sample_budget(user_id) do
    attrs = %{
      name: "My First Budget",
      start_at: Dates.utc_beginning_of_month(),
      end_at: Dates.utc_end_of_month(),
      recurring: false,
      type: :monthly,
      user_id: user_id
    }

    Repo.transaction(fn ->
      with {:ok, budget} <- create_budget(attrs) do
        budget
      else
        {:error, error} -> Repo.rollback(error)
        _ -> Repo.rollback("Unknown error")
      end
    end)
  end

  alias LiveBudget.Budgets.BudgetLine

  @doc """
  Returns the list of budget_lines.

  ## Examples

      iex> list_budget_lines(%{})
      [%BudgetLine{}, ...]

  """
  def list_budget_lines(filters) when is_map(filters) do
    BudgetLine
    |> Filters.filter_budget_lines_with(filters)
    |> Repo.all()
  end

  @doc """
  Gets a single budget_line.

  Raises `Ecto.NoResultsError` if the Budget line does not exist.

  ## Examples

      iex> get_budget_line!(123)
      %BudgetLine{}

      iex> get_budget_line!(456)
      ** (Ecto.NoResultsError)

  """
  def get_budget_line!(id), do: Repo.get!(BudgetLine, id)

  def get_user_budget_lines(user_id), do: Repo.get_by(BudgetLine, %{user_id: user_id})

  @doc """
  Creates a budget_line.

  ## Examples

      iex> create_budget_line(%{field: value})
      {:ok, %BudgetLine{}}

      iex> create_budget_line(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_budget_line(attrs \\ %{}) do
    %BudgetLine{}
    |> BudgetLine.changeset(attrs)
    |> Repo.insert()
  end

  def create_sample_budget_line(%Budget{} = budget, %Category{} = category) do
    %{
      amount: Enum.random(100..1000),
      concept: category.name,
      budget_id: budget.id,
      category_id: category.id
    }
    |> create_budget_line()
  end

  def create_sample_budget_lines(%Budget{} = budget) do
    Categories.list_categories()
    |> Enum.each(fn category -> create_sample_budget_line(budget, category) end)
  end

  @doc """
  Updates a budget_line.

  ## Examples

      iex> update_budget_line(budget_line, %{field: new_value})
      {:ok, %BudgetLine{}}

      iex> update_budget_line(budget_line, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_budget_line(%BudgetLine{} = budget_line, attrs) do
    budget_line
    |> BudgetLine.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a budget_line.

  ## Examples

      iex> delete_budget_line(budget_line)
      {:ok, %BudgetLine{}}

      iex> delete_budget_line(budget_line)
      {:error, %Ecto.Changeset{}}

  """
  def delete_budget_line(%BudgetLine{} = budget_line) do
    Repo.delete(budget_line)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking budget_line changes.

  ## Examples

      iex> change_budget_line(budget_line)
      %Ecto.Changeset{data: %BudgetLine{}}

  """
  def change_budget_line(%BudgetLine{} = budget_line, attrs \\ %{}) do
    BudgetLine.changeset(budget_line, attrs)
  end
end
