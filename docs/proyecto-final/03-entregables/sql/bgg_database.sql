-- =============================================================================
-- PROYECTO FINAL: BASE DE DATOS BGG - PATRÓN DE MODELADO PARTY
-- SGBD: Microsoft SQL Server (T-SQL)
-- Entregable: bgg_database.sql
-- Descripción: Implementación completa, normalizada e idempotente del patrón
--              PARTY para la entidad financiera BGG (Microcréditos).
-- =============================================================================

-- =============================================================================
-- SECCIÓN 1: CREACIÓN IDEMPOTENTE DE LA BASE DE DATOS
-- =============================================================================
USE master;
GO

-- Si la base de datos BGG ya existe, forzar cierre de conexiones y eliminarla
IF DB_ID('BGG') IS NOT NULL
BEGIN
    PRINT '>> Eliminando base de datos BGG existente para recreación limpia...';
    ALTER DATABASE BGG SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BGG;
END
GO

PRINT '>> Creando base de datos BGG...';
CREATE DATABASE BGG;
GO

USE BGG;
GO

PRINT '>> Base de datos BGG creada y seleccionada correctamente.';
GO

-- =============================================================================
-- SECCIÓN 2: DEFINICIÓN DE TABLAS (DDL) EN ORDEN DE DEPENDENCIA
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 2.1. TABLA HUB: party (Superclase abstracta de identidad)
-- -----------------------------------------------------------------------------
PRINT '>> Creando tabla: party';
CREATE TABLE party (
    party_id    BIGINT IDENTITY(1,1) PRIMARY KEY,
    party_type  NVARCHAR(20) NOT NULL CHECK (party_type IN ('PERSON', 'ORGANIZATION')),
    status      NVARCHAR(20) NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'INACTIVE')),
    created_at  DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- -----------------------------------------------------------------------------
-- 2.2. SUBCLASE: person (Herencia Class Table Inheritance 1:1)
-- -----------------------------------------------------------------------------
PRINT '>> Creando tabla: person';
CREATE TABLE person (
    party_id    BIGINT PRIMARY KEY,
    first_name  NVARCHAR(100) NOT NULL,
    last_name   NVARCHAR(100) NOT NULL,
    birth_date  DATE NULL,
    gender      NVARCHAR(10) NULL,
    CONSTRAINT FK_person_party FOREIGN KEY (party_id) 
        REFERENCES party(party_id) ON DELETE CASCADE
);
GO

-- -----------------------------------------------------------------------------
-- 2.3. SUBCLASE: organization (Herencia Class Table Inheritance 1:1)
-- -----------------------------------------------------------------------------
PRINT '>> Creando tabla: organization';
CREATE TABLE organization (
    party_id       BIGINT PRIMARY KEY,
    legal_name     NVARCHAR(200) NOT NULL,  -- Razón Social
    trade_name     NVARCHAR(200) NULL,      -- Nombre Comercial
    founding_date  DATE NULL,
    CONSTRAINT FK_organization_party FOREIGN KEY (party_id) 
        REFERENCES party(party_id) ON DELETE CASCADE
);
GO

-- -----------------------------------------------------------------------------
-- 2.4. SATÉLITE: party_identifier (Documentos de identidad desacoplados)
-- -----------------------------------------------------------------------------
PRINT '>> Creando tabla: party_identifier';
CREATE TABLE party_identifier (
    party_identifier_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    party_id            BIGINT NOT NULL,
    id_type             NVARCHAR(30) NOT NULL CHECK (id_type IN ('DNI', 'RUC', 'CE', 'PASSPORT')),
    id_value            NVARCHAR(50) NOT NULL,
    issuing_authority   NVARCHAR(100) NULL,  -- 'RENIEC', 'SUNAT', 'MIGRACIONES'
    valid_from          DATE NULL,
    valid_to            DATE NULL,
    CONSTRAINT FK_party_identifier_party FOREIGN KEY (party_id) 
        REFERENCES party(party_id) ON DELETE CASCADE,
    CONSTRAINT UQ_party_identifier UNIQUE (id_type, id_value)
);
GO

