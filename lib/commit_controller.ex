defmodule Commit.Controller do
	use Plug.Router
	use Timex
	require Logger

	plug Plug.Logger
	plug :match
	plug :dispatch

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

	def getDateStringFromCommit(c) do
		# IO.puts "getDateStringFromCommit: "
		# IO.inspect(c)
		Map.get (Map.get (Map.get c, "commit"), "committer"), "date"
	end

	def sortByDates(commits) do
		# IO.puts("sortByDates: ")
		# IO.inspect(commits)
		(Enum.sort_by commits, &(Timex.parse(getDateStringFromCommit(&1), "{ISO}")))
		|> Enum.reverse
	end

	def getLatestCommit(username) do

		client = Tentacat.Client.new(%{access_token: "fa83a7a81ac96ab0a552c6cf471de8c08199592f"})
		
		repos = Tentacat.Repositories.list_users(username, client)
		repoNames = Enum.map repos, &(Map.get &1, "name")
		# IO.inspect(repoNames)
		repos_commits = Enum.map repoNames, &(Tentacat.Commits.list(username, &1, client))
		#[[{commit}]]
		# IO.inspect(repos_commits)
		c = List.first(Enum.map repos_commits, &sortByDates/1)
		IO.inspect(List.first(c))

		"string"
		#might be able to pattern match stuff like this:
		#http://elixir-lang.org/getting-started/keywords-and-maps.html#maps
	end

	get "username/:name" do
		commit = getLatestCommit(name)
		conn
		|> send_resp(200, "Hello there #{commit}")
		|> halt
	end
	
	get _ do
		conn
		|> send_resp(400, "not okay")
		|> halt
	end
end