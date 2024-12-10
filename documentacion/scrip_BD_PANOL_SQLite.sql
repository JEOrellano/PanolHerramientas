-- DROP TABLE IF EXISTS Inventario;
CREATE TABLE IF NOT EXISTS Inventario(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    descripcion TEXT NOT NULL,
    ubicacion TEXT NOT NULL DEFAULT 'DEPOSITO',
    foto TEXT NOT NULL DEFAULT 'img_item_default',
    estado INTEGER NOT NULL DEFAULT 1,
    CONSTRAINT CK_Inventario_ubicacion CHECK(ubicacion IN ('DEPOSITO', 'PRESTADO'))
);

-- DROP TABLE IF EXISTS Usuario;
CREATE TABLE IF NOT EXISTS Usuario(
    nombreUsuario TEXT NOT NULL,
    clave TEXT NOT NULL,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    rol TEXT NOT NULL DEFAULT 'PRESTATARIO',
    foto TEXT NOT NULL DEFAULT 'img_avatar_default',
    estado INTEGER NOT NULL DEFAULT 1,
    CONSTRAINT PK_Usuario PRIMARY KEY(nombreUsuario),
    CONSTRAINT CK_Usuario_rol CHECK(rol IN ('ADMIN', 'PRESTATARIO'))
);

-- DROP TABLE IF EXISTS Admin;
CREATE TABLE IF NOT EXISTS Admin(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    estado INTEGER NOT NULL DEFAULT 1,
    id_usuario TEXT NOT NULL,
    CONSTRAINT FK_Admin_Usuario FOREIGN KEY(id_usuario) REFERENCES Usuario(nombreUsuario),
    CONSTRAINT UK_Admin_idusuario UNIQUE(id_usuario)
);

-- DROP TABLE IF EXISTS Prestatario;
CREATE TABLE IF NOT EXISTS Prestatario(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    estado INTEGER NOT NULL DEFAULT 1,
    id_usuario TEXT NOT NULL,
    CONSTRAINT FK_Prestatario_Usuario FOREIGN KEY(id_usuario) REFERENCES Usuario(nombreUsuario),
    CONSTRAINT UK_Prestatario_idusuario UNIQUE(id_usuario)
);

-- DROP TABLE IF EXISTS Prestamo;
CREATE TABLE IF NOT EXISTS Prestamo(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fechaSolicitud DATETIME NOT NULL,
    fechaDevolucion DATETIME NOT NULL,
    estadoPrestamo TEXT NOT NULL DEFAULT 'ACEPTADO',
    estado INTEGER NOT NULL DEFAULT 1,
    id_inventario INTEGER NOT NULL,
    id_prestatario INTEGER NOT NULL,
    CONSTRAINT FK_Prestamo_Inventario FOREIGN KEY(id_inventario) REFERENCES Inventario(id),
    CONSTRAINT FK_Prestamo_Prestatario FOREIGN KEY(id_prestatario) REFERENCES Prestatario(id),
    CONSTRAINT CK_Prestamo_estadoPrestamo CHECK(estadoPrestamo IN ('ACEPTADO', 'CONCLUIDO'))
);
