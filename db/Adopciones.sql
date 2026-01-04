-- =========================================
-- BASE DE DATOS: PLATAFORMA DE ADOPCIONES
-- =========================================

CREATE DATABASE plataforma_adopciones;
USE plataforma_adopciones;

-- =========================================
-- TABLA: ALBERGUE (ÚNICOS USUARIOS CON LOGIN)
-- =========================================
CREATE TABLE albergue (
    id_albergue INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);

-- =========================================
-- TABLA: PERRO
-- =========================================
CREATE TABLE perro (
    id_perro INT AUTO_INCREMENT PRIMARY KEY,
    id_albergue INT NOT NULL,
    nombre VARCHAR(50),
    edad INT,
    sexo ENUM('Macho', 'Hembra'),
    raza VARCHAR(50),
    tamano ENUM('Pequeño', 'Mediano', 'Grande'),
    descripcion TEXT,
    estado ENUM('Disponible', 'Adoptado') DEFAULT 'Disponible',
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_albergue) REFERENCES albergue(id_albergue)
        ON DELETE CASCADE
);

-- =========================================
-- TABLA: IMÁGENES DEL PERRO
-- =========================================
CREATE TABLE imagen_perro (
    id_imagen INT AUTO_INCREMENT PRIMARY KEY,
    id_perro INT NOT NULL,
    ruta_imagen VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_perro) REFERENCES perro(id_perro)
        ON DELETE CASCADE
);

-- =========================================
-- TABLA: SOLICITANTE (SIN LOGIN)
-- =========================================
CREATE TABLE solicitante (
    id_solicitante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT
);

-- =========================================
-- TABLA: SOLICITUD DE ADOPCIÓN
-- =========================================
CREATE TABLE solicitud_adopcion (
    id_solicitud INT AUTO_INCREMENT PRIMARY KEY,
    id_perro INT NOT NULL,
    id_solicitante INT NOT NULL,
    mensaje TEXT,
    fecha_solicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_perro) REFERENCES perro(id_perro),
    FOREIGN KEY (id_solicitante) REFERENCES solicitante(id_solicitante)
);

-- =========================================
-- TABLA: DONACIONES (MERCADOPAGO)
-- =========================================
CREATE TABLE donacion (
    id_donacion INT AUTO_INCREMENT PRIMARY KEY,
    id_albergue INT NOT NULL,
    nombre_donante VARCHAR(100) NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    mp_payment_id VARCHAR(100),
    fecha_donacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_albergue) REFERENCES albergue(id_albergue)
        ON DELETE CASCADE
);
