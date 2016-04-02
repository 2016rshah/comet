defmodule Commit.Web do

	def init(options) do
	  options
	end

	def start_link do
	  {:ok, _} = Plug.Adapters.Cowboy.http Commit.Controller, []
	end

end  
