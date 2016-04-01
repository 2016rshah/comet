defmodule Commit.Web do
	use Plug.Router
	require Logger

	plug Plug.Logger
	plug :match
	plug :dispatch

	def init(options) do
	  options
	end

	def start_link do
	  {:ok, _} = Plug.Adapters.Cowboy.http Commit.Web, []
	end

	get "/" do
		conn
		|> send_resp(200, "ok")
		|> halt
	end

	get "/helloworld" do
		conn
		|> send_resp(200, "hello world")
		|> halt
	end
	
	get _ do
		conn
		|> send_resp(400, "not okay")
		|> halt
	end
end  
