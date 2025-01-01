<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once "./database/Connection.php";
require_once "./models/ModelUsers.php";

$users = new ModelUsers();
$method = $_SERVER['REQUEST_METHOD'];
$request_uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uri_segments = explode('/', $request_uri);

switch ($method) {
    case 'GET':
        $id = end($uri_segments);
        // mengambil data users dengan id jika ada id di ujung url or else
        if (is_numeric($id)) {
            // property id untuk mengambil 1 row data saja dari table users
            $users->id = $id;
            $result = $users->getUserById();
            $row = $result->fetch_assoc();
            echo json_encode($row);
        } else {
            // jika tidak ada id di url maka ambil semua data dari table users
            $result = $users->getAllUsers();
            $data = [];
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
            echo json_encode($data);
        }
        break;
    case 'POST':
        // contoh data json yang diharapkan dari url: http://localhost/infinito/backend/users.php
        // {
        //     "name": "Raditya Admin",
        //     "email": "radi@gmail.com", (note: email bersifat uniq)
        //     "password": "radiadmin123", (note: password akan di hash)
        //     "role": "admin" (note: "user", "admin" saja)
        // }
        // men dekode data json dari post method
        $data = json_decode(file_get_contents("php://input"));
        // isi property
        $users->name = $data->name;
        $users->email = $data->email;
        $users->password = password_hash($data->password, PASSWORD_DEFAULT); // hashing password
        $users->role = $data->role;
        // menjalankan fungsi createUser untuk membuat row data user baru di table user
        if ($users->createUser()) {
            // jika berhasil maka send message berhasil
            http_response_code(201);
            echo json_encode(["message" => "users berhasil ditambahkan"]);
        } else {
            // jika tidak berhasil maka send message gagal
            http_response_code(503);
            echo json_encode(["message" => "Gagal membuat users"]);
        }
        break;
    case 'PUT':
        // url: http://localhost/infinito/backend/users.php/1 (angka di belakang adalah id dari user)
        // {
        //     "name": "Raditya Admin (updated)", (note: contoh test api update)
        //     "email": "radi@gmail.com", (note: email bersifat uniq)
        //     "role": "admin"
        // }
        $id = end($uri_segments);
        $data = json_decode(file_get_contents("php://input"));
        $users->id = $id;
        $users->name = $data->name;
        $users->email = $data->email;
        $users->role = $data->role;
        if ($users->updateUser()) {
            http_response_code(200);
            echo json_encode(["message" => "users berhasil diperbarui"]);
        } else {
            http_response_code(503);
            echo json_encode(["message" => "Gagal memperbarui users"]);
        }
        break;
    case 'DELETE':
        // url: http://localhost/infinito/backend/users.php/1 (angka di belakang adalah id dari user)
        $id = end($uri_segments);
        $users->id = $id;
        if ($users->deleteUser()) {
            http_response_code(200);
            echo json_encode(["message" => "users berhasil dihapus"]);
        } else {
            http_response_code(503);
            echo json_encode(["message" => "Gagal menghapus users"]);
        }
        break;
}
?>