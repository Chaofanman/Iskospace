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
		changeset = conn.assigns[:user]
		|> build_assoc(:posts)
		|> Post.changeset(post_params)

		case Repo.insert(changeset) do
			{:ok, _post} ->
				conn
				|> put_flash(:info, "Successfully made post")	 
				|> redirect(to: user_post_path(conn, :index, conn.assigns[:user]))
			{:error, changeset}
				render(conn, "new.html", changeset: changeset)
		end
	end	
end