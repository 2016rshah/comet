defmodule Commit.Controller do
	use Plug.Router
	use Timex
	require Logger

	plug Plug.Logger
	plug :match
	plug :dispatch

	def getLatestCommit(username) do
		client = Tentacat.Client.new(%{access_token: Commit.Keys.github_key})
		[repo | repos] = Tentacat.Repositories.list_users(username, client, [sort: "pushed"])
		repoName = Map.get repo, "name"
		[commit | commits] = Tentacat.Commits.list(username, repoName, client)
		commitMessage = (Map.get (Map.get commit, "commit"), "message")
		{commitMessage, repoName}
	end

	get "/" do
		conn |> send_resp(200, "Welcome to Comet, where you can GET your latest github commit") |> halt
	end

	get "/favicon.ico" do
		conn |> send_resp(404, "Not found") |> halt
	end

	get "/:name" do
		{message, repo} = getLatestCommit(name)
		IO.puts(repo)
		conn
		|> send_resp(200, message)
		|> halt
	end
	
	get _ do
		conn
		|> send_resp(400, "not okay")
		|> halt
	end
end