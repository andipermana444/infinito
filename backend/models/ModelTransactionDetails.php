<?php 
class ModelTransactionDetails extends Connection {
    private $id;
    private $transaction_id;
    private $product_id;
    private $quantity;
    private $price;

    public function __get($atribute)
    {
        if (property_exists($this, $atribute)) {
            return $this->$atribute;
        }
    }
    public function __set($atribut, $value)
    {
        if (property_exists($this, $atribut)) {

            $this->$atribut = $value;

        }
    }
    // Membaca Semua transaction_details
    public function getAllTransactionDetails()
    {
        $query = "SELECT * FROM transaction_details";
        return $this->conn->query($query);
    }
    
    // Membaca Satu transaction_details
    public function getTransactionDetailsById()
    {
        $query = "SELECT * FROM transaction_details where id =" . $this->id;
        return $this->conn->query($query);
    }

    public function getTransactionDetailsByTransactionId()
    {
        $query = "SELECT * FROM transaction_details where transaction_id =" . $this->transaction_id;
        return $this->conn->query($query);
    }
    
    // Membuat transaction_details Baru
    public function createTransactionDetails()
    {
        $query = "INSERT INTO transaction_details (id, transaction_id, product_id, quantity, price) VALUES ('$this->id', '$this->transaction_id', '$this->product_id','$this->quantity', '$this->price')";
        return $this->conn->query($query);
    }
    
    // Memperbarui transaction_details
    public function updateTransactionDetails()
    {
        $query = "UPDATE transaction_details SET transaction_id='$this->transaction_id', product_id='$this->product_id', quantity='$this->quantity', price='$this->price' WHERE id=" . $this->id;
        return $this->conn->query($query);
    }

    // Menghapus transaction_details
    public function deleteTransactionDetails()
    {
        $query = "DELETE FROM transaction_details WHERE id =" . $this->id;
        return $this->conn->query($query);
    }
}
?>