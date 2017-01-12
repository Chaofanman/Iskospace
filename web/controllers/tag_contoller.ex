defmodule Iskospace.TagController do
	use Iskospace.Web, :controller

	import Ecto.Query

	alias Iskospace.Tag

	def index(conn, params) when params == %{} do
		changeset = Tag.changeset(%Tag{})
		tags = Repo.all(from t in Tag, select: t.tag)
		|> Enum.uniq
		render(conn, "index.html", tags: tags, changeset: changeset)
	end

	def index(conn, %{"search" => %{"tag" => tag}})do
		tag = tag <> "%"
		changeset = Tag.changeset(%Tag{})
		tags = Repo.all(from t in Tag, select: t.tag, where: like(t.tag, ^tag))
		|> Enum.uniq
		render(conn, "index.html", tags: tags, changeset: changeset)
	end

	def show(conn, %{"tag" => tag}) do
		posts_with_tag = Repo.all(from t in Tag, 
															where: t.tag == ^tag, 
															select: struct(t, [:id, :tag, :post_id]),
															preload: [post: :user])
		render(conn, "show.html", tag: tag, posts_with_tag: posts_with_tag)
	end
end