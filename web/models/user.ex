defmodule Iskospace.User do
	use Iskospace.Web, :model

	schema "users" do
		field :first_name, :string
		field :last_name, :string
		field :email, :string
		field :password, :string
		# has_many :posts, Iskospace.Post

		timestamps()
	end

	def changeset(struct, params \\%{}) do
		struct
		|> cast(params, [:first_name, :last_name, :email, :password])
		|> validate_required([:first_name, :last_name, :email, :password])
	end
end
