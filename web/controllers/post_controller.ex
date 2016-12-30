defmodule Iskospace.PostController do
	use Iskospace.Web, :controller

	alias Iskospace.Post

	# plug Iskospace.Plugs.AuthorizeUser

	def index(conn, _params) do
		posts = Repo.all(assoc(conn.assigns[:user], :posts))
		render(conn, "index.html", posts: posts)
	end

	def new(conn, _params) do
		changeset = conn.assigns[:user]
		|> build_assoc(:posts)
		|> Post.changeset()
		render(conn, "new.html", changeset: changeset)
	end

	def create(conn, %{"post" => post_params}) do
		IO.puts "In post controller create"
		IO.inspect post_params
		conn 
		|> redirect(to: page_path(conn, :index))
	end	
end