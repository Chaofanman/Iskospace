defmodule Iskospace.Tag do
	use Iskospace.Web, :model

	schema "tags" do
		field :tags, :string
		has_many :posts, Iskospace.Post

		timestamps()
	end

	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:tags])
		|> validate_required([:tags])
	end
end