defmodule Optifire.PictureUploader do
  use Arc.Definition
  use Arc.Ecto.Definition

  @pixel_transform "-resize 1x1\! -format %[fx:int(255*r+.5)],%[fx:int(255*g+.5)],%[fx:int(255*b+.5)] info:-"

  @versions [:original, :thumb]

  def __storage, do: Arc.Storage.Local

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  def transform(:original, _), do: :noaction

  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :jpg}
  end

  def get_average_color(file) do
    Optifire.Transformations.apply(:convert, file, @pixel_transform)
  end


  # Override the persisted filenames:
  def filename(version, {%{file_name: file_name}, _}) do
    [Path.basename(file_name, Path.extname(file_name)), Atom.to_string(version)]
    |> Enum.join("_")
  end

  # Override the storage directory:
  # def storage_dir(version, {file, scope}) do
  #   "uploads/user/avatars/#{scope.id}"
  # end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/optimizations/default_#{version}.png"
  # end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  # def s3_object_headers(version, {file, scope}) do
  #   [content_type: Plug.MIME.path(file.file_name)]
  # end
end
