defmodule LiveBudget.CategoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveBudget.Categories` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        code: "some code",
        description: "some description",
        icon: "some icon",
        name: "some name"
      })
      |> LiveBudget.Categories.create_category()

    category
  end
end
