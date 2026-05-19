<?php
session_start();
if ($_SESSION['rol'] != 1) {
    header('Location: permisos.php');
    exit;
}
require_once "../conexion.php";

// Procesar datos generales de la Empresa
$query = mysqli_query($conexion, "SELECT * FROM config");
$data = mysqli_fetch_assoc($query);

if ($_POST && isset($_POST['btn_empresa'])) {
    $alert = '';
    if (empty($_POST['nombre']) || empty($_POST['ruc']) || empty($_POST['telefono']) || empty($_POST['email']) || empty($_POST['direccion'])) {
        $alert = '<div class="alert alert-warning">Todos los campos de la empresa son obligatorios.</div>';
    } else {
        $nombre = $_POST['nombre'];
        $ruc = $_POST['ruc'];
        $telefono = $_POST['telefono'];
        $email = $_POST['email'];
        $direccion = $_POST['direccion'];
        $moneda = $_POST['moneda'];
        $id = $_POST['id'];
        
        $update = mysqli_query($conexion, "UPDATE config SET nombre = '$nombre', ruc = '$ruc', telefono = '$telefono', email = '$email', direccion = '$direccion', moneda = '$moneda' WHERE id = $id");
        if ($update) {
            $alert = '<div class="alert alert-success">Datos de la empresa actualizados.</div>';
            $query = mysqli_query($conexion, "SELECT * FROM config");
            $data = mysqli_fetch_assoc($query);
        }
    }
}

// Mensajes de feedback de las sucursales
if(isset($_GET['msg'])){
    if($_GET['msg'] == 'saved') $alert = '<div class="alert alert-success">Sucursal agregada con éxito.</div>';
    if($_GET['msg'] == 'updated') $alert = '<div class="alert alert-success">Sucursal modificada correctamente.</div>';
    if($_GET['msg'] == 'deleted') $alert = '<div class="alert alert-danger">Sucursal eliminada del sistema.</div>';
}

// Obtener todas las sucursales para el listado
$query_sucursales = mysqli_query($conexion, "SELECT * FROM sucursales");

include_once "includes/header.php";
?>

<div class="row">
    <div class="col-md-10 mx-auto">
        <?php echo isset($alert) ? $alert : ''; ?>
        
        <ul class="nav nav-tabs mb-4" id="configTabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="empresa-tab" data-toggle="tab" href="#empresa" role="tab" aria-selected="true">
                    <i class="fas fa-building"></i> Datos de la Empresa
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="sucursales-tab" data-toggle="tab" href="#sucursales" role="tab" aria-selected="false">
                    <i class="fas fa-store"></i> Sucursales Disponibles
                </a>
            </li>
        </ul>

        <div class="tab-content text-dark" id="configTabsContent">
            
            <div class="tab-pane fade show active" id="empresa" role="tabpanel">
                <div class="card">
                    <div class="card-body">
                        <form action="" method="post" class="p-3">
                            <input type="hidden" name="id" value="<?php echo $data['id'] ?>">
                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label>Nombre:</label>
                                    <input type="text" name="nombre" class="form-control" value="<?php echo $data['nombre']; ?>" required>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>RUC:</label>
                                    <input type="text" name="ruc" class="form-control" value="<?php echo isset($data['ruc']) ? $data['ruc'] : ''; ?>" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label>Teléfono:</label>
                                    <input type="text" name="telefono" class="form-control" value="<?php echo $data['telefono']; ?>" required>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Moneda Base:</label>
                                    <select name="moneda" class="form-control">
                                        <option value="Guaraníes (PYG)" <?php echo ($data['moneda'] ?? '') == 'Guaraníes (PYG)' ? 'selected' : ''; ?>>Guaraníes ( PYG )</option>
                                        <option value="Dólares (USD)" <?php echo ($data['moneda'] ?? '') == 'Dólares (USD)' ? 'selected' : ''; ?>>Dólares ( USD )</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Correo Electrónico:</label>
                                    <input type="email" name="email" class="form-control" value="<?php echo $data['email']; ?>" required>
                            </div>
                            <div class="form-group">
                                <label>Dirección Fiscal:</label>
                                <input type="text" name="direccion" class="form-control" value="<?php echo $data['direccion']; ?>" required>
                            </div>
                            <button type="submit" name="btn_empresa" class="btn btn-primary"><i class="fas fa-save"></i> Guardar Cambios</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="sucursales" role="tabpanel">
                <div class="row">
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header card-header-info">
                                <h5 class="card-title" id="form-title">Nueva Sucursal</h5>
                            </div>
                            <div class="card-body">
                                <form action="procesar_sucursal.php" method="post" id="formSucursal">
                                    <input type="hidden" name="accion" id="accion" value="guardar">
                                    <input type="hidden" name="id_sucursal" id="id_sucursal" value="">
                                    
                                    <div class="form-group">
                                        <label>Nombre de Sucursal:</label>
                                        <input type="text" name="nombre_sucursal" id="nombre_sucursal" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Dirección:</label>
                                        <input type="text" name="dir_sucursal" id="dir_sucursal" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Teléfono:</label>
                                        <input type="text" name="tel_sucursal" id="tel_sucursal" class="form-control" required>
                                    </div>
                                    <div class="mt-3">
                                        <button type="submit" class="btn btn-success" id="btnSubmit">Agregar Sucursal</button>
                                        <button type="button" class="btn btn-secondary d-none" id="btnCancelar" onclick="resetearFormulario()">Cancelar</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th>ID</th>
                                                <th>Nombre</th>
                                                <th>Dirección</th>
                                                <th>Teléfono</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php while($suc = mysqli_fetch_assoc($query_sucursales)) { ?>
                                                <tr>
                                                    <td><?php echo $suc['id']; ?></td>
                                                    <td><?php echo $suc['nombre']; ?></td>
                                                    <td><?php echo $suc['direccion']; ?></td>
                                                    <td><?php echo $suc['telefono']; ?></td>
                                                    <td>
                                                        <button class="btn btn-sm btn-warning" onclick="editarSucursal(<?php echo htmlspecialchars(json_encode($suc)); ?>)">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <a href="procesar_sucursal.php?eliminar=<?php echo $suc['id']; ?>" class="btn btn-sm btn-danger" onclick="return confirm('¿Seguro que deseas borrar esta sucursal?')">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
function editarSucursal(sucursal) {
    document.getElementById('form-title').innerText = 'Modificar Sucursal #' + sucursal.id;
    document.getElementById('accion').value = 'actualizar';
    document.getElementById('id_sucursal').value = sucursal.id;
    document.getElementById('nombre_sucursal').value = sucursal.nombre;
    document.getElementById('dir_sucursal').value = sucursal.direccion;
    document.getElementById('tel_sucursal').value = sucursal.telefono;
    
    document.getElementById('btnSubmit').innerText = 'Guardar Cambios';
    document.getElementById('btnSubmit').className = 'btn btn-warning';
    document.getElementById('btnCancelar').classList.remove('d-none');
}

function resetearFormulario() {
    document.getElementById('form-title').innerText = 'Nueva Sucursal';
    document.getElementById('accion').value = 'guardar';
    document.getElementById('id_sucursal').value = '';
    document.getElementById('formSucursal').reset();
    
    document.getElementById('btnSubmit').innerText = 'Agregar Sucursal';
    document.getElementById('btnSubmit').className = 'btn btn-success';
    document.getElementById('btnCancelar').className = 'btn btn-secondary d-none';
}
</script>

<?php include_once "includes/footer.php"; ?>