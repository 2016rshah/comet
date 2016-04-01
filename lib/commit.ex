defmodule Commit do
  use Application
	use Plug.Router

	plug :match
	plug :dispatch

	get "/hello" do
		send_resp(conn, 200, "world")
	end

	match _ do
		send_resp(conn, 404, "oops")
	end
	
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Commit.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Commit.Supervisor]
    Supervisor.start_link(children, opts)
  end

	# c "lib/commit.ex"
	# {:ok, _} = Plug.Adapters.Cowboy.http Commit, []
end
