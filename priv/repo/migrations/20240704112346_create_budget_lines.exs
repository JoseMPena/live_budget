defmodule LiveBudget.Repo.Migrations.CreateBudgetLines do
  use Ecto.Migration

  def change do
    create table(:budget_lines, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :amount, :decimal
      add :concept, :string
      add :budget_id, references(:budgets, on_delete: :nothing, type: :binary_id), null: false

      add :category_id, references(:categories, on_delete: :nothing, type: :binary_id),
        null: false

      timestamps(type: :utc_datetime)
    end

    create index(:budget_lines, [:budget_id])
    create index(:budget_lines, [:category_id])
  end
end
