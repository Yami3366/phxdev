defmodule Phxdev.TaskmgrsTest do
  use Phxdev.DataCase

  alias Phxdev.Taskmgrs

  describe "taskmgrs" do
    alias Phxdev.Taskmgrs.Taskmgr

    import Phxdev.TaskmgrsFixtures

    @invalid_attrs %{description: nil, title: nil, username: nil}

    test "list_taskmgrs/0 returns all taskmgrs" do
      taskmgr = taskmgr_fixture()
      assert Taskmgrs.list_taskmgrs() == [taskmgr]
    end

    test "get_taskmgr!/1 returns the taskmgr with given id" do
      taskmgr = taskmgr_fixture()
      assert Taskmgrs.get_taskmgr!(taskmgr.id) == taskmgr
    end

    test "create_taskmgr/1 with valid data creates a taskmgr" do
      valid_attrs = %{description: "some description", title: "some title", username: "some username"}

      assert {:ok, %Taskmgr{} = taskmgr} = Taskmgrs.create_taskmgr(valid_attrs)
      assert taskmgr.description == "some description"
      assert taskmgr.title == "some title"
      assert taskmgr.username == "some username"
    end

    test "create_taskmgr/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taskmgrs.create_taskmgr(@invalid_attrs)
    end

    test "update_taskmgr/2 with valid data updates the taskmgr" do
      taskmgr = taskmgr_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", username: "some updated username"}

      assert {:ok, %Taskmgr{} = taskmgr} = Taskmgrs.update_taskmgr(taskmgr, update_attrs)
      assert taskmgr.description == "some updated description"
      assert taskmgr.title == "some updated title"
      assert taskmgr.username == "some updated username"
    end

    test "update_taskmgr/2 with invalid data returns error changeset" do
      taskmgr = taskmgr_fixture()
      assert {:error, %Ecto.Changeset{}} = Taskmgrs.update_taskmgr(taskmgr, @invalid_attrs)
      assert taskmgr == Taskmgrs.get_taskmgr!(taskmgr.id)
    end

    test "delete_taskmgr/1 deletes the taskmgr" do
      taskmgr = taskmgr_fixture()
      assert {:ok, %Taskmgr{}} = Taskmgrs.delete_taskmgr(taskmgr)
      assert_raise Ecto.NoResultsError, fn -> Taskmgrs.get_taskmgr!(taskmgr.id) end
    end

    test "change_taskmgr/1 returns a taskmgr changeset" do
      taskmgr = taskmgr_fixture()
      assert %Ecto.Changeset{} = Taskmgrs.change_taskmgr(taskmgr)
    end
  end
end
