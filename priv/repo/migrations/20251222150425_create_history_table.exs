defmodule So2Float.Repo.Migrations.CreateHistoryTable do
  use Ecto.Migration

  def change do
    create table(:history, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :skin_complete_name,
          references(:skins, type: :string, column: :complete_name, on_delete: :delete_all),
          null: false

      add :price, :integer, null: false
      add :units, :integer, null: false

      timestamps()
    end

    create index(:history, [:skin_complete_name])
  end
end
