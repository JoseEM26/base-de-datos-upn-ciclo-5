# Contenido de la Presentación (PPT) — Proyecto Final de Base de Datos

> **Caso:** BGG (Microcréditos "Gota a Gota")  
> **Universidad:** Universidad Privada del Norte (UPN) — Sede Cajamarca 2026-1  
> **Curso:** Base de Datos  
> **Docente:** Juan Emilio Asto Vara  
> **Estructura:** 14 Diapositivas según lineamientos oficiales UPN

---

## Diapositiva 1: Carátula Institucional

- **Encabezado Visual:**
  - Logos institucionales: Universidad Privada del Norte (UPN) y Facultad de Ingeniería.
  - Franja decorativa superior/inferior en paleta institucional (dorado/azul oscuro).
  - **Badges Destacados:** `[Caso Real: BGG]` | `[Patrón PARTY (Silverston)]` | `[SGBD: SQL Server]` | `[Ciclo 2026-1]`
- **Título del Proyecto:** Diseño e Implementación de una Base de Datos Relacional para la Gestión de Microcréditos y Cobranza en Ruta (Caso BGG) aplicando el Patrón PARTY en SQL Server
- **Carrera y Curso:** Ingeniería de Sistemas Computacionales | Base de Datos
- **Docente:** Juan Emilio Asto Vara
- **Integrantes (% de Participación Equitativa):**
  - Aquino Rivera, Oswaldo Jader (25%)
  - Espinoza Morales, Jose Angel (25%)
  - León Ccahuana, Jeffre Carlos (25%)
  - Ramos Guerra, Jaime Eloy (25%)
- **Enfoque Metodológico:** Diagnóstico AS-IS (Relacional Convencional) vs. Solución TO-BE (Patrón PARTY)

---

## Diapositiva 2: Presentación del Caso Real BGG

- **Modelo de Negocio:** Entidad de microcréditos con esquema de préstamos rápidos y cobranza diaria/semanal en ruta ("gota a gota").
- **Contexto Operativo:** Asignación dinámica de cobradores por zonas comerciales, múltiples préstamos en paralelo y requerimiento de avales/garantes solidarios.
- **Relevancia y Fuentes Verificables del Fenómeno:**
  - **Instituto Peruano de Economía (IPE):** El crédito informal "gota a gota" creció del 22% (2022) al 35% (2024), alcanzando a ~211,000 familias con tasas anualizadas superiores al 1,400%.
  - **Superintendencia de Banca, Seguros y AFP (SBS):** Fiscalización activa sobre más de 18 aplicaciones y esquemas informales de préstamo.
  - **Código Penal Peruano (2023):** Tipificación explícita de delitos vinculados a usura extorsiva y cobro coactivo.

---

## Diapositiva 3: Problemática Identificada (Diagnóstico AS-IS)

[IMAGEN: problematica_bgg.png — infografía de la problemática del préstamo gota a gota con cifras clave (IPE 35%, tasas >1400%, etc.) y el problema de identidad duplicada]

- **Fragmentación por Roles:** Tablas aisladas (`Clientes`, `Avales`, `Cobradores`) con columnas redundantes.
- **Duplicación Crítica:** Una misma persona reingresada múltiples veces si actúa a la vez como cliente y aval.
- **Inconsistencia de Datos:** Teléfonos y domicilios desactualizados en una tabla mientras permanecen obsoletos en otra.
- **Amnesia Histórica:** Cero trazabilidad temporal en asignación de rutas y cambios de avales.
- **Riesgo Crediticio Oculto:** Incapacidad de detectar avales sobrecomprometidos o garantías cruzadas.

---

## Diapositiva 4: Análisis del Entorno (Diagrama SEPTE)

[IMAGEN: septe_bgg.png — diagrama infográfico del análisis SEPTE aplicado al entorno de microcréditos BGG]

- **Social:** Alta vulnerabilidad financiera e informalidad crediticia en microcomerciantes.
- **Económico:** Tasas de interés >1,400% anual; necesidad crítica de control de mora y saldos diarios.
- **Político/Legal:** Tipificación de usura extorsiva (Código Penal 2023) y supervisión SBS.
- **Tecnológico:** Manejo informal en cuadernos/hojas de cálculo sin SGBD transaccional centralizado.
- **Ecológico:** Digitalización para eliminar el uso masivo de fichas de cobranza y pagarés físicos.

---

## Diapositiva 5: Objetivos del Proyecto

- **Objetivo General:**
  - Diseñar e implementar una base de datos relacional en SQL Server bajo el patrón PARTY para el caso BGG, unificando la identidad de personas y organizaciones para eliminar redundancias y habilitar trazabilidad histórica frente al modelo AS-IS.

