defmodule OptifireWeb.PictureController do
  use OptifireWeb, :controller

  alias Optifire.Optimizations
  alias Optifire.Optimizations.Picture

  def index(conn, _params) do
    pictures = Optimizations.list_pictures()
    render(conn, "index.html", pictures: pictures)
  end

  def new(conn, _params) do
    changeset = Optimizations.change_picture(%Picture{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"picture" => picture_params}) do
    case Optimizations.create_picture(picture_params) do
      {:ok, picture} ->
        conn
        |> put_flash(:info, "Picture created successfully.")
        |> redirect(to: picture_path(conn, :show, picture))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    picture = Optimizations.get_picture!(id)
    render(conn, "show.html", picture: picture)
  end

  def edit(conn, %{"id" => id}) do
    picture = Optimizations.get_picture!(id)
    changeset = Optimizations.change_picture(picture)
    render(conn, "edit.html", picture: picture, changeset: changeset)
  end

  def update(conn, %{"id" => id, "picture" => picture_params}) do
    picture = Optimizations.get_picture!(id)

    case Optimizations.update_picture(picture, picture_params) do
      {:ok, picture} ->
        conn
        |> put_flash(:info, "Picture updated successfully.")
        |> redirect(to: picture_path(conn, :show, picture))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", picture: picture, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    picture = Optimizations.get_picture!(id)
    {:ok, _picture} = Optimizations.delete_picture(picture)

    conn
    |> put_flash(:info, "Picture deleted successfully.")
    |> redirect(to: picture_path(conn, :index))
  end
end
