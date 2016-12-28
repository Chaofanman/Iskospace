defmodule Iskospace.UserController do
	use Iskospace.Web, :controller

	alias Iskospace.User

	def index(conn, _params) do
		users = Repo.all(User)
		render(conn, "index.html", users: users)
	end
end