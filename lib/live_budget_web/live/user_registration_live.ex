defmodule LiveBudgetWeb.UserRegistrationLive do
  use LiveBudgetWeb, :live_view

  alias LiveBudget.Accounts
  alias LiveBudget.Accounts.User

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-md">
      <.header class="text-center">
        Register for an account
      </.header>

      <.simple_form
        for={@form}
        id="registration_form"
        phx-submit="save"
        phx-change="validate"
        phx-trigger-action={@trigger_submit}
        action={~p"/users/log_in?_action=registered"}
        method="post"
      >
        <.error :if={@check_errors}>
          Oops, something went wrong! Please check the errors below.
        </.error>

        <Input.primary field={@form[:email]} type="email" label="Email" required />
        <Input.primary field={@form[:password]} type="password" label="Password" required />

        <:actions>
          <Button.button phx-disable-with="Creating account..." class="w-full">
            Create an account
          </Button.button>
        </:actions>
        <:actions>
          <p className="text-sm text-gray-900 dark:text-white">
            Already registered?
            <.link navigate={~p"/users/log_in"} class="font-semibold text-brand hover:underline">
              Log in
            </.link>
          </p>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/users/confirm/#{&1}")
          )

        changeset = Accounts.change_user_registration(user)
        {:noreply, socket |> assign(trigger_submit: true) |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_registration(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
