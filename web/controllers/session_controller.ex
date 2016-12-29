defmodule Iskospace.SessionController do
	use Iskospace.Web, :controller
	import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

	alias Iskospace.User

	plug :scrub_params, "user" when action in [:create]

	def new(conn, _params) do
		changeset = User.changeset(%User{})
		render(conn, "new.html", changeset: changeset)
	end

	def create(conn, %{"user" => %{"email" => email, "password" => password}}) when not is_nil(email) do
		user = Repo.get_by(User, email: email)
		login(user, password, conn)
	end

	def create(conn, _params) do
		failed_login(conn)
	end

	defp failed_login(conn) do
		dummy_checkpw()
		conn 
		|> put_session(:current_user, nil)
		|> put_flash(:error, "Invalid email/password")
		|> redirect(to: session_path(conn, :new))
		|> halt()
	end

	defp login(user, password, conn) do
		if checkpw(password, user.password_digest) do
			conn
			|> put_session(:current_user, %{id: user.id, email: user.email})
			|> put_flash(:info, "Sign in successful")
			|> redirect(to: page_path(conn, :index))
		else 
			conn
			|> failed_login
		end
	end
end