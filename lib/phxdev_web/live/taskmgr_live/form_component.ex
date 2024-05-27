defmodule PhxdevWeb.TaskmgrLive.FormComponent do
  use PhxdevWeb, :live_component

  alias Phxdev.Taskmgrs

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage taskmgr records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="taskmgr-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:username]} type="text" label="Username" />
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Taskmgr</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{taskmgr: taskmgr} = assigns, socket) do
    changeset = Taskmgrs.change_taskmgr(taskmgr)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"taskmgr" => taskmgr_params}, socket) do
    changeset =
      socket.assigns.taskmgr
      |> Taskmgrs.change_taskmgr(taskmgr_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"taskmgr" => taskmgr_params}, socket) do
    save_taskmgr(socket, socket.assigns.action, taskmgr_params)
  end

  defp save_taskmgr(socket, :edit, taskmgr_params) do
    case Taskmgrs.update_taskmgr(socket.assigns.taskmgr, taskmgr_params) do
      {:ok, taskmgr} ->
        notify_parent({:saved, taskmgr})

        {:noreply,
         socket
         |> put_flash(:info, "Taskmgr updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_taskmgr(socket, :new, taskmgr_params) do
    case Taskmgrs.create_taskmgr(taskmgr_params) do
      {:ok, taskmgr} ->
        notify_parent({:saved, taskmgr})

        {:noreply,
         socket
         |> put_flash(:info, "Taskmgr created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
