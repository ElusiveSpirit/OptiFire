defmodule Optifire.OptimizationsTest do
  use Optifire.DataCase

  alias Optifire.Optimizations

  describe "pictures" do
    alias Optifire.Optimizations.Picture

    @image %{name: "net_image.jpg", path: "test/fixtures/net_image.jpg", color: "52,59,79"}
    @plug_image %Plug.Upload{path: @image.path, filename: @image.name}

    @valid_attrs %{"original" => @plug_image}
    @update_attrs %{"original" => @plug_image}
    @invalid_attrs %{"original" => nil}
  
    def picture_fixture(attrs \\ %{}) do
      {:ok, picture} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Optimizations.create_picture()

      picture
    end

    test "list_pictures/0 returns all pictures" do
      picture = picture_fixture()
      assert Optimizations.list_pictures() == [picture]
    end

    test "get_picture!/1 returns the picture with given id" do
      picture = picture_fixture()
      assert Optimizations.get_picture!(picture.id) == picture
    end

    test "create_picture/1 with valid data creates a picture" do
      assert {:ok, %Picture{} = picture} = Optimizations.create_picture(@valid_attrs)
      assert picture.name == @image.name
      assert %{file_name: "net_image.jpg"} = picture.original
      assert picture.color == @image.color
    end

    test "create_picture/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Optimizations.create_picture(@invalid_attrs)
    end

    test "update_picture/2 with valid data updates the picture" do
      picture = picture_fixture()
      assert {:ok, picture} = Optimizations.update_picture(picture, @update_attrs)
      assert %Picture{} = picture
      assert picture.name == @image.name
      assert %{file_name: "net_image.jpg"} = picture.original
      assert picture.color == @image.color
    end

    test "update_picture/2 with invalid data returns error changeset" do
      picture = picture_fixture()
      assert {:error, %Ecto.Changeset{}} = Optimizations.update_picture(picture, @invalid_attrs)
      assert picture == Optimizations.get_picture!(picture.id)
    end

    test "delete_picture/1 deletes the picture" do
      picture = picture_fixture()
      assert {:ok, %Picture{}} = Optimizations.delete_picture(picture)
      assert_raise Ecto.NoResultsError, fn -> Optimizations.get_picture!(picture.id) end
    end

    test "change_picture/1 returns a picture changeset" do
      picture = picture_fixture()
      assert %Ecto.Changeset{} = Optimizations.change_picture(picture)
    end
  end
end
