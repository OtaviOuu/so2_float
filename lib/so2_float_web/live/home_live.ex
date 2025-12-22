defmodule So2FloatWeb.HomeLive do
  use So2FloatWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>oi</Layouts.app>
    """
  end
end
