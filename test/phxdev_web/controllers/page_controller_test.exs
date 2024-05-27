defmodule PhxdevWeb.PageControllerTest do
  use PhxdevWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Welcome"
  end
end
