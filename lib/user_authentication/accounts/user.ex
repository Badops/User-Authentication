defmodule UserAuthentication.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :crypted_password, :string
    field :email, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @required_fields [:email, :password]
  @optional_fields []

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> hashed_password()
  end

  defp hashed_password(changeset) do
    case changeset do
    	%Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
    		 put_change(changeset, :crypted_password, Comeonin.Bcrypt.hashpwsalt(pass))
      _ -> changeset
    end
  end
end