- **Objetivos Directos (Técnicos / Patrón PARTY en SGBD):**
  - **OD1:** Modelar la identidad desacoplada (`PARTY`, `PERSON`, `ORGANIZATION`) y mecanismos de contacto en 3FN/BCNF.
  - **OD2:** Implementar relaciones temporales dirigidas (`PARTY_RELATIONSHIP`) para control histórico de avales y cobradores.
  - **OD3:** Construir el esquema financiero transaccional para desembolsos, cuotas y liquidación diaria de cobranza.
  - **OD4:** Configurar seguridad basada en roles (DCL) y política de contingencia mediante copias de seguridad en SQL Server.

- **Objetivos Indirectos (Impacto en Gestión de Negocio):**
  - **OI1:** Mitigar el riesgo crediticio identificando concentración y sobreendeudamiento de avales en tiempo real.
  - **OI2:** Garantizar auditoría y trazabilidad histórica completa ante fiscalizaciones regulatorias (SBS / Ley).
  - **OI3:** Optimizar la operatividad en ruta evitando errores de cobro por datos desactualizados.

---

## Diapositiva 6: Modelado del Negocio: Modelo de Datos AS-IS vs. TO-BE

[IMAGEN: as_is_vs_to_be.png — comparación visual de tablas duplicadas (AS-IS) vs modelo PARTY unificado (TO-BE)]

- **Modelo AS-IS (Relacional Convencional / Patologías):**
  - Tablas separadas por rol: `CLIENTES`, `AVALES`, `COBRADORES`.
  - Columnas redundantes de contacto y documento en cada tabla (`nombres`, `dni`, `telefono`, `direccion`).
  - Imposibilidad de registrar cambio o coexistencia de roles sin duplicar registros; sin historial temporal.
  - Anomalías severas de inserción, actualización y borrado.
- **Modelo TO-BE (Patrón PARTY Unificado):**
  - Identidad centralizada única (`PARTY`) independiente de las funciones que desempeñe.
  - Roles (`PARTY_ROLE`) asignados dinámicamente con vigencia temporal (`start_date`, `end_date`).
  - Contactos e identificadores asociados a la identidad ontológica, no al rol.
  - Cero redundancia y trazabilidad completa de relaciones crediticias y de cobranza.

---

## Diapositiva 7: Fundamento del Patrón de Modelado PARTY

- **Referencia Académica:** Silverston, Len (2001). *The Data Model Resource Book (Vol. 1)*.
- **Separación de Responsabilidades en Tres Preguntas:**
  - **1. ¿Quién existe? (Identidad Ontológica):** `PARTY`, `PERSON`, `ORGANIZATION` (inmutables, con ID subrogado).
  - **2. ¿Qué función ejerce? (Rol de Negocio):** `PARTY_ROLE` (`PRESTATARIO`, `AVAL`, `COBRADOR`) con vigencia temporal.
  - **3. ¿Con quién se relaciona? (Vínculo Dirigido):** `PARTY_RELATIONSHIP` (vínculos fechados: avala a, cobra a).

[IMAGEN: patron_party_fundamento.png — diagrama conceptual del patrón PARTY: hub central con personas, organizaciones, roles y relaciones]

---

## Diapositiva 8: Modelo Conceptual y Lógico TO-BE

[IMAGEN: er_bgg.png — diagrama entidad-relación (ERD) completo del modelo TO-BE con patrón PARTY y módulo financiero]

- **Núcleo de Identidad:** `PARTY` generaliza a `PERSON` y `ORGANIZATION` mediante subtipado 1:1 exclusivo.
- **Mecanismos y Documentos:** `PARTY_IDENTIFIER` (DNI, RUC, CE) y `CONTACT_MECHANISM` desacoplados con cardinalidad 1:N.
- **Roles y Redes:** `PARTY_ROLE` tipifica el rol; `PARTY_RELATIONSHIP` mapea vínculos temporales dirigidos entre partes.
- **Módulo Financiero:** `PRESTATARIO_DETAIL` extiende el rol para asociar `CREDITO` y transacciones de `PAGO`.

---

## Diapositiva 9: Modelo Físico y Decisiones de Normalización

- **Comparativa de Normalización:**
  - **AS-IS (No normalizado / 1FN deficiente):** Tablas planas por rol con columnas `NULL` masivas, atributos multivalor de teléfonos y documentos como PK frágiles.
  - **TO-BE (Tercera Forma Normal / 3FN y BCNF):**
    - **1FN:** Claves primarias subrogadas (`BIGINT`), atributos atómicos y teléfonos desacoplados en `CONTACT_MECHANISM`.
    - **2FN:** Dependencia funcional completa hacia la PK; separación de atributos biológicos (`PERSON`) y jurídicos (`ORGANIZATION`).
    - **3FN / BCNF:** Eliminación total de dependencias transitivas; los roles y estados financieros no contaminan la identidad raíz.

