defmodule Phxdev.Repo.Migrations.CreateTaskmgrs do
  use Ecto.Migration

  def change do
    create table(:taskmgrs, primary_key: false) do
      add :id, :string, primary_key: true
      add :username, :string
      add :title, :text
      add :description, :text

      timestamps(type: :utc_datetime)
    end
  end
end
