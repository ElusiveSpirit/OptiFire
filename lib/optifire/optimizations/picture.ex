defmodule Optifire.Optimizations.Picture do
  use Arc.Ecto.Schema
  use Ecto.Schema
  import Ecto.Changeset


  schema "pictures" do
    field :color, :string
    field :name, :string
    field :original, Optifire.PictureUploader.Type

    timestamps()
  end

  @doc false
  def create_changeset(picture, attrs) do
    picture
    |> cast(attrs, [:original])
    |> cast_attachments(attrs, [:original])
    |> cast_name(attrs)
    |> cast_color(attrs)
    |> validate_required([:original])
  end

  @doc false
  def changeset(picture, attrs) do
    picture
    |> cast(attrs, [:name, :color, :original])
    |> cast_attachments(attrs, [:original])
    |> cast_name(attrs)
    |> cast_color(attrs)
    |> validate_required([:name, :color, :original])
  end

  defp cast_color(%{changes: changes} = changeset,  %{"original" => %{path: file}}) do
    {:ok, color} = Optifire.PictureUploader.get_average_color(file)
    IO.inspect color

    %{changeset | changes: Map.put(changes, :color, color)}
  end
  defp cast_color(changeset, _), do: changeset

  defp cast_name(%{changes: changes} = changeset, %{"original" => %{filename: filename}}) do
    %{changeset | changes: Map.put(changes, :name, filename)}
  end
  defp cast_name(changeset, _) do
    changeset
  end
end
