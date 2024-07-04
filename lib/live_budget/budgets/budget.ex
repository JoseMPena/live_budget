defmodule LiveBudget.Budgets.Budget do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_fields [:name, :start_at, :end_at, :type, :user_id]

  schema "budgets" do
    field :name, :string
    field :type, Ecto.Enum, values: [:weekly, :monthly, :yearly, :custom]
    field :start_at, UTCDateTime
    field :end_at, UTCDateTime
    field :recurring, :boolean

    belongs_to :user, LiveBudget.Accounts.User, foreign_key: :user_id, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(budget, attrs) do
    budget
    |> cast(attrs, @required_fields ++ [:recurring])
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint(:start_at, name: "budgets_dates_range_index", match: :exact)
    |> unique_constraint(:end_at, name: "budgets_dates_range_index", match: :exact)
  end
end
