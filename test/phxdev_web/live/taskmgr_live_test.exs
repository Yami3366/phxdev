defmodule PhxdevWeb.TaskmgrLiveTest do
  use PhxdevWeb.ConnCase

  import Phoenix.LiveViewTest
  import Phxdev.TaskmgrsFixtures

  @create_attrs %{description: "some description", title: "some title", username: "some username"}
  @update_attrs %{description: "some updated description", title: "some updated title", username: "some updated username"}
  @invalid_attrs %{description: nil, title: nil, username: nil}

  defp create_taskmgr(_) do
    taskmgr = taskmgr_fixture()
    %{taskmgr: taskmgr}
  end

  describe "Index" do
    setup [:create_taskmgr]

    test "lists all taskmgrs", %{conn: conn, taskmgr: taskmgr} do
      {:ok, _index_live, html} = live(conn, ~p"/taskmgrs")

      assert html =~ "Listing Taskmgrs"
      assert html =~ taskmgr.description
    end

    test "saves new taskmgr", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/taskmgrs")

      assert index_live |> element("a", "New Taskmgr") |> render_click() =~
               "New Taskmgr"

      assert_patch(index_live, ~p"/taskmgrs/new")

      assert index_live
             |> form("#taskmgr-form", taskmgr: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#taskmgr-form", taskmgr: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/taskmgrs")

      html = render(index_live)
      assert html =~ "Taskmgr created successfully"
      assert html =~ "some description"
    end

    test "updates taskmgr in listing", %{conn: conn, taskmgr: taskmgr} do
      {:ok, index_live, _html} = live(conn, ~p"/taskmgrs")

      assert index_live |> element("#taskmgrs-#{taskmgr.id} a", "Edit") |> render_click() =~
               "Edit Taskmgr"

      assert_patch(index_live, ~p"/taskmgrs/#{taskmgr}/edit")

      assert index_live
             |> form("#taskmgr-form", taskmgr: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#taskmgr-form", taskmgr: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/taskmgrs")

      html = render(index_live)
      assert html =~ "Taskmgr updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes taskmgr in listing", %{conn: conn, taskmgr: taskmgr} do
      {:ok, index_live, _html} = live(conn, ~p"/taskmgrs")

      assert index_live |> element("#taskmgrs-#{taskmgr.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#taskmgrs-#{taskmgr.id}")
    end
  end

  describe "Show" do
    setup [:create_taskmgr]

    test "displays taskmgr", %{conn: conn, taskmgr: taskmgr} do
      {:ok, _show_live, html} = live(conn, ~p"/taskmgrs/#{taskmgr}")

      assert html =~ "Show Taskmgr"
      assert html =~ taskmgr.description
    end

    test "updates taskmgr within modal", %{conn: conn, taskmgr: taskmgr} do
      {:ok, show_live, _html} = live(conn, ~p"/taskmgrs/#{taskmgr}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Taskmgr"

      assert_patch(show_live, ~p"/taskmgrs/#{taskmgr}/show/edit")

      assert show_live
             |> form("#taskmgr-form", taskmgr: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#taskmgr-form", taskmgr: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/taskmgrs/#{taskmgr}")

      html = render(show_live)
      assert html =~ "Taskmgr updated successfully"
      assert html =~ "some updated description"
    end
  end
end
