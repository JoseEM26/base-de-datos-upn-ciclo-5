# Patrón de Modelado PARTY — Identidad Única y Roles Dinámicos

> **Fuente de referencia:** `/home/jose/Aybar-Corp/examen-party/presentacion_party.html` (basada en Len Silverston, *The Data Model Resource Book, Vol. 1*, capítulo "Parties: People and Organizations").
> **Estado:** Solo documentación. No se ha generado modelo físico, script SQL ni PPT todavía — se hace cuando el equipo lo indique.
> **Por qué existe este documento:** el proyecto final va a modelar su base de datos usando el patrón PARTY, así que antes de tocar el caso real de negocio hay que dejar claro qué es el patrón, qué problema resuelve y qué se espera demostrar con él en el informe y la sustentación.

---

## 1. Resumen ejecutivo

El patrón PARTY es un arquetipo de modelado relacional para representar personas y organizaciones ("partes") que interactúan bajo múltiples roles de negocio (cliente, proveedor, empleado, socio, etc.) y se relacionan entre sí de forma dirigida y con vigencia histórica. Separa tres preguntas que normalmente se mezclan en un modelo ingenuo: **quién existe** (identidad), **qué rol ejerce** (función de negocio temporal) y **con quién se relaciona** (vínculo dirigido y fechado). Este proyecto lo usará como base del modelo conceptual/lógico/físico del Capítulo V del informe, en vez del enfoque clásico de "una tabla por rol".

---

## 2. La problemática que resuelve (el modelo ingenuo)

El diseño intuitivo de crear una tabla separada por cada rol de negocio (`clientes`, `proveedores`, `empleados`, cada una con columnas de nombre, documento, contacto, etc.) colapsa cuando la organización crece. Patologías concretas:

| Patología | Manifestación real | Impacto |
|---|---|---|
| **Duplicación de identidad** | Una empresa que es proveedor y a la vez cliente termina en dos filas de dos tablas distintas. | Actualizar el teléfono en una tabla deja la otra desactualizada e inconsistente. |
| **Columnas nulas gigantes** | Una tabla `clientes` que intenta servir tanto a personas naturales como a empresas. | ~50% de las columnas quedan `NULL` (apellidos/género para empresas, razón social para personas). |
| **Explosión de tablas** | Aparece un nuevo rol de negocio (distribuidor, aval, apoderado). | Cada rol nuevo obliga a crear una tabla nueva con las mismas columnas de contacto repetidas. |
| **Sin historial (amnesia)** | Un empleado es despedido o un proveedor se da de baja. | Un `DELETE` o un flag `activo=false` borra para siempre la respuesta a "¿quién era el gerente en junio de 2021?". |
| **Documento como identidad** | Usar `DNI` o `RUC` como Primary Key. | Falla con extranjeros (pasaporte), personas con DNI *y* RUC simultáneo, o entidades sin RUC aún. |

**Relevancia directa para el instructivo del curso:** estas mismas patologías son justo lo que el Capítulo V (Modelo conceptual, normalización, modelo físico) exige evitar y justificar explícitamente.

---

## 3. La idea central del patrón

Separación estricta de responsabilidades en tres preguntas:

1. **¿Quién existe?** → Identidad ontológica inmutable (`party`, `person`, `organization`).
2. **¿Qué función ejerce?** → Rol de negocio temporal y no exclusivo (`party_role` + tablas de detalle como `customer_detail`).
3. **¿Con quién se relaciona?** → Vínculo dirigido y fechado entre dos partes (`party_relationship`).

Aplica el mismo principio de responsabilidad única (SRP) que en diseño de software, pero a nivel de tablas: un cambio de dirección solo toca la tabla de contacto; un nuevo documento no toca la identidad; el fin de un contrato solo cierra una vigencia sin borrar al profesional.

---

## 4. Estructura del modelo (tablas núcleo)

### 4.1. Núcleo de identidad (herencia Class Table Inheritance)

