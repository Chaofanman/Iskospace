defmodule Iskospace.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :author, :string
      add :body, :text

      add :user_id, references(:users)
    end
  end
end
