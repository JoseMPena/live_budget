defmodule LiveBudget.AccountFactory do
  alias LiveBudget.Accounts.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %User{
          email: sequence(:email, &"email-#{&1}@example.com"),
          hashed_password: Bcrypt.hash_pwd_salt("supersecret123")
        }
      end

      def set_password(user, password) do
        %{user | hashed_password: Bcrypt.hash_pwd_salt(password)}
      end
    end
  end
end
