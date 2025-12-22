defmodule So2FloatWeb.PageController do
  use So2FloatWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
