defmodule OptifireWeb.PictureAPIController do
  use OptifireWeb, :controller

  alias Optifire.Optimizations
  alias Optifire.Optimizations.Picture
  alias OptifireWeb.PictureAPIView

  action_fallback OptifireWeb.FallbackController

  def index(conn, _params) do
    pictures = Optimizations.list_pictures()
    render(conn, PictureAPIView, "index.json", pictures: pictures)
  end

  def create(conn, %{"picture" => picture_params}) do
    with {:ok, %Picture{} = picture} <- Optimizations.create_picture(picture_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", picture_path(conn, :show, picture))
      |> render(PictureAPIView, "show.json", picture: picture)
    end
  end

  def show(conn, %{"id" => id}) do
    picture = Optimizations.get_picture!(id)
    render(conn, PictureAPIView, "show.json", picture: picture)
  end
end
