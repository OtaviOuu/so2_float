defmodule So2FloatWeb.ErrorJSONTest do
  use So2FloatWeb.ConnCase, async: true

  test "renders 404" do
    assert So2FloatWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert So2FloatWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