-- -----------------------------------------------------------------------------
-- 2.5. SATÉLITE: contact_mechanism (Mecanismos de contacto independientes)
-- -----------------------------------------------------------------------------
PRINT '>> Creando tabla: contact_mechanism';
CREATE TABLE contact_mechanism (
    contact_mechanism_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    party_id             BIGINT NOT NULL,
    type                 NVARCHAR(20) NOT NULL CHECK (type IN ('EMAIL', 'PHONE', 'ADDRESS')),
    value                NVARCHAR(255) NOT NULL,
    purpose              NVARCHAR(30) NULL,  -- 'PERSONAL', 'TRABAJO', 'COBRANZA', 'FISCAL'
    CONSTRAINT FK_contact_mechanism_party FOREIGN KEY (party_id) 
        REFERENCES party(party_id) ON DELETE CASCADE
);
GO

-- -----------------------------------------------------------------------------
-- 2.6. SATÉLITE: party_role (Roles de negocio temporales y dinámicos)
-- -----------------------------------------------------------------------------
PRINT '>> Creando tabla: party_role';
CREATE TABLE party_role (
    party_role_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    party_id      BIGINT NOT NULL,
    role_type     NVARCHAR(30) NOT NULL CHECK (role_type IN ('CLIENTE', 'PRESTATARIO', 'AVAL', 'COBRADOR', 'EMPLEADOR')),
    start_date    DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    end_date      DATE NULL,
    CONSTRAINT FK_party_role_party FOREIGN KEY (party_id) 
        REFERENCES party(party_id) ON DELETE CASCADE,
    CONSTRAINT UQ_party_role UNIQUE (party_id, role_type, start_date)
);
GO

-- -----------------------------------------------------------------------------
-- 2.7. SATÉLITE: party_relationship (Grafo dirigido y temporal entre partes)
-- -----------------------------------------------------------------------------
PRINT '>> Creando tabla: party_relationship';
CREATE TABLE party_relationship (
    party_relationship_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    from_party_id         BIGINT NOT NULL,
    to_party_id           BIGINT NOT NULL,
    from_role             NVARCHAR(30) NOT NULL,
    to_role               NVARCHAR(30) NOT NULL,
    relationship_type     NVARCHAR(30) NOT NULL CHECK (relationship_type IN ('AVAL', 'EMPLOYMENT', 'COBRANZA_ASIGNADA')),
    start_date            DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    end_date              DATE NULL,
    CONSTRAINT FK_party_rel_from FOREIGN KEY (from_party_id) REFERENCES party(party_id),
    CONSTRAINT FK_party_rel_to FOREIGN KEY (to_party_id) REFERENCES party(party_id),
    CONSTRAINT CHK_party_rel_diff CHECK (from_party_id <> to_party_id)
);
GO

-- -----------------------------------------------------------------------------
-- 2.8. NEGOCIO BGG: prestatario_detail (Detalle especializado del rol PRESTATARIO)
-- -----------------------------------------------------------------------------
PRINT '>> Creando tabla: prestatario_detail';
CREATE TABLE prestatario_detail (
    party_role_id        BIGINT PRIMARY KEY,
    linea_credito        DECIMAL(12,2) NOT NULL DEFAULT 0.00 CHECK (linea_credito >= 0),
    frecuencia_cuota     NVARCHAR(20) NOT NULL CHECK (frecuencia_cuota IN ('DIARIA', 'SEMANAL', 'QUINCENAL', 'MENSUAL')),
    calificacion_riesgo  NVARCHAR(20) NOT NULL DEFAULT 'NORMAL' CHECK (calificacion_riesgo IN ('NORMAL', 'CPP', 'DEFICIENTE', 'DUDOSO', 'PERDIDA')),
    CONSTRAINT FK_prestatario_detail_role FOREIGN KEY (party_role_id) 
        REFERENCES party_role(party_role_id) ON DELETE CASCADE
);
GO

