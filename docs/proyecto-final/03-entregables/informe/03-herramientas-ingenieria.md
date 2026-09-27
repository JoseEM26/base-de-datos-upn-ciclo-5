# CAPÍTULO III: HERRAMIENTAS DE INGENIERÍA

## 3.1. COMPARACIÓN Y SELECCIÓN JUSTIFICADA DE METODOLOGÍAS Y ESTÁNDARES DE INGENIERÍA

Para el desarrollo del proyecto de ingeniería de datos para la entidad de microcréditos **BGG**, se evaluaron tres marcos metodológicos aplicables al ciclo de vida del software y de las bases de datos:

| Criterio de Comparación | Modelo en Cascada (Waterfall) | Marco Ágil Scrum | Metodología de Diseño de BD (Connolly & Begg) |
|:---|:---|:---|:---|
| **Enfoque Principal** | Secuencial y lineal por fases estrictas. | Iterativo e incremental orientado a sprints de software. | Específico y centrado en la ingeniería y ciclo de vida de bases de datos. |
| **Adaptabilidad a Cambios** | Muy baja; los cambios en fases tardías son costosos. | Alta; redefinición continua del backlog. | Media-Alta; iteración conceptual, lógica y física guiada por reglas de negocio. |
| **Rigor en Modelado de Datos** | Genérico; trata los datos como un artefacto secundario. | Débil; prioriza código ejecutable sobre modelos formales. | **Excelente; etapas formales de modelado conceptual, lógico, normalización y físico.** |
| **Manejo de Transacciones y Seguridad** | Tardío; se define en fase de implementación. | Fragmentado; se aborda según historias de usuario. | **Integral; seguridad, backups y restricciones ACID embebidas desde el diseño.** |
| **Adecuación al Módulo de 8 Semanas** | Inflexible para revisiones continuas. | Requiere un equipo multidisciplinario maduro. | **Óptima; permite avanzar en paralelo la normalización y la migración al SGBD.** |

### Justificación Metodológica
El equipo seleccionó la **Metodología de Ciclo de Vida de Base de Datos propuesta por Thomas Connolly y Carolyn Begg (2014)**, complementada con prácticas ágiles de entrega continua en sprints semanales. Esta metodología proporciona una estructura formal rigurosamente alineada a los objetivos del curso y a los requerimientos de la plantilla UPN:
1. **Planificación y Definición del Sistema:** Delimitación de las fronteras de BGG y de los usuarios del sistema.
2. **Recolección y Análisis de Requisitos:** Captura de requerimientos funcionales, no funcionales y reglas de negocio del esquema crediticio "gota a gota".
3. **Diseño de la Base de Datos:**
   - *Diseño Conceptual:* Creación del modelo entidad-relación adoptando el patrón PARTY.
   - *Diseño Lógico:* Transformación al esquema relacional, definición de claves foráneas y normalización formal (1FN a BCNF).
   - *Diseño Físico:* Asignación de tipos de datos de SQL Server, creación de índices agrupados y no agrupados, y optimización de almacenamiento.
4. **Selección del SGBD e Implementación:** Despliegue de scripts DDL y DML en Microsoft SQL Server.
5. **Seguridad y Plan de Contingencia:** Configuración de roles de base de datos y automatización de copias de seguridad.

---

## 3.2. SELECCIÓN Y FUNDAMENTACIÓN DE HERRAMIENTAS DE HARDWARE Y SOFTWARE

### 3.2.1. Justificación del Sistema Gestor de Base de Datos (SGBD)
Se seleccionó **Microsoft SQL Server (versión Developer / Standard)** como el motor de base de datos relacional para el proyecto, fundamentado en los siguientes pilares técnicos:
- **Cumplimiento Transaccional ACID Estricto:** La naturaleza financiera de BGG (colocación de microcréditos, recaudación diaria de cuotas y liquidación de cobradores) exige garantías absolutas de consistencia. El motor de almacenamiento relacional de SQL Server asegura que ninguna operación quede en estado inconsistente.
- **Potencia y Expresividad de Transact-SQL (T-SQL):** Permite implementar procedimientos almacenados transaccionales (`BEGIN TRANSACTION`, `TRY...CATCH`, `SAVE TRANSACTION`), funciones definidas por el usuario (UDFs) y triggers para auditar mutaciones en la tabla `PARTY_RELATIONSHIP`.
- **Soporte Nativo para Copias de Seguridad Granulares:** Dispone de un motor avanzado de copias de seguridad que permite alternar respaldos completos (*Full Backup*), diferenciales (*Differential Backup*) y del registro de transacciones (*Transaction Log Backup*), facilitando la restauración puntual en el tiempo (*Point-in-Time Recovery*).
- **Seguridad Empresarial Basada en Roles (RBAC):** Permite la separación nítida entre credenciales del servidor (`LOGINS`), usuarios de base de datos (`USERS`) y roles de aplicación (`ROLES`), asignando permisos DCL específicos (`GRANT`, `DENY`, `REVOKE`) para impedir accesos no autorizados a datos personales y financieros.

### 3.2.2. Ecosistema de Software y Herramientas de Desarrollo

| Categoría | Herramienta Seleccionada | Justificación Técnica |
|:---|:---|:---|
| **SGBD Relacional** | **Microsoft SQL Server 2022** | Motor de base de datos relacional robusto con soporte nativo ACID, optimizador de consultas avanzado y alta compatibilidad empresarial. |
| **Cliente de Administración** | **SQL Server Management Studio (SSMS) v19 / v20** | Entorno integrado para la ejecución de scripts T-SQL, visualización del plan de ejecución de consultas, gestión de índices y monitoreo del log de transacciones. |
| **Editor de Código y Versionado** | **Visual Studio Code + Git / GitHub** | Entorno ligero para la redacción de scripts SQL, documentación en Markdown y control de versiones distribuido del repositorio de trabajo. |
| **Herramienta de Modelado CASE** | **Mermaid.js + Draw.io** | Generación de diagramas declarativos de alta fidelidad para modelos entidad-relación, grafos conceptuales SEPTE y mapas de procesos de negocio. |

### 3.2.3. Especificaciones de Infraestructura de Hardware

Para garantizar un rendimiento óptimo tanto en el entorno de desarrollo como en el escenario de despliegue y sustentación, se definen los siguientes parámetros de hardware:

#### Servidor de Base de Datos (Entorno de Producción / Demostración)
- **Procesador:** CPU x86-64 de 4 núcleos a 2.5 GHz o superior (Intel Core i5 / AMD Ryzen 5 o equivalente).
- **Memoria RAM:** Mínimo 8 GB (Recomendado 16 GB DDR4/DDR5 para asignación de *Buffer Pool* en SQL Server).
- **Almacenamiento:** Unidad de Estado Sólido (SSD NVMe / SATA III) con al menos 50 GB de espacio libre, separando idealmente los archivos de datos (`.mdf`) de los registros de transacciones (`.ldf`) para optimizar el rendimiento de I/O.
- **Sistema Operativo:** Windows 10/11 Pro de 64 bits o Windows Server 2022 / Linux (Ubuntu Server con contenedor Docker de SQL Server).

#### Estación de Trabajo de Desarrollo
- **Procesador:** CPU de 2 núcleos o superior.
- **Memoria RAM:** Mínimo 8 GB.
- **Almacenamiento:** 20 GB de espacio disponible para herramientas cliente (SSMS, VS Code y documentación técnica).
