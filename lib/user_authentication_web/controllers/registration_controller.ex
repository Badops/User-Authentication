defmodule UserAuthenticationWeb.RegistrationController do
  use UserAuthenticationWeb, :controller
	alias UserAuthentication.Accounts.User
	alias UserAuthentication.Accounts

  def new(conn, params) do
    changeset = User.changeset(%User{}, params)
    render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
		
		case Accounts.create_user(user_params) do
			{:ok, _changeset} ->
				conn
				|> put_flash(:info, "Your account was created")
				|> redirect(to: "/")
			
			{:error, changeset} ->
				conn
				|> put_flash(:info, "Unable to create account")
				|> render("new.html", changeset: changeset)
  	end
	
	end
end