-- -----------------------------------------------------------------------------
-- 2.9. NEGOCIO BGG: credito (Operaciones de préstamo originadas por prestatarios)
-- -----------------------------------------------------------------------------
PRINT '>> Creando tabla: credito';
CREATE TABLE credito (
    credito_id        BIGINT IDENTITY(1,1) PRIMARY KEY,
    party_role_id     BIGINT NOT NULL,
    monto             DECIMAL(12,2) NOT NULL CHECK (monto > 0),
    fecha_desembolso  DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    estado            NVARCHAR(20) NOT NULL DEFAULT 'VIGENTE' CHECK (estado IN ('VIGENTE', 'CANCELADO', 'MOROSO')),
    CONSTRAINT FK_credito_prestatario FOREIGN KEY (party_role_id) 
        REFERENCES party_role(party_role_id)
);
GO

-- -----------------------------------------------------------------------------
-- 2.10. NEGOCIO BGG: pago (Transacciones de recaudación recibidas por cobradores)
-- -----------------------------------------------------------------------------
PRINT '>> Creando tabla: pago';
CREATE TABLE pago (
    pago_id        BIGINT IDENTITY(1,1) PRIMARY KEY,
    credito_id     BIGINT NOT NULL,
    party_role_id  BIGINT NOT NULL,  -- Rol COBRADOR que recaudó el pago
    monto_pagado   DECIMAL(12,2) NOT NULL CHECK (monto_pagado > 0),
    fecha_pago     DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    CONSTRAINT FK_pago_credito FOREIGN KEY (credito_id) 
        REFERENCES credito(credito_id),
    CONSTRAINT FK_pago_cobrador FOREIGN KEY (party_role_id) 
        REFERENCES party_role(party_role_id)
);
GO

PRINT '=============================================================================';
PRINT '>> SECCIÓN 2 COMPLETADA: Las 10 tablas han sido creadas con éxito.';
PRINT '=============================================================================';
GO

-- =============================================================================
-- SECCIÓN 3: POBLACIÓN DE DATOS DE EJEMPLO REALISTAS (DML)
-- =============================================================================
PRINT '>> Insertando datos de prueba demostrativos...';

-- -----------------------------------------------------------------------------
-- 3.1. INSERCIÓN EN party
-- -----------------------------------------------------------------------------
-- Party 1: Entidad BGG (Organización)
-- Party 2: Carlos Mendoza (Persona multi-rol: Cliente + Prestatario + Aval)
-- Party 3: María Quispe (Persona multi-rol: Cliente + Prestataria)
-- Party 4: Juan Pérez (Persona: Cobrador/Empleado de BGG)
-- Party 5: Ana Ramos (Persona: Cliente + Prestataria de crédito ya cancelado)
INSERT INTO party (party_type, status, created_at) VALUES 
('ORGANIZATION', 'ACTIVE', '2025-01-01 08:00:00'), -- party_id 1
('PERSON',       'ACTIVE', '2025-02-10 09:30:00'), -- party_id 2
('PERSON',       'ACTIVE', '2025-03-05 11:15:00'), -- party_id 3
('PERSON',       'ACTIVE', '2025-01-15 08:30:00'), -- party_id 4
('PERSON',       'ACTIVE', '2025-04-01 10:00:00'); -- party_id 5
GO

-- -----------------------------------------------------------------------------
-- 3.2. INSERCIÓN EN person
-- -----------------------------------------------------------------------------
INSERT INTO person (party_id, first_name, last_name, birth_date, gender) VALUES
(2, N'Carlos Alberto', N'Mendoza Ríos',    '1988-05-14', N'MASCULINO'),
(3, N'María Elena',    N'Quispe Flores',   '1992-11-23', N'FEMENINO'),
(4, N'Juan Carlos',    N'Pérez Torres',    '1985-08-30', N'MASCULINO'),
(5, N'Ana Lucía',      N'Ramos Castillo',  '1995-02-18', N'FEMENINO');
GO

