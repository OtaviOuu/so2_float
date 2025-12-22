defmodule So2FloatWeb.Charts do
  use Phoenix.Component

  attr :id, :string, required: true
  attr :title, :string, required: true
  attr :categories, :list, required: true
  attr :series, :list, required: true

  def line_chart_basic(assigns) do
    ~H"""
    <div
      phx-hook="LineChartBasic"
      id={@id}
      data-title={@title}
      data-categories={Jason.encode!(@categories)}
      data-series={Jason.encode!(@series)}
    >
    </div>
    """
  end
end