```sql
CREATE TABLE party (
    party_id    BIGSERIAL PRIMARY KEY,
    party_type  VARCHAR(20) NOT NULL CHECK (party_type IN ('PERSON', 'ORGANIZATION')),
    status      VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    created_at  TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE person (
    party_id    BIGINT PRIMARY KEY REFERENCES party(party_id),
    first_name  VARCHAR(100) NOT NULL,
    last_name   VARCHAR(100) NOT NULL,
    birth_date  DATE,
    gender      VARCHAR(10)
);

CREATE TABLE organization (
    party_id       BIGINT PRIMARY KEY REFERENCES party(party_id),
    legal_name     VARCHAR(200) NOT NULL,  -- Razón Social
    trade_name     VARCHAR(200),           -- Nombre Comercial
    founding_date  DATE
);
```

`party` es la superclase abstracta (solo clave subrogada + tipo); `person` y `organization` son subclases puras sin columnas cruzadas. `party_id` es simultáneamente PK y FK en las subclases: no puede haber huérfanos ni duplicados.

### 4.2. Documentos de identidad desacoplados

```sql
CREATE TABLE party_identifier (
    party_identifier_id BIGSERIAL PRIMARY KEY,
    party_id            BIGINT NOT NULL REFERENCES party(party_id),
    id_type             VARCHAR(30) NOT NULL,   -- 'DNI', 'RUC', 'PASSPORT'
    id_value            VARCHAR(50) NOT NULL,
    issuing_authority    VARCHAR(100),           -- 'RENIEC', 'SUNAT', 'MIGRACIONES'
    valid_from           DATE,
    valid_to             DATE,
    UNIQUE (id_type, id_value)
);
```

Un documento **no es** la identidad: es un registro administrativo emitido por un tercero (RENIEC, SUNAT). Una misma `party` puede tener DNI + RUC + pasaporte simultáneamente sin tocar el esquema.

### 4.3. Roles de negocio (temporales, no exclusivos)

```sql
CREATE TABLE party_role (
    party_role_id BIGSERIAL PRIMARY KEY,
    party_id      BIGINT NOT NULL REFERENCES party(party_id),
    role_type     VARCHAR(30) NOT NULL,   -- 'CUSTOMER', 'SUPPLIER', 'EMPLOYEE'
    start_date    DATE NOT NULL DEFAULT CURRENT_DATE,
    end_date      DATE,
    UNIQUE (party_id, role_type, start_date)
);

CREATE TABLE customer_detail (
    party_role_id   BIGINT PRIMARY KEY REFERENCES party_role(party_role_id),
    credit_limit    NUMERIC(12,2) DEFAULT 0.00,
    customer_tier   VARCHAR(20) DEFAULT 'STANDARD'
);
```

"Un sujeto NO es cliente; un sujeto ACTÚA en el rol de cliente durante un periodo." Las tablas de detalle (ej. `customer_detail`, `employee_detail`) cuelgan de `party_role_id`, no de `party_id`, para no ensuciar el núcleo de identidad con reglas propias de un solo rol.

### 4.4. Vínculos entre partes (grafo dirigido y temporal)

```sql
CREATE TABLE party_relationship (
    party_relationship_id BIGSERIAL PRIMARY KEY,
    from_party_id         BIGINT NOT NULL REFERENCES party(party_id),
    to_party_id           BIGINT NOT NULL REFERENCES party(party_id),
    from_role             VARCHAR(30) NOT NULL,  -- 'EMPLOYEE'
    to_role               VARCHAR(30) NOT NULL,  -- 'EMPLOYER'
    relationship_type     VARCHAR(30) NOT NULL,  -- 'EMPLOYMENT'
    start_date            DATE NOT NULL DEFAULT CURRENT_DATE,
    end_date              DATE,
    CHECK (from_party_id <> to_party_id)
);
```

Casos que resuelve sin cambiar el esquema: jerarquías de mando (empleado→supervisor), estructuras corporativas (filial→matriz), titularidad (dueño→empresa), contratos laborales, delegaciones ("apoderado legal firma en representación de"). **Regla de oro: nunca `DELETE`**, se cierra la vigencia con `end_date`.

