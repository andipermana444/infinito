<?php

class ModelTransactions extends Connection
{
    private $id;
    private $user_id;
    private $total_amount;
    private $status;

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

    // Membaca Semua Transactions
    public function getAllTransactions()
    {
        $query = "SELECT * FROM transactions";
        return $this->conn->query($query);
    }

    // Membaca Satu Transactions
    public function getTransactionById()
    {
        $query = "SELECT * FROM transactions where id =" . $this->id;
        return $this->conn->query($query);
    }

    public function getLastTransaction()
    {
        $query = "SELECT * FROM transactions ORDER BY id DESC LIMIT 1";
        return $this->conn->query($query);
    }

    // Membuat Transactions Baru
    public function createTransaction()
    {
        $query = "INSERT INTO transactions (id, user_id, total_amount, status) VALUES ('$this->id', '$this->user_id', '$this->total_amount','$this->status')";
        return $this->conn->query($query);
    }

    // Memperbarui Transactions
    public function updateTransaction()
    {
        $query = "UPDATE transactions SET user_id='$this->user_id', total_amount='$this->total_amount', status='$this->status' WHERE id=" . $this->id;
        return $this->conn->query($query);
    }

    // Menghapus Transactions
    public function deleteTransaction()
    {
        $query = "DELETE FROM transactions WHERE id =" . $this->id;
        return $this->conn->query($query);
    }
}
?>