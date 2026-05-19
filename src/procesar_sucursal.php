<?php
session_start();
if ($_SESSION['rol'] != 1) {
    header('Location: permisos.php');
    exit;
}
require_once "../conexion.php";

if ($_POST) {
    $accion = $_POST['accion'];

    // ACCIÓN: GUARDAR NUEVA SUCURSAL
    if ($accion == 'guardar') {
        $nombre = $_POST['nombre_sucursal'];
        $direccion = $_POST['dir_sucursal'];
        $telefono = $_POST['tel_sucursal'];
        
        $query = mysqli_query($conexion, "INSERT INTO sucursales(nombre, direccion, telefono) VALUES ('$nombre', '$direccion', '$telefono')");
        header('Location: config.php?msg=saved');
        exit;
    }

    // ACCIÓN: MODIFICAR SUCURSAL EXISTENTE
    if ($accion == 'actualizar') {
        $id = $_POST['id_sucursal'];
        $nombre = $_POST['nombre_sucursal'];
        $direccion = $_POST['dir_sucursal'];
        $telefono = $_POST['tel_sucursal'];
        
        $query = mysqli_query($conexion, "UPDATE sucursales SET nombre='$nombre', direccion='$direccion', telefono='$telefono' WHERE id=$id");
        header('Location: config.php?msg=updated');
        exit;
    }
}

// ACCIÓN: ELIMINAR SUCURSAL (Vía GET para facilidad de la plantilla)
if (isset($_GET['eliminar'])) {
    $id = $_GET['eliminar'];
    $query = mysqli_query($conexion, "DELETE FROM sucursales WHERE id = $id");
    header('Location: config.php?msg=deleted');
    exit;
}
?>