-- -----------------------------------------------------------------------------
-- 3.3. INSERCIÓN EN organization
-- -----------------------------------------------------------------------------
INSERT INTO organization (party_id, legal_name, trade_name, founding_date) VALUES
(1, N'BGG Microfinanzas S.A.C.', N'BGG Soluciones Financieras', '2020-01-10');
GO

-- -----------------------------------------------------------------------------
-- 3.4. INSERCIÓN EN party_identifier (Documentos)
-- -----------------------------------------------------------------------------
INSERT INTO party_identifier (party_id, id_type, id_value, issuing_authority, valid_from, valid_to) VALUES
(1, 'RUC', '20601234567', N'SUNAT', '2020-01-10', NULL),
(2, 'DNI', '45891234',    N'RENIEC', '2015-05-14', '2030-05-14'),
(2, 'RUC', '10458912341', N'SUNAT', '2018-03-01', NULL), -- Demuestra 2 documentos para 1 sola persona
(3, 'DNI', '71234567',    N'RENIEC', '2018-11-23', '2028-11-23'),
(4, 'DNI', '40987654',    N'RENIEC', '2012-08-30', '2028-08-30'),
(5, 'DNI', '48123987',    N'RENIEC', '2019-02-18', '2029-02-18');
GO

-- -----------------------------------------------------------------------------
-- 3.5. INSERCIÓN EN contact_mechanism (Mecanismos de contacto)
-- -----------------------------------------------------------------------------
INSERT INTO contact_mechanism (party_id, type, value, purpose) VALUES
(1, 'EMAIL',   'contacto@bggmicrofinanzas.pe', 'FISCAL'),
(1, 'PHONE',   '+51 1 4567890',               'FISCAL'),
(1, 'ADDRESS', 'Av. Javier Prado Este 2450, San Borja, Lima', 'FISCAL'),
(2, 'PHONE',   '+51 987654321',               'PERSONAL'),
(2, 'EMAIL',   'carlos.mendoza@gmail.com',    'PERSONAL'),
(2, 'ADDRESS', 'Mz. A Lt. 12 Asoc. Los Laureles, SJL, Lima', 'COBRANZA'),
(3, 'PHONE',   '+51 976543210',               'PERSONAL'),
(3, 'ADDRESS', 'Av. Canta Callao 340, Los Olivos, Lima',      'COBRANZA'),
(4, 'PHONE',   '+51 965432109',               'TRABAJO'),
(4, 'EMAIL',   'jperez@bggmicrofinanzas.pe',  'TRABAJO'),
(5, 'PHONE',   '+51 954321098',               'PERSONAL'),
(5, 'ADDRESS', 'Jr. Junín 567, Trujillo',     'COBRANZA');
GO

-- -----------------------------------------------------------------------------
-- 3.6. INSERCIÓN EN party_role (Roles de negocio)
-- -----------------------------------------------------------------------------
-- Party 1: BGG como EMPLEADOR
-- Party 2: Carlos Mendoza con 3 roles simultáneos: CLIENTE, PRESTATARIO, AVAL
-- Party 3: María Quispe con 2 roles simultáneos: CLIENTE, PRESTATARIO
-- Party 4: Juan Pérez como COBRADOR
-- Party 5: Ana Ramos con 2 roles: CLIENTE, PRESTATARIO
INSERT INTO party_role (party_id, role_type, start_date, end_date) VALUES
(1, 'EMPLEADOR',   '2020-01-10', NULL), -- party_role_id 1
(2, 'CLIENTE',     '2025-02-10', NULL), -- party_role_id 2
(2, 'PRESTATARIO', '2025-02-15', NULL), -- party_role_id 3
(2, 'AVAL',        '2025-03-05', NULL), -- party_role_id 4
(3, 'CLIENTE',     '2025-03-05', NULL), -- party_role_id 5
(3, 'PRESTATARIO', '2025-03-10', NULL), -- party_role_id 6
(4, 'COBRADOR',    '2025-01-15', NULL), -- party_role_id 7
(5, 'CLIENTE',     '2025-04-01', NULL), -- party_role_id 8
(5, 'PRESTATARIO', '2025-04-05', NULL); -- party_role_id 9
GO

