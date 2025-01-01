<?php
class ModelProducts extends Connection
{
    private $id;
    private $name;
    private $category;
    private $supplier_id;
    private $price;
    private $stock;
    private $image;
    private $description;


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
    // Membaca Semua Best Sellers
    public function getAllProducts()
    {
        $query = "SELECT * FROM products";
        return $this->conn->query($query);
    }

    // Membaca Satu Best Sellers
    public function getProductById()
    {
        $query = "SELECT * FROM products where id =" . $this->id;
        return $this->conn->query($query);
    }

    // Membuat Best Sellers Baru
    public function createProduct()
    {
        $query = "INSERT INTO products (id, name, category, supplier_id, price, stock, image, description) VALUES ('$this->id', '$this->name', '$this->category','$this->supplier_id','$this->price','$this->stock','$this->image','$this->description')";
        return $this->conn->query($query);
    }

    // Memperbarui Best Sellers
    public function updateProduct()
    {
        $query = "UPDATE products SET name='$this->name', category='$this->category',  price='$this->price', stock='$this->stock', image='$this->image', description='$this->description' WHERE id=" . $this->id;
        return $this->conn->query($query);
    }

    public function updateStockProduct()
    {
        $query = "UPDATE products SET stock='$this->stock' WHERE id=" . $this->id;
        return $this->conn->query($query);
    }

    // Menghapus Best Sellers
    public function deleteProduct()
    {
        $query = "DELETE FROM products WHERE id =" . $this->id;
        return $this->conn->query($query);
    }
}
?>