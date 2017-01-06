defmodule Iskospace.TagController do
	use Iskospace.Web, :controller

	import Ecto.Query

	alias Iskospace.Tag

	def index(conn, _params) do
		# tags = Repo.all(from t in Tag, preload: [post: :user])
		tags = Repo.all(Tag)
		render(conn, "index.html", tags: tags)
	end

	def show(conn, %{"tag" => tag}) do
		posts_with_tag = Repo.all(from t in "tags", 
																where: t.tag == ^tag, 
																select: [:id, :tag, :post_id],
																preload: [:user])
		IO.inspect posts_with_tag
		render(conn, "show.html", tag: tag)
	end
end