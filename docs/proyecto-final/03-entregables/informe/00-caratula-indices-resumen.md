# PROYECTO FINAL: DISEÑO E IMPLEMENTACIÓN DE UNA BASE DE DATOS RELACIONAL CON PATRÓN PARTY PARA EL CONTROL DE CLIENTES, AVALES Y COBRANZA EN LA ENTIDAD DE MICROCRÉDITOS BGG

---

## Carátula Institucional

**UNIVERSIDAD PRIVADA DEL NORTE**  
**FACULTAD DE INGENIERÍA**  
**CARRERA DE INGENIERÍA DE SISTEMAS COMPUTACIONALES**

---

### Título del Proyecto:
**DISEÑO E IMPLEMENTACIÓN DE UNA BASE DE DATOS RELACIONAL BAJO EL PATRÓN DE MODELADO PARTY PARA LA GESTIÓN DE IDENTIDAD CENTRALIZADA, ROLES DINÁMICOS Y TRAZABILIDAD DE COBRANZA EN LA ENTIDAD DE MICROCRÉDITOS BGG**

---

**Curso:** Base de Datos  
**Docente:** Ing. Juan Emilio Asto Vara  
**Sede y Periodo Académico:** Cajamarca – Perú, 2026-1  

---

### Integrantes y Porcentaje de Participación:

| N° | Apellidos y Nombres | Código de Estudiante | % Participación |
|:--:|:--------------------|:--------------------:|:---------------:|
| 1 | Aquino Rivera, Oswaldo Jader | N00571142 | 25% |
| 2 | Espinoza Morales, Jose Angel | N00575318 | 25% |
| 3 | León Ccahuana, Jeffre Carlos | N00423806 | 25% |
| 4 | Ramos Guerra, Jaime Eloy | N00377672 | 25% |

---

## Estructura de Índices del Informe

> *Nota metodológica: La presente sección define la estructura formal de índices que será consolidada y paginada en la versión final Word/PDF conforme a los requerimientos de la plantilla oficial de la UPN.*

### 1. Índice de Contenido
- **Carátula Institucional**
- **Resumen y Palabras Clave**
- **Abstract and Keywords**
- **CAPÍTULO I: INTRODUCCIÓN**
  - 1.1. Motivación del Proyecto
  - 1.3. Propuestas
  - 1.4. Impactos (Social, Cultural, Político, Ambiental, Ético, Económico)
- **CAPÍTULO II: MARCO TEÓRICO**
  - 2.1. Antecedentes Teóricos
  - 2.2. Bases Teóricas
  - 2.3. Análisis del Problema (Identificación, Objetivos, Alcance)
- **CAPÍTULO III: HERRAMIENTAS DE INGENIERÍA**
  - Comparación de Metodologías y Estándares
  - Selección y Fundamentación de Hardware y Software
- **CAPÍTULO IV: GENERACIÓN DE SOLUCIONES**
  - 4.1. Alternativas de Solución y Matriz de Decisión
  - 4.2. Cronograma del Proyecto
  - 4.3. Roles y Responsabilidades
  - 4.4. Matriz de Responsabilidades Semanales
  - 4.5. Modelado del Negocio (Mapa de Procesos y Reglas de Negocio)
- **CAPÍTULO V: METODOLOGÍA DE DESARROLLO**
  - 5.1. Requerimientos del Negocio (RF, RNF, Historias de Usuario)
  - 5.2. Identificación de Stakeholders
  - 5.3. Modelo Conceptual (Entidades, Atributos, Relaciones, Cardinalidad, Limitaciones)
  - 5.4. Modelo Lógico
  - 5.5. Normalización
  - 5.6. Modelo Físico
  - 5.7. Migración al Gestor de Base de Datos (SQL Server)
  - 5.8. Políticas de Seguridad de Usuario
  - 5.9. Plan de Backups y Recuperación ante Fallos
  - 5.10. Contrastación de Requerimientos
- **CAPÍTULO VI: CONCLUSIONES Y RECOMENDACIONES**
  - 6.1. Conclusiones
  - 6.2. Recomendaciones
- **REFERENCIAS BIBLIOGRÁFICAS**
- **ANEXOS**

