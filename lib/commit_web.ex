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

	def filterToNames(list) do
		Enum.map list, fn x -> Dict.get x, "name" end
	end

	def filterToMostRecentCommits(list) do
		Enum.map list, fn repo -> {(Dict.get repo, "message"), (Dict.get repo, "message")} 
	end

	get "username/:name" do
		repos = filterToNames (Tentacat.Repositories.list_users(name))
		repo_commits = Enum.map repos, fn repo -> Tentacat.Commits.list(name, repo) end
		commits = filterToMostRecentCommits repo_commits
		#might be able to pattern match stuff like this:
		#http://elixir-lang.org/getting-started/keywords-and-maps.html#maps
		conn
		|> send_resp(200, "Hello there #{latest_commits}")
		|> halt
	end
	
	get _ do
		conn
		|> send_resp(400, "not okay")
		|> halt
	end
end  
