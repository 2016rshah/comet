defmodule Commit.Controller do
	use Plug.Router
	use Timex
	require Logger

	plug PlugCors
	plug Plug.Logger
	plug :match
	plug :dispatch

	def getLatestCommit(username) do
		client = Tentacat.Client.new(%{access_token: Commit.Keys.github_key})
		[repo | _] = Tentacat.Repositories.list_users(username, client, [sort: "pushed"])
		repoName = Map.get repo, "name"
		[commit | _] = Tentacat.Commits.list(username, repoName, client)
		commit
	end

	# Landing page
	get "/" do
		conn |> send_resp(200, "Welcome to Comet, where you can GET your latest github commit") |> halt
	end

	# Is there a better way to avoid the error?
	get "/favicon.ico" do
		conn |> send_resp(404, "Not found") |> halt
	end

	# Send JSON response
	get "/json/:name" do
	  conn
	  |> put_resp_content_type("application/json")
	  |> send_resp(200, Poison.encode!(getLatestCommit(name)))
	  |> halt
	end

	# Send a plain-text response of just the message
	get "/:name" do
		message = Map.get (Map.get getLatestCommit(name), "commit"), "message"
		conn
		|> send_resp(200, message)
		|> halt
	end
	
	# 404 for anything else
	get _ do
		conn
		|> send_resp(400, "not okay")
		|> halt
	end
end