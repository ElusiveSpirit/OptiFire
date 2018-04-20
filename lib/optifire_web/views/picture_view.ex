defmodule OptifireWeb.PictureView do
  use OptifireWeb, :view
  alias OptifireWeb.PictureView

  def rgb_color(%{color: ""}),    do: ""
  def rgb_color(%{color: color}), do: "rgb(#{color})"

  def small_picture(picture, opt) do
    Optifire.PictureUploader.url({picture.original, picture}, opt)
  end

  def original_picture(picture) do
    Optifire.PictureUploader.url({picture.original, picture})
  end
end
