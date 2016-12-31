defmodule Iskospace.PostController do
	use Iskospace.Web, :controller

	alias Iskospace.Post
	alias Iskospace.User

	plug :scrub_params, "post" when action in [:create, :update]

	def index(conn, %{"user_id" => user_id}) do
		posts_owner = Repo.get!(User, user_id |> String.to_integer)
		posts = Repo.all(assoc(posts_owner, :posts))
		render(conn, "index.html", posts: posts, posts_owner: posts_owner)
	end

	def show(conn, %{"id" => post_id}) do
		post = Repo.get!(Post, post_id)
		|> Repo.preload(:user)

		comment_changeset = post 
			|> build_assoc(:comments)
			|> Iskospace.Comment.changeset()

		render(conn, "show.html", post: post, comment_changeset: comment_changeset)
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

	def edit(conn, %{"id" => post_id}) do
		post = Repo.get!(assoc(conn.assigns[:user], :posts), post_id)	
		changeset = Post.changeset(post)
		render(conn, "edit.html", changeset: changeset, post: post)
	end

	def update(conn, %{"id" => post_id, "post" => post_params}) do
		old_post = Repo.get!(assoc(conn.assigns[:user], :posts), post_id)		
		changeset = Post.changeset(old_post, post_params)

		case Repo.update(changeset) do
			{:ok, new_post} ->
				conn 
				|> put_flash(:info, "Successfully updated post")
				|> redirect(to: user_post_path(conn, :show, conn.assigns[:user], new_post))
			{:error, changeset} -> 
				render(conn, "edit.html", changeset: changeset, post: old_post)
		end
	end
end