### 4.5. Contacto (satélite independiente)

```sql
CREATE TABLE contact_mechanism (
    contact_mechanism_id BIGSERIAL PRIMARY KEY,
    party_id             BIGINT NOT NULL REFERENCES party(party_id),
    type                 VARCHAR(20) NOT NULL,  -- 'EMAIL', 'PHONE', 'ADDRESS'
    value                VARCHAR(255) NOT NULL,
    purpose              VARCHAR(30)            -- 'BILLING', 'SHIPPING'
);
```

### 4.6. Regla de arquitectura (hub-and-spoke)

`party` es el hub central. Las tablas satélite (`party_identifier`, `party_role`, `party_relationship`, `contact_mechanism`) **nunca se referencian entre sí** — todas apuntan solo a `party`. La única excepción autorizada son las tablas de detalle especializado (ej. `customer_detail`), que cuelgan de `party_role_id`.

---

## 5. Ventajas

- **Cero duplicación de identidad**: una persona/empresa conserva una única clave subrogada de por vida, aunque cambie de rol.
- **Extensibilidad sin migraciones**: agregar un nuevo tipo de documento, rol o relación es insertar una fila, no alterar el esquema.
- **Auditoría temporal inmanente**: `start_date`/`end_date` permite reconstruir el estado exacto del negocio en cualquier fecha pasada — encaja directamente con la exigencia de "resultados reales" del Capítulo VI.
- **Esquema limpio**: elimina las columnas `NULL` masivas del modelo por-rol.

## 6. Desventajas y trade-offs

- **Sobrecarga de JOINs**: una consulta simple como "listar clientes con DNI" requiere unir `party ⋈ party_role ⋈ person ⋈ party_identifier`.
- **Curva de aprendizaje**: no hay tablas simples tipo `clientes`/`proveedores`, lo que puede confundir a quien no conoce el patrón (hay que estar preparados para explicarlo en la sustentación).
- **Complejidad en reportes**: suele requerir vistas materializadas (`vw_customers`) para simplificar lecturas frecuentes.
- **Disciplina de vigencias**: hay que validar que no se solapen fechas de roles activos.

## 7. Cuándo usarlo (y cuándo NO)

| Escenario | Evaluación | Justificación |
|---|---|---|
| ERPs, CRMs, banca, seguros, telecom | Altamente justificado | Las entidades cambian de rol continuamente y hay exigencias de auditoría histórica. |
| Holdings / estructuras corporativas multi-nivel | Altamente justificado | `party_relationship` resuelve jerarquías y representantes legales sin cambiar el esquema. |
| Landing page / formulario de contacto | Over-engineering | Una tabla plana `contactos(id, nombre, email, mensaje)` basta y es más rápida de construir. |
| CRUD simple con roles estáticos que nunca cambian | Over-engineering | El costo de los JOINs supera el beneficio si nunca hay reasignación de roles ni auditoría histórica. |

**Implicación para el proyecto:** una vez elegido el caso real de negocio, el equipo debe justificar en el informe (Cap. II/III) *por qué* este caso encaja en la columna "altamente justificado" y no en la de "over-engineering" — el instructivo exige justificar la selección de herramientas y enfoque, no solo aplicarlo porque sí.

---

## 8. Dónde encaja en la plantilla del informe (Capítulo V)

| Sección de la plantilla | Qué aporta el patrón PARTY |
|---|---|
| 5.3. Modelo conceptual (entidades, atributos, relaciones, cardinalidad) | `party` / `person` / `organization` como entidades raíz + roles y relaciones como entidades satélite. |
| 5.4. Modelo lógico | Esquema con `party_role`, `party_identifier`, `party_relationship` normalizado. |
| 5.5. Normalización | El patrón ya nace en 3FN/BCNF: cero columnas nulas cruzadas, cero grupos repetitivos de contacto. Se puede documentar explícitamente el paso de un modelo ingenuo (no normalizado) al modelo PARTY como el propio proceso de normalización. |
| 5.6. Modelo físico | Los `CREATE TABLE` de este documento son el punto de partida directo (ajustados al SGBD y al caso real elegidos). |
| 5.8. Políticas de seguridad de usuario | Los roles de negocio (`party_role`) son distintos de los roles/usuarios del SGBD — no confundir ambos conceptos al redactar esta sección. |

