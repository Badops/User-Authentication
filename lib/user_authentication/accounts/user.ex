defmodule UserAuthentication.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :crypted_password, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :crypted_password])
    |> validate_required([:email, :crypted_password])
    |> unique_constraint(:email)
  end
end
