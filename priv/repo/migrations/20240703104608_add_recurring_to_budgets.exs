defmodule LiveBudget.Repo.Migrations.AddRecurringToBudgets do
  use Ecto.Migration

  def change do
    alter table(:budgets) do
      add :recurring, :boolean, default: false
    end

    create unique_index(
             :budgets,
             [:start_at, :end_at, :user_id],
             name: "budgets_dates_range_index",
             where: "user_id IS NOT NULL"
           )
  end
end