---

## Diapositiva 10: Despliegue en SQL Server y Restricciones Técnicas

- **Tipos de Datos y Precisión:** Claves `BIGINT` para escalabilidad masiva, montos monetarios en `DECIMAL(12,2)` y fechas normalizadas en `DATE`/`DATETIME`.
- **Integridad Referencial y Restricciones (Constraints):**
  - **Integridad de Herencia (1:1):** `PERSON.party_id` y `ORGANIZATION.party_id` como PK y FK simultánea hacia `PARTY.party_id`.
  - **Unicidad Documentaria:** `UNIQUE (id_type, id_value)` en `PARTY_IDENTIFIER` para evitar duplicidad de DNI/RUC.
  - **Validación Antirrecursiva en Grafo:** `CHECK (from_party_id <> to_party_id)` en `PARTY_RELATIONSHIP`.
  - **Control de Dominio:** `CHECK (party_type IN ('PERSON', 'ORGANIZATION'))` y estados en valores controlados (`VIGENTE`, `CANCELADO`, `MOROSO`).

---

## Diapositiva 11: Políticas de Seguridad y Control de Acceso

- **Desacoplamiento Conceptual:** Los roles de negocio (`PARTY_ROLE`) son independientes de las cuentas de seguridad del SGBD.
- **Roles y Privilegios en SQL Server (DCL):**
  - **`rol_cajero_cobrador`:** Permisos de `INSERT` sobre `PAGO` y `SELECT` restringido sobre `CREDITO` y contactos asignados.
  - **`rol_analista_creditos`:** Permisos de `INSERT`/`UPDATE` sobre `CREDITO`, `PRESTATARIO_DETAIL` y `PARTY_RELATIONSHIP`.
  - **`rol_auditor_cumplimiento`:** Permisos de solo lectura (`SELECT`) sobre historial temporal (`start_date`, `end_date`) y auditoría.
  - **`rol_administrador_bd`:** Control DDL/DCL total sin acceso a credenciales de usuarios finales.

---

## Diapositiva 12: Plan de Backups y Recuperación ante Fallos

- **Estrategia de Respaldos (Regla 3-2-1):**
  - **Backup Completo (Full):** Ejecución semanal programada (domingos a las 00:00 hrs) para captura integral de la base de datos.
  - **Backup Diferencial:** Ejecución diaria de lunes a sábado (23:00 hrs) capturando solo cambios desde el último Full.
  - **Backup de Log de Transacciones:** Ejecución periódica cada 1 hora en horario operativo (07:00 a 20:00 hrs) bajo Recovery Model `FULL`.
- **Métricas de Continuidad:**
  - **RPO (Punto Objetivo de Recuperación):** Menor a 1 hora de pérdida potencial de datos ante desastre.
  - **RTO (Tiempo Objetivo de Recuperación):** Restauración completa operativa en menos de 30 minutos mediante validación automática (`RESTORE VERIFYONLY`).

---

## Diapositiva 13: Demostración de Resultados: Consultas Clave en Vivo

- **Evidencia 1: Identidad Única Multi-Rol:**
  - Consulta `JOIN` que demuestra cómo un mismo `party_id` opera simultáneamente como Prestatario y Aval con un único registro de identidad.
- **Evidencia 2: Detección de Riesgo en Red de Avales:**
  - Consulta con auto-unión (`INNER JOIN` sobre `PARTY_RELATIONSHIP`) que revela avales sobrecomprometidos en múltiples créditos vigentes.
- **Evidencia 3: Liquidación Diaria de Cobranza en Ruta:**
  - Consulta agrupada (`SUM`, `COUNT`) por cobrador (`party_role_id`) en fecha actual cruzando `PAGO`, `CREDITO` y `PERSON`.

---

## Diapositiva 14: Conclusiones y Recomendaciones

- **Conclusiones:**
  - **Eliminación de Redundancia:** El patrón PARTY erradicó duplicados de identidad y anomalías de actualización presentes en el modelo AS-IS.
  - **Integridad ACID:** El motor SQL Server garantiza consistencia transaccional estricta en cobros diarios y desembolsos.
  - **Flexibilidad de Dominio:** `PARTY_RELATIONSHIP` modela redes complejas de avales y cobradores sin alterar el esquema físico.
- **Recomendaciones:**
  - Implementar vistas indexadas (`Indexed Views`) para acelerar la liquidación diaria de cobradores en ruta.
  - Añadir triggers para impedir solapamiento de rangos de fechas (`start_date`, `end_date`) en roles y asignaciones.
  - Automatizar la copia de respaldos a almacenamiento fuera de sitio para cumplimiento de continuidad del negocio.
