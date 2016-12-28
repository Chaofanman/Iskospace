defmodule Iskospace.Post do
	use Iskospace.Web, :model

	schema "posts" do
		field :title, :string
		field :body, :string
		# belongs_to :user, Iskospace.User

		timestamps()
	end

	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:title, :body])
		|> validate_required([:title, :body])
	end
end