---

## 9. Caso real elegido: BGG

> **Decisión del equipo:** la entidad del caso es **BGG**, una entidad financiera de microcréditos. En el resto de esta documentación se usa solo el acrónimo BGG; el nombre completo se reserva para la carátula del informe y la ficha de validación oficial de Semana 1.

Es un caso "altamente justificado" para PARTY (ver §7): un cliente puede ser prestatario y a la vez aval de otro cliente, un cobrador/empleado puede ser también cliente, y los avales son relaciones dirigidas entre personas que exigen trazabilidad histórica — exactamente lo que un modelo por-rol-en-tabla-separada no resuelve bien.

### 9.1. Roles de negocio candidatos (`party_role.role_type`)

| Rol | Quién lo ejerce (`party_type`) | Detalle propio (tabla de detalle) |
|---|---|---|
| `CLIENTE` | PERSON u ORGANIZATION | Fecha de registro, zona/ruta asignada |
| `PRESTATARIO` | PERSON u ORGANIZATION | Línea de crédito, monto y frecuencia de cuota (diaria/semanal), calificación de riesgo |
| `AVAL` / `GARANTE` | PERSON | Crédito(s) garantizado(s) |
| `COBRADOR` / `EMPLEADO` | PERSON | Cargo, ruta/zona de cobranza asignada |

Un mismo `party_id` (una misma persona) puede acumular `CLIENTE` + `PRESTATARIO` sin duplicarse — y si además trabaja cobrando en BGG, suma `EMPLEADO` sin tocar su identidad ni sus otros roles.

### 9.2. Relaciones dirigidas candidatas (`party_relationship`)

| `relationship_type` | `from_role` → `to_role` | Semántica |
|---|---|---|
| `AVAL` | `GARANTE` → `PRESTATARIO` | Un cliente avala el crédito de otro; debe quedar histórico aunque el crédito se cancele. |
| `EMPLOYMENT` | `COBRADOR` → `EMPLEADOR` (BGG como `organization`) | Vigencia laboral con `start_date`/`end_date`. |
| `COBRANZA_ASIGNADA` | `COBRADOR` → `PRESTATARIO` | Qué cobrador tiene asignada la cobranza diaria de qué cliente — con vigencia, por si se reasigna la ruta. |

### 9.3. Documentos de identidad esperados (`party_identifier.id_type`)

`DNI` (personas naturales, emisor RENIEC), `RUC` (si un cliente tiene negocio propio, emisor SUNAT), opcionalmente `CE` (carné de extranjería).

### 9.4. Preguntas que faltan cerrar con la entidad real

1. ¿BGG es un caso simulado sobre un modelo real y verificable (microfinanciera/entidad de crédito informal real), o alguien del equipo tiene acceso directo a un caso similar? Define cómo se redacta la ficha de validación de Semana 1.
2. ¿Qué tipos de crédito maneja (monto fijo, línea revolvente, plazo diario vs. semanal)? — define si hace falta una tabla de detalle adicional tipo `credito_detail` colgando de `party_role_id` del `PRESTATARIO`.
3. ¿Se registran los pagos/cuotas diarias como movimientos? Eso sale del alcance de PARTY puro y entra en el modelo transaccional del negocio (tabla de pagos referenciando `party_role_id` del `PRESTATARIO`).
4. ¿Cuántas rutas/zonas de cobranza maneja BGG? — si son varias, puede valer la pena modelar la zona como entidad propia relacionada al `COBRADOR` vía `party_relationship`.

---

## 10. Estado de este entregable

Solo documentación conceptual. **No se ha generado** diagrama físico definitivo, script SQL del proyecto ni PPT — eso se hace recién cuando el caso real esté definido y el usuario lo pida explícitamente.
