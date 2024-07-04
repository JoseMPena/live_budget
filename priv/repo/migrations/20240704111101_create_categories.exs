defmodule LiveBudget.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :code, :string
      add :name, :string
      add :description, :string
      add :icon, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:categories, [:name])
  end
end
