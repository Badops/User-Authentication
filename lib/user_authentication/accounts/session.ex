defmodule UserAuthentication.Accounts.Session do
  import UserAuthentication.Accounts
  import Plug.Conn
  
  def login(params) do
    downcase = String.downcase(params["email"])
    user = get_user_by_email(downcase)
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end
    
  def current_user(conn) do
    id = get_session(conn, :current_user)
    if id do
      get_user(id)
    end
  end

  def logged_in?(conn) do
    !!current_user(conn)
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end
end