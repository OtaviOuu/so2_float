defmodule So2FloatWeb.SkinsLive.Index do
  use So2FloatWeb, :live_view

  alias So2Float.Market

  def mount(_params, _session, socket) do
    skins = Market.list_skins()

    socket =
      socket
      |> assign(:page_title, "Skins Index")
      |> assign(:skins, skins)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <div class="bg-white dark:bg-gray-800 shadow sm:rounded-lg p-6">
        <h1 class="text-2xl font-bold mb-4">Skins Index</h1>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
          <.skin_card
            :for={skin <- @skins}
            skin={skin}
          />
        </div>
      </div>
    </Layouts.app>
    """
  end

  defp skin_card(assigns) do
    ~H"""
    <div
      phx-click={JS.navigate(~p"/skins/#{@skin.complete_name}")}
      class="border border-gray-200 dark:border-gray-700 rounded-lg p-4 mb-4 hover:shadow-sm transition-shadow"
    >
      {@skin.complete_name}
    </div>
    """
  end
end
