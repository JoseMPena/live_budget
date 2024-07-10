defmodule LiveBudgetWeb.UserLoginLive do
  use LiveBudgetWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-md">
      <div class="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700">
        <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
          <.header class="text-center">
            Sign in to your account
          </.header>
          <.simple_form
            for={@form}
            id="login_form"
            action={~p"/users/log_in"}
            class="space-y-4 md:space-y-6"
            phx-update="ignore"
          >
            <Input.primary field={@form[:email]} type="email" placeholder="Email" required />
            <Input.primary field={@form[:password]} type="password" placeholder="Password" required />

            <:actions>
              <Input.input
                type="checkbox"
                field={@form[:remember_me]}
                name="remember_me"
                label="Remember me"
              />
              <.link
                href={~p"/users/reset_password"}
                class="font-semibold text-green-600 hover:underline dark:text-green-500"
              >
                Forgot your password?
              </.link>
            </:actions>
            <:actions>
              <Button.button phx-disable-with="Logging in..." color="success" class="w-full">
                Log in <span aria-hidden="true">→</span>
              </Button.button>
            </:actions>
            <:actions>
              <p className="text-sm text-gray-900 dark:text-white">
                Don’t have an account yet?
                <.link
                  href={~p"/users/register"}
                  class="font-semibold text-green-600 hover:underline dark:text-green-500"
                >
                  Sign Up
                </.link>
              </p>
            </:actions>
          </.simple_form>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
