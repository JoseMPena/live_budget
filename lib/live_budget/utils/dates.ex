defmodule LiveBudget.Utils.Dates do
  def utc_beginning_of_month do
    Date.utc_today()
    |> Date.beginning_of_month()
    |> UTCDateTime.from_date()
  end

  def utc_end_of_month do
    Date.utc_today()
    |> Date.end_of_month()
    |> UTCDateTime.from_date()
  end
end
