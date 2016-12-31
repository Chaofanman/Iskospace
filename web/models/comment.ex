defmodule Iskospace.Comment do
	use Iskospace.Web, :model 

	schema "comments" do
		field :body, :string 
		belongs_to :post, Iskospace.Post
		belongs_to :user, Iskospace.User

		timestamps()	
	end

	def changeset(struct, params \\ :empty) do
		struct
		|> cast(params, [:body])
	end
end