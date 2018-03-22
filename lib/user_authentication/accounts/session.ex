defmodule UserAuthentication.Accounts.Session do
  import UserAuthentication.Accounts

  def login(params) do
    downcase = String.downcase(params["email"])
    user = get_user_by_email(downcase)
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end
end