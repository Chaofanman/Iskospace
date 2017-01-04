defmodule Iskospace.Post do
	use Iskospace.Web, :model

	schema "posts" do
		field :title, :string
		field :body, :string
		belongs_to :user, Iskospace.User
		has_many :comments, Iskospace.Comment

		timestamps()

		field :tags, :string, virtual: true
	end

	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:title, :body, :tags])
		|> validate_required([:title, :body])
	end
end
