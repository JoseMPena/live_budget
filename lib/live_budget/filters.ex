defmodule LiveBudget.Filters do
  import Ecto.Query, warn: false

  def filter_with(query, filter) do
    Enum.reduce(filter, query, fn
      {:user_id, user_id}, query ->
        from q in query, where: q.user_id == ^user_id

      {:budget_id, budget_id}, query ->
        from q in query, where: q.budget_id == ^budget_id

      {:name, name}, query ->
        from q in query, where: ilike(q.name, ^"%#{name}%")

      {:category, category_name}, query ->
        from q in query,
          join: c in assoc(q, :category),
          where: ilike(c.name, ^"%#{category_name}%")

      {:order, ordering_field}, query ->
        from q in query, order_by: {^ordering_field, :id}

      _, query ->
        query
    end)
  end

  def filter_budgets_with(query, filter) do
    query = filter_with(query, filter)

    Enum.reduce(filter, query, fn
      {:start_date, from}, query ->
        from q in query, where: q.start_at >= ^from

      {:end_date, to}, query ->
        from q in query, where: q.end_at <= ^to

      {:current_date, date}, query ->
        from q in query, where: q.end_at >= ^date

      {:recurring, boolean}, query ->
        from q in query, where: q.recurring == ^boolean

      {:bygone, boolean}, query ->
        today = current_date()

        if boolean do
          from q in query, where: q.end_at < ^today
        else
          from q in query, where: q.end_at >= ^today
        end

      _, query ->
        query
    end)
  end

  defp current_date() do
    {{_year, _month, _day} = date, _} = :calendar.local_time()
    {:ok, date} = Date.from_erl(date)

    date
  end
end
