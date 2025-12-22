defmodule So2Float.Repo.Migrations.CreateMarketTables do
  use Ecto.Migration

  def change do
    create table(:weapons, primary_key: false) do
      add :name, :string, primary_key: true

      timestamps()
    end

    create unique_index(:weapons, [:name])

    create table(:skins, primary_key: false) do
      add :name, :string, null: false
      add :complete_name, :string, null: false, primary_key: true

      add :weapon_name,
          references(:weapons, type: :string, on_delete: :delete_all, column: :name),
          null: false

      timestamps()
    end

    create unique_index(:skins, [:complete_name, :weapon_name])
  end
end
