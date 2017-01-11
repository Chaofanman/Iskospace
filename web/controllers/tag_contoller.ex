defmodule Iskospace.TagController do
	use Iskospace.Web, :controller

	import Ecto.Query

	alias Iskospace.Tag

	def index(conn, _params) do
		changeset = Tag.changeset(%Tag{})
		tags = Repo.all(from t in Tag, select: t.tag)
		|> Enum.uniq
		render(conn, "index.html", tags: tags, changeset: changeset)
	end

	def show(conn, %{"tag" => tag}) do
	  IO.inspect tag
		posts_with_tag = Repo.all(from t in Tag, 
																where: t.tag == ^tag, 
																select: struct(t, [:id, :tag, :post_id]),
																preload: [post: :user])
		render(conn, "show.html", tag: tag, posts_with_tag: posts_with_tag)
	end
end