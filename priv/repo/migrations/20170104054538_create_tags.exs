defmodule Iskospace.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :tag, :string
      add :post_id, references(:posts)
    end
  end
end
