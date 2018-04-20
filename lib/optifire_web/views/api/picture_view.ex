defmodule OptifireWeb.PictureAPIView do
  use OptifireWeb, :view
  alias OptifireWeb.PictureView


  def render("index.json", %{pictures: pictures}) do
    %{data: render_many(pictures, __MODULE__, "picture.json")}
  end

  def render("show.json", %{picture: picture}) do
    %{data: render_one(picture, __MODULE__, "picture.json")}
  end

  def render("picture.json", %{picture_api: picture}) do
    %{
      id: picture.id,
      original: PictureView.original_picture(picture),
      small: PictureView.small_picture(picture, :thumb),
      color: picture.color
    }
  end
end
