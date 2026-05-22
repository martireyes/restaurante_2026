-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-05-2023 a las 22:11:41
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `restaurante`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `config`
--

CREATE TABLE `config` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(11) NOT NULL,
  `email` varchar(150) NOT NULL,
  `direccion` text NOT NULL,
  `mensaje` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `config`
--

INSERT INTO `config` (`id`, `nombre`, `telefono`, `email`, `direccion`, `mensaje`) VALUES
(1, 'Restaurante Aloha', '972380722', 'resaloha@gmail.com', 'San Lorenzo - Paraguay', 'Gracias por la compra');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedidos`
--

CREATE TABLE `detalle_pedidos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `detalle_pedidos`
--

INSERT INTO `detalle_pedidos` (`id`, `nombre`, `precio`, `cantidad`, `id_pedido`) VALUES
(1, 'AJI DE GALLINA', '10.00', 1, 1),
(2, 'CEBICHE', '25.00', 1, 1),
(3, 'ARROZ CON POLLO', '8.00', 3, 1),
(4, 'CEBICHE', '25.00', 1, 2),
(5, 'ARROZ CON POLLO', '8.00', 1, 2),
(6, 'AJI DE GALLINA', '10.00', 1, 3),
(7, 'CEBICHE', '25.00', 1, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `id_sala` int(11) NOT NULL,
  `num_mesa` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `observacion` text DEFAULT NULL,
  `estado` enum('PENDIENTE','FINALIZADO') NOT NULL DEFAULT 'PENDIENTE',
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id`, `id_sala`, `num_mesa`, `fecha`, `total`, `observacion`, `estado`, `id_usuario`) VALUES
(1, 1, 1, '2023-05-25 20:03:27', '59.00', '', 'FINALIZADO', 1),
(2, 3, 3, '2023-05-25 20:03:43', '33.00', '', 'FINALIZADO', 1),
(3, 3, 5, '2023-05-25 20:04:17', '10.00', '', 'FINALIZADO', 1),
(4, 2, 10, '2023-05-25 20:03:11', '25.00', '', 'PENDIENTE', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `platos`
--

CREATE TABLE `platos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `platos`
--

INSERT INTO `platos` (`id`, `nombre`, `precio`, `imagen`, `fecha`, `estado`) VALUES
(1, 'AJI DE GALLINA', '10.00', '', NULL, 1),
(2, 'CEBICHE', '25.00', '', NULL, 1),
(3, 'ARROZ CON POLLO', '8.00', '', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salas`
--

CREATE TABLE `salas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `mesas` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `salas`
--

INSERT INTO `salas` (`id`, `nombre`, `mesas`, `estado`) VALUES
(1, 'ENTRADA PRINCIPAL', 5, 1),
(2, 'SEGUNDO PISO', 10, 1),
(3, 'FRENTE COCINA', 8, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `temp_pedidos`
--

CREATE TABLE `temp_pedidos` (
  `id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `correo` varchar(200) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `rol` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `pass`, `rol`, `estado`) VALUES
(1, 'SISTEMAS', 'admin@gmail.com', '21232f297a57a5a743894a0e4a801fc3', 1, 1);


CREATE TABLE clientes (
    id_clientes INT AUTO_INCREMENT PRIMARY KEY,
    ruc_clientes VARCHAR(20) NOT NULL UNIQUE, -- Soporta guiones (ej: 1234567-8) o cédulas limpias
    razonsocial_clientes VARCHAR(150) NOT NULL,
    direc_clientes VARCHAR(255) NULL,
    tel_clientes VARCHAR(50) NULL,
    estado_clientes INT DEFAULT 1, -- 1 = Activo, 0 = Inactivo
    createdat_clientes TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE caja_turnos (
    id_cajaturnos INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_sucursal INT NOT NULL,
    apertura_cajaturnos DATETIME NOT NULL,
    montoinicial_cajaturnos NUMERIC(10) NOT NULL DEFAULT 0,
    cierre_cajaturnos DATETIME NULL,
    montofinalsis_cajaturnos NUMERIC(10) NOT NULL DEFAULT 0,
    montofinalreal_cajaturnos NUMERIC(10) NOT NULL DEFAULT 0,
    discrepancia_cajaturnos NUMERIC(10) NOT NULL DEFAULT 0,
    estado_cajaturnos VARCHAR(20) DEFAULT 'Abierto',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE arqueo_detalles (
    id_arqueos INT AUTO_INCREMENT PRIMARY KEY,
    id_cajaturnos INT NOT NULL,
    nombre_arqueos INT NOT NULL,
    cant_arqueos INT NOT NULL DEFAULT 0,
    subtotal_arqueos NUMERIC(10) NOT NULL,
    FOREIGN KEY (id_cajaturnos) REFERENCES caja_turnos(id_cajaturnos) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE facturas (
    id_facturas INT AUTO_INCREMENT PRIMARY KEY,
    id_ped INT NULL,
    id_clientes INT NOT NULL,
    id_cajaturnos INT NOT NULL,
    nro_facturas VARCHAR(20) NOT NULL UNIQUE,
    timbrado_facturas VARCHAR(20) NOT NULL,
    emision_facturas DATETIME NOT NULL,
    tipo_facturas VARCHAR(15) NOT NULL,
    exenta_facturas NUMERIC(10) NOT NULL DEFAULT 0,
    iva5_facturas NUMERIC(10) NOT NULL DEFAULT 0,
    iva10_facturas NUMERIC(10) NOT NULL DEFAULT 0,
    total_facturas NUMERIC(10) NOT NULL DEFAULT 0,
    estado_facturas VARCHAR(15) DEFAULT 'Emitido',
    FOREIGN KEY (id_clientes) REFERENCES clientes(id_clientes),
    FOREIGN KEY (id_cajaturnos) REFERENCES caja_turnos(id_cajaturnos)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE factura_detalles (
    id_facdetalles INT AUTO_INCREMENT PRIMARY KEY,
    id_facturas INT NOT NULL,
    id_platos INT NOT NULL,
    cant_facdetalles INT NOT NULL,
    preunitario_facdetalles NUMERIC(10) NOT NULL,
    porciva_facdetalles INT NOT NULL,
    subtotal_facdetalles NUMERIC(10) NOT NULL,
    FOREIGN KEY (id_facturas) REFERENCES facturas(id_facturas) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE cuentas_cobrar (
    id_cobrar INT AUTO_INCREMENT PRIMARY KEY,
    id_facturas INT NOT NULL,
    total_cobrar NUMERIC(10) NOT NULL,
    saldo_cobrar NUMERIC(10) NOT NULL,
    fecha_cobrar DATE NOT NULL,
    estado_cobrar VARCHAR(20) DEFAULT 'Pendiente',
    FOREIGN KEY (id_facturas) REFERENCES facturas(id_Facturas)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE cobranzas_recibos (
    id_cobrecibos INT AUTO_INCREMENT PRIMARY KEY,
    id_cajaturnos INT NOT NULL,
    nro_recibo_cobrecibos VARCHAR(20) NOT NULL UNIQUE,
    total_cobrado_cobrecibos NUMERIC(10) NOT NULL,
    fecha_cobro_cobrecibos DATETIME NOT NULL,
    FOREIGN KEY (id_cajaturnos) REFERENCES caja_turnos(id_cajaturnos)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE cobranzas_detalles (
    id_cobdetalles INT AUTO_INCREMENT PRIMARY KEY,
    id_cobrecibos INT NOT NULL,
    id_cobrar INT NULL,
    id_facturas INT NULL,
    forma_pago_cobdetalles VARCHAR(25) NOT NULL,
    aportado_cobdetalles NUMERIC(10) NOT NULL,
    detallestransac_cobdetalles VARCHAR(255) NULL,
    FOREIGN KEY (id_cobrecibos) REFERENCES cobranzas_recibos(id_cobrecibos) ON DELETE CASCADE,
    FOREIGN KEY (id_cobrar) REFERENCES cuentas_cobrar(id_cobrar)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE depositos_bancarios (
    id_depositos INT AUTO_INCREMENT PRIMARY KEY,
    id_cajaturnos INT NOT NULL,
    bancoid_depositos VARCHAR(100) NOT NULL,
    nroboleta_depositos VARCHAR(50) NOT NULL UNIQUE,
    depositadoid_depositos NUMERIC(10) NOT NULL,
    fecha_depositos DATETIME NOT NULL,
    obserid_depositos VARCHAR(255) NULL,
    FOREIGN KEY (id_cajaturnos) REFERENCES caja_turnos(id_cajaturnos)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE notas_credito_debito (
    id_ncd INT AUTO_INCREMENT PRIMARY KEY,
    id_facturas INT NOT NULL,
    id_cajaturnos INT NOT NULL,
    tipo_ncd VARCHAR(10) NOT NULL,
    nro_nota_ncd VARCHAR(20) NOT NULL UNIQUE,
    timbrado_ncd VARCHAR(20) NOT NULL,
    motivo_ncd VARCHAR(255) NOT NULL,
    totalmodificado_ncd DECIMAL(12,2) NOT NULL,
    emision_ncd DATETIME NOT NULL,
    FOREIGN KEY (id_facturas) REFERENCES facturas(id_facturas),
    FOREIGN KEY (id_cajaturnos) REFERENCES caja_turnos(id_cajaturnos)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE notas_remision (
    id_remision INT AUTO_INCREMENT PRIMARY KEY,
    nro_remision VARCHAR(20) NOT NULL UNIQUE,
    timbrado_remision VARCHAR(20) NOT NULL,
    traslado_remision DATE NOT NULL,
    id INT NOT NULL,
    id_sucursal_destino INT NULL,
    motivo_remision VARCHAR(100) NOT NULL,
    estado_remision VARCHAR(15) DEFAULT 'Emitido',
    FOREIGN KEY (id) REFERENCES sucursales(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pedido` (`id_pedido`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_sala` (`id_sala`);

--
-- Indices de la tabla `platos`
--
ALTER TABLE `platos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `salas`
--
ALTER TABLE `salas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `temp_pedidos`
--
ALTER TABLE `temp_pedidos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `config`
--
ALTER TABLE `config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `platos`
--
ALTER TABLE `platos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `salas`
--
ALTER TABLE `salas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `temp_pedidos`
--
ALTER TABLE `temp_pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD CONSTRAINT `detalle_pedidos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
