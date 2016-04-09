defmodule Commit.Web do

	def portNumber do
		p = System.get_env("PORT")
		if p do
			p 
		else
			4000
		end
	end

	def init(options) do
	  options
	end

	def start_link do
	  {:ok, _} = Plug.Adapters.Cowboy.http Commit.Controller, [], port: portNumber
	end

end  
