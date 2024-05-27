defmodule PhxdevWeb.TaskmgrLive.Show do
  use PhxdevWeb, :live_view

  alias Phxdev.Taskmgrs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:taskmgr, Taskmgrs.get_taskmgr!(id))}
  end

  defp page_title(:show), do: "Show Taskmgr"
  defp page_title(:edit), do: "Edit Taskmgr"
end
