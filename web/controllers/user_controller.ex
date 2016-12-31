defmodule Iskospace.UserController do
	use Iskospace.Web, :controller

	alias Iskospace.User

	plug Iskospace.Plugs.AuthorizeUser when action in [:edit, :update]
	plug :scrub_params, "user" when action in [:create, :update]

	def index(conn, _params) do
		users = Repo.all(User)
		render(conn, "index.html", users: users)
	end

	def new(conn, _params) do
		changeset = User.changeset(%User{})
		render(conn, "new.html", changeset: changeset)
	end

	 def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

	def show(conn, %{"id" => user_id}) do
		user = Repo.get!(User, user_id)
		render(conn, "show.html", user: user)
	end

	def edit(conn, %{"id" => user_id}) do
		user = Repo.get(User, user_id)
		changeset = User.changeset(user)
		render(conn, "edit.html", changeset: changeset, user: user)
	end

	def update(conn, %{"id" => user_id, "user" => user_params}) do
		user = Repo.get!(User, user_id)
		changeset = User.changeset(user, user_params)

		case Repo.update(changeset) do
			{:ok, edited_user} -> 
				conn 
				|> put_flash(:info, "Profile changes done")
				|> redirect(to: user_path(conn, :show, edited_user))
			{:error, changeset} -> 
				render(conn, "edit.html", changeset: changeset, user: user)
		end
	end
end