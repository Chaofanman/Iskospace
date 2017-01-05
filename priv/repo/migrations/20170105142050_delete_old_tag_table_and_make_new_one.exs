defmodule Iskospace.Repo.Migrations.DeleteOldTagTableAndMakeNewOne do
  use Ecto.Migration

  def change do
    drop_if_exists table(:tags)

    create table(:tags) do
      add :tag, :string
      add :post_id, references(:posts)

      timestamps()
    end
  end
end
