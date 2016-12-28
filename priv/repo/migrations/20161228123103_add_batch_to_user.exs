defmodule Iskospace.Repo.Migrations.AddBatchToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :batch, :integer
    end
  end
end
