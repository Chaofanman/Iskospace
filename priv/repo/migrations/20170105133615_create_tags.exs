defmodule Iskospace.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:taggings) do
      add :post_id, :integer
      add :tag_id, :integer

      timestamps()
    end

    create table(:tags) do
      add :title, :string

      timestamps()
    end
  end
end
