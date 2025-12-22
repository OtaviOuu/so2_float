defmodule So2FloatWeb.AdminLive.ActionsDashboard do
  use So2FloatWeb, :live_view

  alias So2Float.Market

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <form phx-submit="execute_action">
        <.input type="text" name="image_url" placeholder="Url da imagem do mkt" value="" />
        <.button type="submit">Execute Action</.button>
      </form>
    </Layouts.app>
    """
  end

  def handle_event("execute_action", %{"image_url" => image_url}, socket) do
    case Market.extract_skins_from_image(image_url, socket.assigns.current_scope) do
      {:ok, results} ->
        {:noreply, socket}

      {:error, reason} ->
        socket =
          socket
          |> put_flash(:error, "Failed to extract skins: #{inspect(reason)}")

        {:noreply, socket}
    end
  end
end
