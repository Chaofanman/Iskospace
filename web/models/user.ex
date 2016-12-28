defmodule Iskospace.User do
	use Iskospace.Web, :model
	import Comeonin.Bcrypt, only: [hashpwsalt: 1]

	schema "users" do
		field :first_name, :string
		field :last_name, :string
		field :username, :string
		field :batch, :integer
		field :email, :string
		field :password_digest, :string
		has_many :posts, Iskospace.Post

		timestamps()
		field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
	end

	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:first_name, :last_name, :username, :batch, :email, :password, :password_confirmation])
		|> validate_required([:username, :email, :password, :password_confirmation])
		|> hash_password
	end

	defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:password_digest, hashpwsalt(password))
    else
      changeset
    end
  end
end
