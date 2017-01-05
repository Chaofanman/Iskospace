defmodule Iskospace.Post do
	use Iskospace.Web, :model

	schema "posts" do
		field :title, :string
		field :body, :string
		belongs_to :user, Iskospace.User
		has_many :comments, Iskospace.Comment
		has_many :taggings, Iskospace.Tagging
		has_many :tags, through: [:taggings, :tags]

		timestamps()
	end

	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:title, :body])
		|> validate_required([:title, :body])
	end
end
