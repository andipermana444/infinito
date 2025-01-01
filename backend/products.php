<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once "./database/Connection.php";
require_once "./models/ModelProducts.php";

$products = new ModelProducts();
$method = $_SERVER['REQUEST_METHOD'];
$request_uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uri_segments = explode('/', $request_uri);

switch ($method) {
    case 'GET':
        $id = end($uri_segments);
        // mengambil data products dengan id jika ada id di ujung url or else
        if (is_numeric($id)) {
            $products->id = $id;
            $result = $products->getProductById();
            $row = $result->fetch_assoc();
            echo json_encode($row);
        } else {
            $result = $products->getAllProducts();
            $data = [];
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
            echo json_encode($data);
        }
        break;
    case 'POST':
        $id = end($uri_segments);
        // mengambil data products dengan id jika ada id di ujung url or else
        if (is_numeric($id)) {
            // INI CODE UNTUK UPDATE PRODUCTS
            $products->id = $id;
            $products->name = $_POST["name"];
            $products->category = $_POST["category"];
            $products->price = $_POST["price"];
            $products->stock = $_POST["stock"];
            $products->description = $_POST["description"];

            $change_image = $_POST["change_image"] ?? "false";
            if (isset($_FILES["image"]) && $change_image == "true") {
                // ketika user mengganti gambar maka ganti gambar ke yang baru
                $image = $_FILES["image"];
                $target_folder = "uploads/products/";
                $file_name = uniqid("image_", true) . basename($_FILES["image"]["name"]);
                $target_file = $target_folder . $file_name;
                if (move_uploaded_file($_FILES["image"]["tmp_name"], $target_file)) {
                    $products->image = $target_file;
                } else {
                    http_response_code(503);
                    echo json_encode(["message" => "Gagal mengupload file product"]);
                }
            } else if ($change_image == "true") {
                // ketika user menghapus gambar maka rubah url gambar ke default
                if ($products->category == "Food") {
                    $products->image = "http://localhost/infinito/backend/uploads/food.png";
                } else if ($products->category == "Drink") {
                    $products->image = "http://localhost/infinito/backend/uploads/drink.png";
                } else {
                    $products->image = "http://localhost/infinito/backend/uploads/snack.png";
                }
            } else {
                // ketika user tidak mengganti gambar maka gambar tetap sama seperti sebelumnya, note: pastikan image_url terisi
                $products->image = $_POST["image_url"];
            }

            if ($products->updateProduct()) {
                http_response_code(200);
                echo json_encode(["message" => "products berhasil diperbarui"]);
            } else {
                http_response_code(503);
                echo json_encode(["message" => "Gagal memperbarui products"]);
            }
            break;
        } else {
            // INI CODE UNTUK CREATE PRODUCTS
            $products->supplier_id = $_POST["supplier_id"];
            $products->name = $_POST["name"];
            $products->category = $_POST["category"];
            $products->price = $_POST["price"];
            $products->stock = $_POST["stock"];
            $products->description = $_POST["description"];
            if (isset($_FILES["image"])) {
                $image = $_FILES["image"];
                $target_folder = "uploads/products/";
                $file_name = uniqid("image_", true) . basename($_FILES["image"]["name"]);
                $target_file = $target_folder . $file_name;
                if (move_uploaded_file($_FILES["image"]["tmp_name"], $target_file)) {
                    $products->image = $target_file;
                } else {
                    http_response_code(503);
                    echo json_encode(["message" => "Gagal mengupload file product"]);
                }
            } else {
                if ($products->category == "Food") {
                    $products->image = "http://localhost/infinito/backend/uploads/food.png";
                } else if ($products->category == "Drink") {
                    $products->image = "http://localhost/infinito/backend/uploads/drink.png";
                } else {
                    $products->image = "http://localhost/infinito/backend/uploads/snack.png";
                }
            }
            if ($products->createProduct()) {
                http_response_code(201);
                echo json_encode(["message" => "products berhasil ditambahkan"]);
            } else {
                http_response_code(503);
                echo json_encode(["message" => "Gagal membuat products"]);
            }
            break;
        }
    // case 'PUT': METHOD PUT OR PATCH TIDAK ADA, DIGANTI DENGAN METHOD POST DENGAN ID DI AKHIR URL
    case 'DELETE':
        $id = end($uri_segments);
        $products->id = $id;
        if ($products->deleteProduct()) {
            http_response_code(200);
            echo json_encode(["message" => "products berhasil dihapus"]);
        } else {
            http_response_code(503);
            echo json_encode(["message" => "Gagal menghapus products"]);
        }
        break;
}
?>