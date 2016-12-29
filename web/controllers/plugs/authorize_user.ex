defmodule Iskospace.Plugs.AuthorizeUser do
	import Plug.Conn
	import Phoenix.Controller

	alias Iskospace.Repo
	alias Iskospace.User
	alias Iskospace.Router.Helpers


	def init(_params) do
		
	end

	def call(conn, _) do
		user_id = get_session(conn, :user_id)
		id = conn.params["id"] |> String.to_integer

		if user_id == id do
			conn
		else 
			conn 
			|> put_flash(:error, "You are not authorized to edit this")	
			|> redirect(to: Helpers.page_path(conn, :index))
		end
		
	end
	
end