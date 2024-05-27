defmodule Phxdev.TaskmgrsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Phxdev.Taskmgrs` context.
  """

  @doc """
  Generate a taskmgr.
  """
  def taskmgr_fixture(attrs \\ %{}) do
    {:ok, taskmgr} =
      attrs
      |> Enum.into(%{
        id: Phxdev.Utils.random_string(5),
        description: "some description",
        title: "some title",
        username: "some username"
      })
      |> Phxdev.Taskmgrs.create_taskmgr()

    taskmgr
  end
end
