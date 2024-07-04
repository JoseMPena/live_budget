defmodule LiveBudget.Budgets do
  @moduledoc """
  The Budgets context.
  """

  import Ecto.Query, warn: false
  alias LiveBudget.Repo
  alias LiveBudget.Filters
  alias LiveBudget.Utils.Dates

  alias LiveBudget.Budgets.Budget

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
end
