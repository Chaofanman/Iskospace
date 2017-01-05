defmodule Iskospace.Tag do
	use Iskospace.Web, :model

	schema "tags" do
		field :tag, :string
		belongs_to :post, Iskospace.Post

		timestamps()
	end

	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:tag, :post_id])
		|> validate_required([:tag, :post_id])
	end
end