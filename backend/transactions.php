<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once "./database/Connection.php";
require_once "./models/ModelTransations.php";
require_once "./models/ModelTransactionDetails.php";
require_once "./models/ModelProducts.php";

$transactions = new ModelTransactions();
$transactionDetails = new ModelTransactionDetails();
$products = new ModelProducts();

$method = $_SERVER['REQUEST_METHOD'];
$request_uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uri_segments = explode('/', $request_uri);

switch ($method) {
    case 'GET':
        $id = end($uri_segments);
        // mengambil data transactions dengan id jika ada id di ujung url or else
        if (is_numeric($id)) {
            $transactions->id = $id;
            $resultTransaction = $transactions->getTransactionById();
            $rowTransaction = $resultTransaction->fetch_assoc();

            $transactionDetails->transaction_id = $id;
            $resultTransactionDetails = $transactionDetails->getTransactionDetailsByTransactionId();

            $dataTransactionDetails = [];
            while ($rowTransactionDetails = $resultTransactionDetails->fetch_assoc()) {
                $products->id = $rowTransactionDetails["product_id"];
                $resultProduct = $products->getProductById();

                $rowTransactionDetails["products"] = $resultProduct->fetch_assoc();
                $dataTransactionDetails[] = $rowTransactionDetails;
            }

            $rowTransaction["transaction_details"] = $dataTransactionDetails;

            http_response_code(200);
            echo json_encode($rowTransaction);
        } else {
            $resultTransactions = $transactions->getAlltransactions();

            $dataTransactions = [];
            while ($rowTransaction = $resultTransactions->fetch_assoc()) {
                $transactionDetails->transaction_id = $rowTransaction["id"];
                $resultTransactionDetails = $transactionDetails->getTransactionDetailsByTransactionId();

                $dataTransactionDetails = [];
                while ($rowTransactionDetails = $resultTransactionDetails->fetch_assoc()) {
                    $products->id = $rowTransactionDetails["product_id"];
                    $resultProduct = $products->getProductById();

                    $rowTransactionDetails["products"] = $resultProduct->fetch_assoc();
                    $dataTransactionDetails[] = $rowTransactionDetails;
                }

                $rowTransaction["transaction_details"] = $dataTransactionDetails;

                $dataTransactions[] = $rowTransaction;
            }

            http_response_code(200);
            echo json_encode($dataTransactions);
        }
        break;
    case 'POST':
        // url : http://localhost/infinito/backend/transactions.php
        // barang masuk atau UPDATE STOCK MASUK
        // {
        //     "user_id": "4",
        //     "status": "masuk",
        //     "transaction_details": [{
        //          "product_id": 3
        //          "quantity": "10"
        //          "price": "0"
        //      }, {
        //          "product_id": 3
        //          "quantity": "30"
        //          "price": "0"
        //      }]
        // }
        // barang keluar
        // barang keluar atau UPDATE STOCK barang keluar
        // {
        //     "user_id": "4",
        //     "total_amount": "5000", // jumlah harga barang yang dibeli yaitu 1 kopi seharga 5000
        //     "status": "keluar",
        //     "product_id": "2",
        //     "quantity": "1" // mengurangi 1 stock persediaan product_id=2 (kopi arabika) 
        // }
        // barang keluar

        $data = json_decode(file_get_contents("php://input"), true);

        // add data to ModelTransaction property
        $transactions->user_id = $data["user_id"] ?? 0;
        $transactions->status = $data["status"] ?? null;
        $transactions->total_amount = $data["total_amount"] ?? 0;

        $transaction_details = $data["transaction_details"];

        // membuat sebuah transaksi
        if (!$transactions->createTransaction()) {
            http_response_code(503);
            echo json_encode(["message" => "Gagal membuat transactions"]);
            exit;
        }

        // ambil data transaksi terakhir
        $lastTransaction = $transactions->getLastTransaction()->fetch_assoc();
        $transactionDetails->transaction_id = $lastTransaction["id"] ?? 0;

        // cek status barang mau di masukin atau di kluarin
        if ($data["status"] == "keluar") {
            echo"keluar";
            // mengurangi data stock
            // add data setiapto ModelTransactionDetails property
            foreach ($transaction_details as $detail) {
                $products->id = $detail["product_id"];
                $getProductById = $products->getProductById()->fetch_assoc();

                // Mengurangi jumlah stock product
                $products->stock = $getProductById["stock"] - $detail["quantity"];

                if (!$products->updateStockProduct()) {
                    http_response_code(500);
                    echo json_encode(["message" => "Gagal memperbarui stock produk", "product_id" => $data["transaction_details"], "detail" => $detail]);
                }

                // add data to ModelTransactionDetails property
                $transactionDetails->product_id = $detail["product_id"];
                $transactionDetails->quantity = $detail["quantity"];
                $transactionDetails->price = $getProductById["price"] * $detail["quantity"];

                $transactionDetails->createTransactionDetails();
            }

        } else {
            // menambah stock product
            // add data setiapto ModelTransactionDetails property
            foreach ($transaction_details as $detail) {
                $products->id = $detail["product_id"];
                $getProductById = $products->getProductById()->fetch_assoc();
                $products->stock = $getProductById["stock"] + $detail["quantity"];

                if (!$products->updateStockProduct()) {
                    http_response_code(500);
                    echo json_encode(["message" => "Gagal memperbarui stock produk", "product_id" => $data["transaction_details"], "detail" => $detail]);
                }

                $transactionDetails->product_id = $detail["product_id"];
                $transactionDetails->quantity = $detail["quantity"];
                $transactionDetails->price = 0;

                $transactionDetails->createTransactionDetails();
            }
        }

        http_response_code(201);
        echo json_encode(["message" => "transactions berhasil ditambahkan"]);

        break;
    // METHOD PUT OR PATCH TIDAK ADA, KARENA SEKALI DATA DIUBAH ATAU DIHAPUS AKAN MENGUBAH KESELURUHAN ROW DATA TRANSACTIONS, TRANSACTION_DETAILS, DAN PRODUCTS
    case 'PUT':
        http_response_code(503);
        echo json_encode(["message" => "Data Transaksi tidak bisa diubah atau dihapus"]);
        break;
    // METHOD DELETE TIDAK ADA, KARENA SEKALI DATA DIUBAH ATAU DIHAPUS AKAN MENGUBAH SELURUH ROW DATA TRANSACTIONS, TRANSACTION_DETAILS, DAN PRODUCTS
    case 'DELETE':
        http_response_code(503);
        echo json_encode(["message" => "Data Transaksi tidak bisa diubah atau dihapus"]);
        break;
}
?>