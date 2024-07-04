defmodule LiveBudget.Budgets.BudgetLine do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_fields [:concept, :amount, :budget_id, :category_id]

  schema "budget_lines" do
    field :amount, :decimal
    field :concept, :string

    belongs_to :budget, LiveBudget.Budgets.Budget, foreign_key: :budget_id, type: :binary_id

    belongs_to :category, LiveBudget.Categories.Category,
      foreign_key: :category_id,
      type: :binary_id

    has_one :user, through: [:budget, :user]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(budget_line, attrs) do
    budget_line
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:budget_id)
  end
end
