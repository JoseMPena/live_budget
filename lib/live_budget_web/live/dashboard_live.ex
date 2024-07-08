defmodule LiveBudgetWeb.DashboardLive do
  alias LiveBudget.Accounts
  use LiveBudgetWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <h1>I'm the dashboard</h1>
    """
  end

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    {:ok, assign(socket, session_id: session["live_socket_id"], current_user: user)}
  end
end
