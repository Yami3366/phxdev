defmodule PhxdevWeb.TaskmgrLive.Index do
  use PhxdevWeb, :live_view

  alias Phxdev.Taskmgrs
  alias Phxdev.Taskmgrs.Taskmgr

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :taskmgrs, Taskmgrs.list_taskmgrs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Taskmgr")
    |> assign(:taskmgr, Taskmgrs.get_taskmgr!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Taskmgr")
    |> assign(:taskmgr, %Taskmgr{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Taskmgrs")
    |> assign(:taskmgr, nil)
  end

  @impl true
  def handle_info({PhxdevWeb.TaskmgrLive.FormComponent, {:saved, taskmgr}}, socket) do
    {:noreply, stream_insert(socket, :taskmgrs, taskmgr)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    taskmgr = Taskmgrs.get_taskmgr!(id)
    {:ok, _} = Taskmgrs.delete_taskmgr(taskmgr)

    {:noreply, stream_delete(socket, :taskmgrs, taskmgr)}
  end
end
