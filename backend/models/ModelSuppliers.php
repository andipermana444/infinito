<?php 
class ModelSuppliers extends Connection {
    private $id;
    private $name;
    private $contact;
    private $address;

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
    // Membaca Semua Mahasiswa
    public function getAllSuppliers()
    {
        $query = "SELECT * FROM suppliers";
        return $this->conn->query($query);
    }
    
    // Membaca Satu Mahasiswa
    public function getSupplierById()
    {
        $query = "SELECT * FROM suppliers where id =" . $this->id;
        return $this->conn->query($query);
    }
    
    // Membuat Mahasiswa Baru
    public function createSupplier()
    {
        $query = "INSERT INTO suppliers (id, name, contact, address) VALUES ('$this->id', '$this->name', '$this->contact','$this->address')";
        return $this->conn->query($query);
    }
    
    // Memperbarui Mahasiswa
    public function updateSupplier()
    {
        $query = "UPDATE suppliers SET name='$this->name', contact='$this->contact', address='$this->address' WHERE id=" . $this->id;
        return $this->conn->query($query);
    }

    // Menghapus Mahasiswa
    public function deleteSupplier()
    {
        $query = "DELETE FROM suppliers WHERE id =" . $this->id;
        return $this->conn->query($query);
    }
}
?>