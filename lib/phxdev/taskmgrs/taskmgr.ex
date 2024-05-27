defmodule Phxdev.Taskmgrs.Taskmgr do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :string, autogenerate: false}
  @foreign_key_type :string
  schema "taskmgrs" do
    field :description, :string
    field :title, :string
    field :username, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  # updating an existing taskmgr
  def changeset(taskmgr, attrs) do
    taskmgr
    |> cast(attrs, [:username, :title, :description])
    |> validate_required([:username, :title])
  end

  @spec create_changeset(
          {map(), map()}
          | %{
              :__struct__ => atom() | %{:__changeset__ => map(), optional(any()) => any()},
              optional(atom()) => any()
            },
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def create_changeset(taskmgr, attrs) do
    taskmgr
    |> cast(attrs, [:username, :title, :description])
    |> validate_required([:username, :title])
    |> put_change(:id, Phxdev.Utils.random_string(5))
  end
end
