defmodule Optifire.Repo.Migrations.CreatePictures do
  use Ecto.Migration

  def change do
    create table(:pictures) do
      add :name, :string
      add :color, :string
      add :original, :string

      timestamps()
    end

  end
end