### 2. Índice de Tablas
- Tabla 1.1: Evaluación comparativa de propuestas de solución.
- Tabla 4.1: Matriz de evaluación cuantitativa de alternativas de solución.
- Tabla 4.2: Asignación general de roles y responsabilidades del equipo.
- Tabla 4.3 a 4.10: Matriz semanal de responsabilidades y seguimiento (Semanas 1 a 8).
- Tabla 4.11: Catálogo estructurado de reglas de negocio para BGG.
- Tabla 5.1: Matriz de requerimientos funcionales y no funcionales.
- Tabla 5.2: Matriz de caracterización de stakeholders.
- Tabla 5.3: Diccionario de datos del modelo lógico.
- Tabla 5.4: Matriz de contrastación y normalización formal (1FN, 2FN, 3FN).
- Tabla 5.5: Matriz de privilegios DCL y roles de seguridad en SQL Server.
- Tabla 5.6: Matriz de trazabilidad y contrastación de requerimientos.

### 3. Índice de Figuras
- Figura 1.1: Diagrama de análisis SEPTE del entorno operativo de BGG.
- Figura 2.1: Diagrama conceptual del patrón de modelado PARTY (Identidad, Roles y Relaciones).
- Figura 4.1: Diagrama Gantt del cronograma del proyecto (8 semanas).
- Figura 4.2: Mapa de procesos general de BGG.
- Figura 4.3: Diagrama de flujo de procesos AS-IS (Esquema disperso por rol).
- Figura 4.4: Diagrama de flujo de procesos TO-BE (Esquema centralizado con patrón PARTY).
- Figura 5.1: Diagrama Entidad-Relación Lógico TO-BE de BGG con patrón PARTY.
- Figura 5.2: Topología del plan de backups y ciclo de vida de respaldos transaccionales.

### 4. Índice de Anexos
- Anexo A: Scripts DDL y DML de creación e inicialización en Microsoft SQL Server.
- Anexo B: Consultas analíticas avanzadas, procedimientos almacenados y vistas del sistema.
- Anexo C: Instrumentos de recolección de información y formatos de campo para BGG.

---

## Resumen

El presente proyecto de ingeniería aborda el diseño e implementación de una base de datos relacional orientada a resolver las deficiencias de fragmentación de datos, redundancia e inconsistencia histórica en la entidad de microcréditos informales **BGG**, dedicada al otorgamiento y cobranza de préstamos con cuotas diarias y semanales en ruta ("gota a gota"). En el diagnóstico de la situación actual (**AS-IS**), la información operativa se gestiona mediante registros y tablas aisladas según el rol de los participantes (clientes, avales y cobradores), lo que genera duplicidad de identidades, pérdida del control sobre el riesgo acumulado en garantías cruzadas y desarticulación en la trazabilidad de las rutas de cobranza. Como solución técnica (**TO-BE**), se adopta el arquetipo de modelado **PARTY** propuesto por Len Silverston, el cual desacopla ontológicamente la identidad de los sujetos de sus roles dinámicos temporales y relaciones dirigidas. La solución fue modelada conceptual y lógicamente, normalizada rigurosamente hasta la Tercera Forma Normal (3FN) y Formulario Normal de Boyce-Codd (BCNF), e implementada en el motor relacional **Microsoft SQL Server**. Asimismo, se establecieron políticas granulares de seguridad mediante control de acceso basado en roles (RBAC) y un plan de respaldo y recuperación ante desastres que garantiza la continuidad operativa y la auditoría íntegra de las transacciones crediticias.

**Palabras clave:** Patrón PARTY, Base de datos relacional, Microcréditos, SQL Server, Trazabilidad histórica.

---

## Abstract

This engineering project addresses the design and implementation of a relational database aimed at solving data fragmentation, redundancy, and historical inconsistency issues within **BGG**, an informal microcredit enterprise operating daily and weekly route-based lending ("gota a gota"). Under the current diagnostic baseline (**AS-IS**), operational data is managed across isolated spreadsheets and role-specific records (separate logs for clients, guarantors, and collectors), leading to identity duplication, lack of visibility over accumulated risk in cross-guarantees, and broken traceability across collection routes. As an engineered solution (**TO-BE**), the system implements Len Silverston’s **PARTY** data modeling pattern, which decouples core entity identity from dynamic business roles and directed temporal relationships. The system was conceptually and logically modeled, strictly normalized up to Third Normal Form (3NF) and Boyce-Codd Normal Form (BCNF), and deployed on **Microsoft SQL Server**. Furthermore, granular role-based access control (RBAC) security policies and an enterprise backup and disaster recovery plan were developed to ensure operational continuity and complete transactional auditability.

**Keywords:** PARTY pattern, Relational database, Microcredits, SQL Server, Historical traceability.
