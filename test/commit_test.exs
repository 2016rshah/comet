defmodule CommitTest do
  use ExUnit.Case, async: true
	use Plug.Test
	
  #doctest Commit

  test "the truth" do
    assert 1 + 1 == 2
  end

	@opts Commit.Api.start("","")
	
	test "shouldn't find anything" do
		# Create a test connection
		conn = conn(:get, "/hello")

		# Invoke the plug
		conn = Commit.Web.call(conn, @opts)

		# Assert the response and status
		assert conn.state == :sent
		assert conn.status == 400
		assert conn.resp_body == "not okay"
	end

	test "basic route" do
		conn = conn(:get, "/helloworld")

		conn = Commit.Web.call(conn, @opts)

		assert conn.state == :sent
		assert conn.status == 200
		assert conn.resp_body == "hello world"
	end
end
