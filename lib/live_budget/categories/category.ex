defmodule LiveBudget.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "categories" do
    field :code, :string
    field :name, :string
    field :description, :string
    field :icon, :string

    has_many :budget_lines, LiveBudget.Budgets.BudgetLine

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:code, :name, :description, :icon])
    |> validate_required([:code, :name])
    |> unique_constraint(:code)
  end
end
