defmodule Iskospace.Tag do
	use Iskospace.Web, :model

	schema "tags" do
		field :title, :string

		has_many :taggings, Iskospace.Tagging
		has_many :posts, through: [:taggings, :posts]

		timestamps
	end
end