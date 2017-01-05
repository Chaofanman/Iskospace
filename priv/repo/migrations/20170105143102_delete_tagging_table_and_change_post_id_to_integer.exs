defmodule Iskospace.Repo.Migrations.DeleteTaggingTableAndChangePostIdToInteger do
  use Ecto.Migration

  def change do
    drop_if_exists table(:taggings)

    alter table(:tags) do
      modify :post_id, :integer
    end
  end
end
