defmodule OptifireWeb.PictureControllerTest do
  use OptifireWeb.ConnCase

  alias Optifire.Optimizations

  @test_image %Plug.Upload{path: "test/fixtures/net_image.jpg", filename: "net_image.jpg"}

  @create_attrs %{original: @test_image}
  @update_attrs %{original: @test_image}
  @invalid_attrs %{original: nil}

  def fixture(:picture) do
    {:ok, picture} = Optimizations.create_picture(@create_attrs)
    picture
  end

  describe "index" do
    test "lists all pictures", %{conn: conn} do
      conn = get conn, picture_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Pictures"
    end
  end

  describe "new picture" do
    test "renders form", %{conn: conn} do
      conn = get conn, picture_path(conn, :new)
      assert html_response(conn, 200) =~ "New Picture"
    end
  end

  describe "create picture" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, picture_path(conn, :create), picture: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == picture_path(conn, :show, id)

      conn = get conn, picture_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Picture"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, picture_path(conn, :create), picture: @invalid_attrs
      assert html_response(conn, 200) =~ "New Picture"
    end
  end

  describe "edit picture" do
    setup [:create_picture]

    test "renders form for editing chosen picture", %{conn: conn, picture: picture} do
      conn = get conn, picture_path(conn, :edit, picture)
      assert html_response(conn, 200) =~ "Edit Picture"
    end
  end

  describe "update picture" do
    setup [:create_picture]

    test "redirects when data is valid", %{conn: conn, picture: picture} do
      conn = put conn, picture_path(conn, :update, picture), picture: @update_attrs
      assert redirected_to(conn) == picture_path(conn, :show, picture)

      conn = get conn, picture_path(conn, :show, picture)
      assert html_response(conn, 200) =~ "Picture updated successfully"
    end

    test "renders errors when data is invalid", %{conn: conn, picture: picture} do
      conn = put conn, picture_path(conn, :update, picture), picture: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Picture"
    end
  end

  describe "delete picture" do
    setup [:create_picture]

    test "deletes chosen picture", %{conn: conn, picture: picture} do
      conn = delete conn, picture_path(conn, :delete, picture)
      assert redirected_to(conn) == picture_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, picture_path(conn, :show, picture)
      end
    end
  end

  defp create_picture(_) do
    picture = fixture(:picture)
    {:ok, picture: picture}
  end
end
