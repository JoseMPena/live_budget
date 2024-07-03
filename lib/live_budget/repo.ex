defmodule LiveBudget.Repo do
  use Ecto.Repo,
    otp_app: :live_budget,
    adapter: Ecto.Adapters.Postgres
end
