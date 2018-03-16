defmodule UserAuthenticationWeb.PageController do
  use UserAuthenticationWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