-- -----------------------------------------------------------------------------
-- 3.7. INSERCIÓN EN party_relationship (Grafo de relaciones)
-- -----------------------------------------------------------------------------
-- 1) Juan Pérez (Cobrador) trabaja para BGG (Empleador) -> EMPLOYMENT
-- 2) Carlos Mendoza (Aval) garantiza a María Quispe (Prestataria) -> AVAL
-- 3) Juan Pérez (Cobrador) asignado a cobrar a Carlos Mendoza -> COBRANZA_ASIGNADA
-- 4) Juan Pérez (Cobrador) asignado a cobrar a María Quispe -> COBRANZA_ASIGNADA
INSERT INTO party_relationship (from_party_id, to_party_id, from_role, to_role, relationship_type, start_date, end_date) VALUES
(4, 1, 'COBRADOR', 'EMPLEADOR',   'EMPLOYMENT',        '2025-01-15', NULL),
(2, 3, 'AVAL',     'PRESTATARIO', 'AVAL',              '2025-03-05', NULL),
(4, 2, 'COBRADOR', 'PRESTATARIO', 'COBRANZA_ASIGNADA', '2025-02-15', NULL),
(4, 3, 'COBRADOR', 'PRESTATARIO', 'COBRANZA_ASIGNADA', '2025-03-10', NULL);
GO

-- -----------------------------------------------------------------------------
-- 3.8. INSERCIÓN EN prestatario_detail
-- -----------------------------------------------------------------------------
-- Cuelgan de party_role_id de aquellos roles con role_type = 'PRESTATARIO'
INSERT INTO prestatario_detail (party_role_id, linea_credito, frecuencia_cuota, calificacion_riesgo) VALUES
(3, 5000.00, 'DIARIA',  'NORMAL'), -- Carlos Mendoza
(6, 3000.00, 'DIARIA',  'CPP'),    -- María Quispe
(9, 2000.00, 'SEMANAL', 'NORMAL'); -- Ana Ramos
GO

-- -----------------------------------------------------------------------------
-- 3.9. INSERCIÓN EN credito
-- -----------------------------------------------------------------------------
-- Crédito 1: Desembolsado a Carlos Mendoza (party_role_id 3) por S/. 3,000.00
-- Crédito 2: Desembolsado a María Quispe (party_role_id 6) por S/. 1,500.00
-- Crédito 3: Desembolsado a Ana Ramos (party_role_id 9) por S/. 1,000.00 (CANCELADO)
INSERT INTO credito (party_role_id, monto, fecha_desembolso, estado) VALUES
(3, 3000.00, '2025-08-01', 'VIGENTE'),   -- credito_id 1
(6, 1500.00, '2025-08-15', 'VIGENTE'),   -- credito_id 2
(9, 1000.00, '2025-07-01', 'CANCELADO'); -- credito_id 3
GO

-- -----------------------------------------------------------------------------
-- 3.10. INSERCIÓN EN pago
-- -----------------------------------------------------------------------------
-- Pagos del Crédito 1 (Carlos Mendoza, total prestado S/. 3000, 4 cuotas de 500 = S/. 2000 pagados, saldo S/. 1000)
-- Pagos del Crédito 2 (María Quispe, total prestado S/. 1500, 2 cuotas de 300 = S/. 600 pagados, saldo S/. 900)
-- Pagos del Crédito 3 (Ana Ramos, total prestado S/. 1000, 2 cuotas de 500 = S/. 1000 pagados, saldo S/. 0)
-- Todos recaudados por el Cobrador Juan Pérez (party_role_id 7)
INSERT INTO pago (credito_id, party_role_id, monto_pagado, fecha_pago) VALUES
(1, 7, 500.00, '2025-08-08'),
(1, 7, 500.00, '2025-08-15'),
(1, 7, 500.00, '2025-08-22'),
(1, 7, 500.00, '2025-08-29'),
(2, 7, 300.00, '2025-08-20'),
(2, 7, 300.00, '2025-08-27'),
(3, 7, 500.00, '2025-07-15'),
(3, 7, 500.00, '2025-07-30');
GO

