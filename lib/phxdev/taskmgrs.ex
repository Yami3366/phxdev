defmodule Phxdev.Taskmgrs do
  @moduledoc """
  The Taskmgrs context.
  """

  import Ecto.Query, warn: false
  alias Phxdev.Repo

  alias Phxdev.Taskmgrs.Taskmgr

  @doc """
  Returns the list of taskmgrs.

  ## Examples

      iex> list_taskmgrs()
      [%Taskmgr{}, ...]

  """
  def list_taskmgrs do
    Repo.all(Taskmgr)
  end

  @doc """
  Gets a single taskmgr.

  Raises `Ecto.NoResultsError` if the Taskmgr does not exist.

  ## Examples

      iex> get_taskmgr!(123)
      %Taskmgr{}

      iex> get_taskmgr!(456)
      ** (Ecto.NoResultsError)

  """
  def get_taskmgr!(id), do: Repo.get!(Taskmgr, id)

  @doc """
  Creates a taskmgr.

  ## Examples

      iex> create_taskmgr(%{field: value})
      {:ok, %Taskmgr{}}

      iex> create_taskmgr(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_taskmgr(attrs \\ %{}) do
    %Taskmgr{}
    |> Taskmgr.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a taskmgr.

  ## Examples

      iex> update_taskmgr(taskmgr, %{field: new_value})
      {:ok, %Taskmgr{}}

      iex> update_taskmgr(taskmgr, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_taskmgr(%Taskmgr{} = taskmgr, attrs) do
    taskmgr
    |> Taskmgr.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a taskmgr.

  ## Examples

      iex> delete_taskmgr(taskmgr)
      {:ok, %Taskmgr{}}

      iex> delete_taskmgr(taskmgr)
      {:error, %Ecto.Changeset{}}

  """
  def delete_taskmgr(%Taskmgr{} = taskmgr) do
    Repo.delete(taskmgr)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking taskmgr changes.

  ## Examples

      iex> change_taskmgr(taskmgr)
      %Ecto.Changeset{data: %Taskmgr{}}

  """
  def change_taskmgr(%Taskmgr{} = taskmgr, attrs \\ %{}) do
    Taskmgr.changeset(taskmgr, attrs)
  end
end
