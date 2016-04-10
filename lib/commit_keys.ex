defmodule Commit.Keys do
	def github_key do
		System.get_env("GITHUB_ACCESS_KEY")
		#Don't forget to do this in bash first
		#$ export GITHUB_ACCESS_KEY="my value" 
	end
end