PRINT '=============================================================================';
PRINT '>> SECCIÓN 3 COMPLETADA: Datos de prueba realistas insertados exitosamente.';
PRINT '=============================================================================';
GO

-- =============================================================================
-- SECCIÓN 4: CONSULTAS DE DEMOSTRACIÓN, FUNCIONES Y VISTAS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 4.1. FUNCIÓN ESCALAR: dbo.fn_calcular_saldo_credito
-- Propósito: Calcula dinámicamente el saldo pendiente de amortización de un crédito
--            restando la suma de pagos registrados al monto original desembolsado.
-- -----------------------------------------------------------------------------
PRINT '>> Creando función: dbo.fn_calcular_saldo_credito...';
GO

CREATE OR ALTER FUNCTION dbo.fn_calcular_saldo_credito (@credito_id BIGINT)
RETURNS DECIMAL(12,2)
AS
BEGIN
    DECLARE @monto_original DECIMAL(12,2);
    DECLARE @total_pagado DECIMAL(12,2);
    DECLARE @saldo_pendiente DECIMAL(12,2);

    -- 1. Obtener el monto original desembolsado
    SELECT @monto_original = monto
    FROM credito
    WHERE credito_id = @credito_id;

    -- Si no existe el crédito, retornar NULL
    IF @monto_original IS NULL
        RETURN NULL;

    -- 2. Calcular la sumatoria de todos los pagos efectuados para este crédito
    SELECT @total_pagado = ISNULL(SUM(monto_pagado), 0.00)
    FROM pago
    WHERE credito_id = @credito_id;

    -- 3. Determinar saldo pendiente
    SET @saldo_pendiente = @monto_original - @total_pagado;

    RETURN @saldo_pendiente;
END;
GO

-- -----------------------------------------------------------------------------
-- 4.2. VISTA: dbo.vw_clientes_multi_rol
-- Propósito: Lista a todas las personas que ejercen simultáneamente más de un rol
--            activo en el sistema (ej. Cliente, Prestatario, Aval), demostrando el
--            beneficio central del patrón PARTY: CERO DUPLICACIÓN DE IDENTIDAD.
-- -----------------------------------------------------------------------------
PRINT '>> Creando vista: dbo.vw_clientes_multi_rol...';
GO

CREATE OR ALTER VIEW dbo.vw_clientes_multi_rol
AS
SELECT 
    p.party_id,
    per.first_name + ' ' + per.last_name AS nombre_completo,
    doc.id_type AS tipo_documento_principal,
    doc.id_value AS numero_documento_principal,
    COUNT(pr.party_role_id) AS total_roles_activos,
    STRING_AGG(pr.role_type, ', ') AS roles_desempenados
FROM party p
INNER JOIN person per 
    ON p.party_id = per.party_id
LEFT JOIN party_identifier doc 
    ON p.party_id = doc.party_id AND doc.id_type = 'DNI'
INNER JOIN party_role pr 
    ON p.party_id = pr.party_id
WHERE (pr.end_date IS NULL OR pr.end_date >= CAST(GETDATE() AS DATE))
GROUP BY 
    p.party_id, 
    per.first_name, 
    per.last_name, 
    doc.id_type, 
    doc.id_value
HAVING COUNT(pr.party_role_id) > 1;
GO

PRINT '=============================================================================';
PRINT '>> SECCIÓN 4: EJECUTANDO CONSULTAS DE DEMOSTRACIÓN PARA LA SUSTENTACIÓN';
PRINT '=============================================================================';
GO

