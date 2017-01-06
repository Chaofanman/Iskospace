defmodule Iskospace.TagController do
	use Iskospace.Web, :controller

	alias Iskospace.Tag

	def index(conn, _params) do
		# tags = Repo.all(from t in Tag, preload: [post: :user])
		tags = Repo.all(Tag)
		IO.inspect tags
		render(conn, "index.html", tags: tags)
	end
end