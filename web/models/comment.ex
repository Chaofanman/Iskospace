defmodule Iskospace.Comment do
	use Iskospace.Web, :model 

	schema "comments" do
		field :author, :string
		field :body, :string 
		belongs_to :post, Iskospace.Post

		timestamps()	
	end

	def changeset(model, params \\ :empty) do
		struct
		|> cast(params, [:author, :body])
	end
end