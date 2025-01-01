<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once "./database/Connection.php";
require_once "./models/ModelSuppliers.php";

$suppliers = new ModelSuppliers();
$method = $_SERVER['REQUEST_METHOD'];
$request_uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uri_segments = explode('/', $request_uri);

switch ($method) {
    case 'GET':
        $id = end($uri_segments);
        // mengambil data suppliers dengan id jika ada id di ujung url or else
        if (is_numeric($id)) {
            $suppliers->id = $id;
            $result = $suppliers->getSupplierById();
            $row = $result->fetch_assoc();
            echo json_encode($row);
        } else {
            $result = $suppliers->getAllsuppliers();
            $data = [];
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
            echo json_encode($data);
        }
        break;
    case 'POST':
        // data json  yang diharapkan, url: http://localhost/infinito/backend/suppliers.php
        // {
        //     "name": "Raditya Supplier",
        //     "contact": "08123456789",
        //     "address": "Jl. Christia Nova Imaduddien, Distrik 9"
        //   }
        $data = json_decode(file_get_contents("php://input"));
        $suppliers->name = $data->name;
        $suppliers->contact = $data->contact;
        $suppliers->address = $data->address;
        if ($suppliers->createSupplier()) {
            http_response_code(201);
            echo json_encode(["message" => "suppliers berhasil ditambahkan"]);
        } else {
            http_response_code(503);
            echo json_encode(["message" => "Gagal membuat suppliers"]);
        }
        break;
    case 'PUT':
        // url: http://localhost/infinito/backend/suppliers.php/1
        // {
        //     "name": "Raditya Supplier (updated)",
        //     "contact": "08123456789",
        //     "address": "Jl. Christia Nova Imaduddien, Distrik 9"
        //   }
        $id = end($uri_segments);
        $data = json_decode(file_get_contents("php://input"));
        $suppliers->id = $id;
        $suppliers->name = $data->name;
        $suppliers->contact = $data->contact;
        $suppliers->address = $data->address;
        if ($suppliers->updateSupplier()) {
            http_response_code(200);
            echo json_encode(["message" => "suppliers berhasil diperbarui"]);
        } else {
            http_response_code(503);
            echo json_encode(["message" => "Gagal memperbarui suppliers"]);
        }
        break;
    case 'DELETE':
        // url: http://localhost/infinito/backend/suppliers.php/1
        $id = end($uri_segments);
        $suppliers->id = $id;
        if ($suppliers->deleteSupplier()) {
            http_response_code(200);
            echo json_encode(["message" => "suppliers berhasil dihapus"]);
        } else {
            http_response_code(503);
            echo json_encode(["message" => "Gagal menghapus suppliers"]);
        }
        break;
}
?>