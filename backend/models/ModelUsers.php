<?php 
class ModelUsers extends Connection {
    private $id;
    private $name;
    private $email;
    private $password;
    private $role;

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
    public function getAllUsers()
    {
        $query = "SELECT * FROM users";
        return $this->conn->query($query);
    }
    
    // Membaca Satu Mahasiswa
    public function getUserById()
    {
        $query = "SELECT * FROM users where id =" . $this->id;
        return $this->conn->query($query);
    }
    
    // Membuat Mahasiswa Baru
    public function createUser()
    {
        $query = "INSERT INTO users (id, name, role, email, password) VALUES ('$this->id', '$this->name', '$this->role','$this->email', '$this->password')";
        return $this->conn->query($query);
    }
    
    // Memperbarui Mahasiswa
    public function updateUser()
    {
        $query = "UPDATE users SET name='$this->name', role='$this->role', email='$this->email' WHERE id=" . $this->id;
        return $this->conn->query($query);
    }

    // Menghapus Mahasiswa
    public function deleteUser()
    {
        $query = "DELETE FROM users WHERE id =" . $this->id;
        return $this->conn->query($query);
    }
}
?>