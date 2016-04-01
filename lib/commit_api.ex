defmodule Commit.Api do
	use Application

	def start(_type, _args) do
	  import Supervisor.Spec, warn: false

		children = [
			worker(Commit.Web, [])
		]

		opts = [strategy: :one_for_one, name: Commit.Supervisor]
		Supervisor.start_link(children, opts)
	end
end  
