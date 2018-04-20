defmodule OptifireWeb.PictureAPIControllerTest do
  use OptifireWeb.ConnCase

  alias Optifire.Optimizations

  @image %{name: "net_image.jpg", path: "test/fixtures/net_image.jpg", color: "52,59,79"}
  @plug_image %Plug.Upload{path: @image.path, filename: @image.name}

  @create_attrs %{original: @plug_image}
  @invalid_attrs %{original: nil}

  def fixture(:picture) do
    {:ok, picture} = Optimizations.create_picture(@create_attrs)
    picture
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pictures without pictures", %{conn: conn} do
      conn = get conn, picture_api_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end

    test "list all pictures with 1 picture", %{conn: conn} do
      %{id: id, color: color} = fixture :picture

      conn = get conn, picture_api_path(conn, :index)

      assert [%{
        "id" => ^id,
        "original" => _,
        "color" => ^color
      }] = json_response(conn, 200)["data"]
    end
  end

  describe "create picture" do
    test "renders picture when data is valid", %{conn: conn} do
      conn = post conn, picture_api_path(conn, :create), picture: @create_attrs
      assert %{"id" => id, "color" => color} = json_response(conn, 201)["data"]

      conn = get conn, picture_api_path(conn, :show, id)
      assert %{
        "id" => ^id,
        "original" => _,
        "color" => ^color
      } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, picture_api_path(conn, :create), picture: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_picture(_) do
    picture = fixture(:picture)
    {:ok, picture: picture}
  end
end
