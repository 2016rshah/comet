defmodule Commit.Controller do
	use Plug.Router
	use Timex
	require Logger

	plug PlugCors
	plug Plug.Logger
	plug :match
	plug :dispatch

	def findUsersMostRecentCommit([], _, _) do
		nil
	end

	def findUsersMostRecentCommit([repo | repos], username, client) do
		repoName = Map.get repo, "name"
		commits = Tentacat.Commits.list(username, repoName, client)
		commit = Enum.find(commits, nil, fn c -> c["author"]["login"] == username end)
		if is_nil(commit) do
			findUsersMostRecentCommit(repos, username, client)
		else
			commit
		end
	end

	def getLatestCommit(username) do
		client = Tentacat.Client.new(%{access_token: Commit.Keys.github_key})
		repos = Tentacat.Repositories.list_users(username, client, [sort: "pushed"])
		commit = findUsersMostRecentCommit(repos, username, client)
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
		commit = getLatestCommit(name)
		if is_nil commit do
			conn |> send_resp(404, "Commit doesn't exist") |> halt
		else 
		  conn
		  |> put_resp_content_type("application/json")
		  |> send_resp(200, Poison.encode!(commit))
		  |> halt
		end
	end

	# Send a plain-text response of just the message
	get "/:name" do
		commit = getLatestCommit(name)
		if is_nil commit do
			conn |> send_resp(404, "Commit doesn't exist") |> halt
		else
			message = Map.get (Map.get commit, "commit"), "message"
			conn
			|> send_resp(200, message)
			|> halt
		end
	end
	
	# 404 for anything else
	get _ do
		conn
		|> send_resp(400, "not okay")
		|> halt
	end
end