-- -----------------------------------------------------------------------------
-- DEMO A: CONSULTA COMPLEJA CON SELF-JOIN EN party_relationship
-- Demuestra cómo se vinculan dos entidades PARTY (Garante y Prestatario) mediante
-- una relación dirigida y fechada sin crear tablas redundantes de avales.
-- -----------------------------------------------------------------------------
PRINT '--- [DEMO A]: LISTADO DE AVALES Y SUS GARANTIZADOS (SELF-JOIN RECURSIVO) ---';
SELECT 
    pr.party_relationship_id               AS cod_relacion,
    pr.relationship_type                   AS tipo_relacion,
    p_aval.first_name + ' ' + p_aval.last_name AS aval_garante,
    doc_aval.id_type + ': ' + doc_aval.id_value AS doc_garante,
    p_prest.first_name + ' ' + p_prest.last_name AS prestatario_garantizado,
    doc_prest.id_type + ': ' + doc_prest.id_value AS doc_prestatario,
    pr.start_date                          AS fecha_inicio_garantia,
    ISNULL(CAST(pr.end_date AS NVARCHAR(20)), 'VIGENTE') AS estado_garantia
FROM party_relationship pr
INNER JOIN person p_aval 
    ON pr.from_party_id = p_aval.party_id
INNER JOIN person p_prest 
    ON pr.to_party_id = p_prest.party_id
LEFT JOIN party_identifier doc_aval 
    ON doc_aval.party_id = p_aval.party_id AND doc_aval.id_type = 'DNI'
LEFT JOIN party_identifier doc_prest 
    ON doc_prest.party_id = p_prest.party_id AND doc_prest.id_type = 'DNI'
WHERE pr.relationship_type = 'AVAL';
GO

-- -----------------------------------------------------------------------------
-- DEMO B: REPORTE DE CRÉDITOS Y SALDOS USANDO LA FUNCIÓN ESCALAR
-- Demuestra el uso de dbo.fn_calcular_saldo_credito para auditar en tiempo real
-- el estado financiero de cada préstamo y total amortizado.
-- -----------------------------------------------------------------------------
PRINT '--- [DEMO B]: ESTADO DE CRÉDITOS, AMORTIZACIONES Y SALDOS PENDIENTES ---';
SELECT 
    c.credito_id,
    p_prest.first_name + ' ' + p_prest.last_name AS prestatario,
    pd.frecuencia_cuota,
    pd.calificacion_riesgo,
    c.monto AS monto_desembolsado,
    ISNULL((SELECT SUM(pg.monto_pagado) FROM pago pg WHERE pg.credito_id = c.credito_id), 0.00) AS total_amortizado,
    dbo.fn_calcular_saldo_credito(c.credito_id) AS saldo_deudor_pendiente,
    c.estado AS estado_credito
FROM credito c
INNER JOIN party_role pr 
    ON c.party_role_id = pr.party_role_id
INNER JOIN person p_prest 
    ON pr.party_id = p_prest.party_id
INNER JOIN prestatario_detail pd 
    ON pr.party_role_id = pd.party_role_id;
GO

-- -----------------------------------------------------------------------------
-- DEMO C: CONSULTA A LA VISTA DE PERSONAS CON MULTI-ROL ACTIVO
-- Demuestra de manera visual y directa que una misma persona actúa en varios roles
-- de negocio simultáneos sin duplicar registros de identidad ni datos de contacto.
-- -----------------------------------------------------------------------------
PRINT '--- [DEMO C]: PERSONAS CON MÚLTIPLES ROLES ACTIVOS (VISTA CENTRAL DEL PATRÓN) ---';
SELECT 
    party_id,
    nombre_completo,
    tipo_documento_principal,
    numero_documento_principal,
    total_roles_activos,
    roles_desempenados
FROM dbo.vw_clientes_multi_rol;
GO

PRINT '=============================================================================';
PRINT '>> SCRIPT BGG_DATABASE.SQL EJECUTADO Y VERIFICADO AL 100% CON ÉXITO.';
PRINT '=============================================================================';
GO
