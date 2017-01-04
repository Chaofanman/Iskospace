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
		|> get_tags
	end

	defp get_tags(changeset) do
		tags = get_change(changeset, :tags)
			|> to_string
			|> String.split(",")
			|> Enum.map(&save_to_database/1)
		changeset
	end

	defp save_to_database(tag) do
		tag 
		|> String.trim(" ")
		|> IO.inspect 
	end

end
