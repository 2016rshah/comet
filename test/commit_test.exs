defmodule CommitTest do
  use ExUnit.Case, async: true
	use Plug.Test
	
  doctest Commit

  test "the truth" do
    assert 1 + 1 == 2
  end

	@opts Commit.init([])
	
	test "returns hello world" do
		# Create a test connection
		conn = conn(:get, "/hello")

		# Invoke the plug
		conn = Commit.call(conn, @opts)

		# Assert the response and status
		assert conn.state == :sent
		assert conn.status == 200
		assert conn.resp_body == "world"
	end
end
