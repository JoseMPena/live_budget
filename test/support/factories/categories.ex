defmodule LiveBudget.CategoriesFactory do
  alias LiveBudget.Categories.Category

  defmacro __using__(_opts) do
    quote do
      def category_factory do
        %Category{
          name: sequence(:name, &"category#{&1}"),
          description: "A category object for testing",
          icon: "icon1",
          code: sequence(:code, &"CODE#{&1}")
        }
      end
    end
  end
end
