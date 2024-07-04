defmodule LiveBudget.BudgetFactory do
  alias LiveBudget.Budgets.{Budget, BudgetLine}

  defmacro __using__(_opts) do
    quote do
      def budget_factory do
        %Budget{
          name: "MyBudget",
          recurring: true,
          start_at: random_utcdatetime(Enum.random(1..9)),
          end_at: random_utcdatetime(Enum.random(10..30)),
          type: :yearly,
          user: build(:user)
        }
      end

      def budget_line_factory do
        %BudgetLine{
          amount: "100.0",
          concept: "savings",
          budget: build(:budget),
          category: build(:category)
        }
      end

      defp random_utcdatetime(day) do
        {:ok, date} = Date.new(2023, 03, day)
        UTCDateTime.from_date(date)
      end
    end
  end
end
