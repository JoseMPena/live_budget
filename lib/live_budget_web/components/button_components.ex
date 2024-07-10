defmodule LiveBudgetWeb.ButtonComponents do
  use Phoenix.Component

  @doc """
  Renders a button.

  ## Examples

      <Button.button>Send!</.button>
      <Button.button phx-click="go" class="ml-2">Send!</.button>
  """
  attr :type, :string, default: nil
  attr :class, :string, default: nil
  attr :color, :string, default: ""
  attr :rest, :global, include: ~w(disabled form name value)

  slot :inner_block, required: true

  def button(%{color: "success outline"} = assigns) do
    assigns =
      assign(
        assigns,
        :class,
        assigns[:class] <>
          " hover:text-white border dark:hover:text-white text-green-700 border-green-700 hover:bg-green-800 focus:ring-green-300 dark:border-green-500 dark:text-green-500 dark:hover:bg-green-600 dark:focus:ring-green-800"
      )
      |> assign(:color, nil)

    button(assigns)
  end

  def button(%{color: "success"} = assigns) do
    assigns =
      assign(
        assigns,
        :class,
        assigns[:class] <>
          " text-white bg-green-700 hover:bg-green-800 focus:ring-green-300 dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800"
      )
      |> assign(:color, nil)

    button(assigns)
  end

  def button(%{color: "info outline"} = assigns) do
    assigns =
      assign(
        assigns,
        :class,
        assigns[:class] <>
          " hover:text-white border dark:hover:text-white text-white bg-blue-700 hover:bg-blue-800  focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700  dark:focus:ring-blue-800"
      )
      |> assign(:color, nil)

    button(assigns)
  end

  def button(%{color: "info"} = assigns) do
    assigns =
      assign(
        assigns,
        :class,
        assigns[:class] <>
          " text-blue-700 border-blue-700 hover:bg-blue-800 focus:ring-blue-300 dark:border-blue-500 dark:text-blue-500  dark:hover:bg-blue-500 dark:focus:ring-blue-800"
      )
      |> assign(:color, nil)

    button(assigns)
  end

  def button(%{color: "danger outline"} = assigns) do
    assigns =
      assign(
        assigns,
        :class,
        assigns[:class] <>
          " hover:text-white border dark:hover:text-white text-red-700 border-red-700 hover:bg-red-800 focus:outline-none focus:ring-red-300 dark:border-red-500 dark:text-red-500  dark:hover:bg-red-600 dark:focus:ring-red-900"
      )
      |> assign(:color, nil)

    button(assigns)
  end

  def button(%{color: "danger"} = assigns) do
    assigns =
      assign(
        assigns,
        :class,
        assigns[:class] <>
          " text-white bg-red-700 hover:bg-red-800 focus:ring-red-300 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900"
      )
      |> assign(:color, nil)

    button(assigns)
  end

  def button(%{color: "warning outline"} = assigns) do
    assigns =
      assign(
        assigns,
        :class,
        assigns[:class] <>
          " hover:text-white border dark:hover:text-white text-yellow-400 border-yellow-400 focus:ring-yellow-300 dark:border-yellow-300 dark:text-yellow-300 dark:hover:bg-yellow-400 dark:focus:ring-yellow-900"
      )
      |> assign(:color, nil)

    button(assigns)
  end

  def button(%{color: "warning"} = assigns) do
    assigns =
      assign(
        assigns,
        :class,
        assigns[:class] <>
          " text-white bg-yellow-400 hover:bg-yellow-500 focus:ring-yellow-300 dark:focus:ring-yellow-900"
      )
      |> assign(:color, nil)

    button(assigns)
  end

  def button(assigns) do
    ~H"""
    <button
      type={@type}
      class={[
        "phx-submit-loading:opacity-75 px-5 py-2.5",
        "text-sm font-semibold leading-6 focus:ring-4 focus:outline-none font-medium rounded-lg text-center me-2 mb-2",
        @class
      ]}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end
