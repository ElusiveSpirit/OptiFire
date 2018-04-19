defmodule Optifire.OptimizationsTest do
  use Optifire.DataCase

  alias Optifire.Optimizations

  describe "pictures" do
    alias Optifire.Optimizations.Picture

    @valid_attrs %{color: "some color", name: "some name", original: "some original"}
    @update_attrs %{color: "some updated color", name: "some updated name", original: "some updated original"}
    @invalid_attrs %{color: nil, name: nil, original: nil}

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
      assert picture.color == "some color"
      assert picture.name == "some name"
      assert picture.original == "some original"
    end

    test "create_picture/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Optimizations.create_picture(@invalid_attrs)
    end

    test "update_picture/2 with valid data updates the picture" do
      picture = picture_fixture()
      assert {:ok, picture} = Optimizations.update_picture(picture, @update_attrs)
      assert %Picture{} = picture
      assert picture.color == "some updated color"
      assert picture.name == "some updated name"
      assert picture.original == "some updated original"
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
