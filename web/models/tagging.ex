defmodule Iskospace.Tagging do
	use Iskospace.Web, :model

	schema "taggings" do
		belongs_to :post, Iskospace.Post
		belongs_to :tag, Iskospace.Tag

		timestamps
	end
end