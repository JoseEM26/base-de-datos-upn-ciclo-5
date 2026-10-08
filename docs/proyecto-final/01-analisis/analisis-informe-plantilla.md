# Análisis Exhaustivo de la Plantilla Oficial del Informe Final

> **Curso:** Base de Datos  
> **Carrera:** Ingeniería de Sistemas Computacionales – UPN  
> **Periodo:** 2026-1 (Sede San Juan de Lurigancho – Perú)  
> **Archivo analizado:** `informe_plantilla_extraido.txt` (origen: `2026-1_ISC-Informe_Proyecto Final_Base de Datos.docx`)

---

## 1. Resumen Ejecutivo

El presente documento constituye el análisis estructural, técnico y metodológico de la plantilla oficial en formato Word (`.docx`) provista para el desarrollo del Informe del Proyecto Final del curso de Base de Datos en la Universidad Privada del Norte (UPN).

La plantilla establece un esquema formal y riguroso de ingeniería de software y bases de datos compuesto por **6 capítulos principales**, secciones preliminares (carátula con porcentaje de participación, 4 índices, resumen y abstract bilingües) y secciones finales (referencias en formato APA y anexos). A lo largo de sus secciones, el informe exige desde la justificación multidimensional del proyecto (social, cultural, política, ambiental, ética y económica) hasta el ciclo completo de diseño de datos (modelado conceptual, lógico, normalización, modelo físico, migración al SGBD, seguridad, planes de contingencia y contrastación de requerimientos).

El análisis identifica además discrepancias críticas de diseño editorial y de planificación temporal dentro de la plantilla (como el desglose de 16 semanas frente al formato modular de 8 semanas, saltos de numeración y discrepancias entre la tabla de contenidos y el cuerpo del documento), las cuales se detallan para su oportuna aclaración y mitigación.

---

## 2. Estructura Obligatoria del Informe (Capítulo por Capítulo)

A continuación se detalla la jerarquía y nomenclatura exacta de las secciones y subsecciones que componen la plantilla:

### Estructura Preliminar
- **Carátula Institucional:**
  - Encabezado institucional: *Facultad de Ingeniería – Carrera de Ingeniería de Sistemas Computacionales*.
  - `<<TÍTULO DEL PROYECTO>>`.
  - Autores: Apellidos y nombres en orden alfabético con porcentaje explícito de participación (`% participación`).
  - Curso: *Base de Datos*.
  - Docente: Apellidos y nombre.
  - Sede y periodo: *Cajamarca – Perú, 2026-1*.
- **Índices:**
  - Índice de Contenido (TOC con niveles 1-3).
  - Índice de Tablas.
  - Índice de Figuras.
  - Índice de Anexos.
- **Resumen:**
  - Texto descriptivo del trabajo realizado.
  - Palabras clave: Exactamente 05 palabras clave.
- **Abstract:**
  - Traducción completa del resumen al inglés.
  - Keywords: Traducción de las palabras clave al inglés.

---

### Capítulos Principales

```
├── CAPÍTULO I: INTRODUCCIÓN
│   ├── 1.1. MOTIVACIÓN DEL PROYECTO
│   ├── 1.3. PROPUESTAS (Nota: Salto de numeración en plantilla original)
│   └── 1.4. IMPACTOS
│       ├── 1.4.1. Impacto social
│       ├── 1.4.2. Impacto cultural
│       ├── 1.4.3. Impacto político
│       ├── 1.4.4. Impacto ambiental
│       ├── 1.4.5. Impacto ético
│       └── 1.4.6. Impacto económico
│
├── CAPÍTULO II: MARCO TEÓRICO
│   ├── 2.1. ANTECEDENTES TEÓRICOS
│   ├── 2.2. BASES TEÓRICAS
│   └── 2.3. ANÁLISIS DEL PROBLEMA
│       ├── 2.3.1. IDENTIFICACIÓN Y FORMULACIÓN DEL PROBLEMA
│       ├── 2.3.2. DEFINICIÓN DE OBJETIVOS (General y Específicos)
│       └── 2.3.3. ALCANCE DE LA SOLUCIÓN
│
├── CAPÍTULO III: HERRAMIENTAS DE INGENIERÍA
│   ├── [Comparación y selección justificada de metodologías/marcos y estándares de ingeniería]
│   └── [Selección y fundamentación de herramientas de hardware y software]
│
├── CAPÍTULO IV: GENERACIÓN DE SOLUCIONES
│   ├── 4.1. ALTERNATIVAS DE SOLUCIÓN
│   ├── 4.2. CRONOGRAMA DEL PROYECTO
│   ├── 4.3. ROLES Y RESPONSABILIDADES EN EL PROYECTO
│   ├── 4.4. MATRIZ DE RESPONSABILIDADES (Semanas 01 a 16)
│   └── 4.5. MODELADO DEL NEGOCIO
│
├── CAPÍTULO V: METODOLOGÍA DE DESARROLLO
│   ├── 5.1. REQUERIMIENTOS DEL NEGOCIO
│   ├── 5.2. IDENTIFICACIÓN DE STAKEHOLDERS
│   ├── 5.3. MODELO CONCEPTUAL
│   │   ├── 5.3.1. Identificación de entidades
│   │   ├── 5.3.2. Identificación de atributos
│   │   ├── 5.3.3. Identificación de relaciones
│   │   ├── 5.5.4. Identificación de cardinalidad (Tipografía en plantilla: 5.5.4)
│   │   └── 5.3.5. Limitaciones
│   ├── 5.4. MODELO LÓGICO
│   ├── 5.5. NORMALIZACIÓN
│   ├── 5.6. MODELO FÍSICO
│   ├── 5.7. MIGRACIÓN AL GESTOR DE BASE DE DATOS
│   ├── 5.8. POLÍTICAS DE SEGURIDAD DE USUARIO
│   ├── 5.9. PLAN DE BACKUPS Y RECUPERACIÓN DE FALLOS
│   └── 5.10. CONTRASTACIÓN DE REQUERIMIENTOS
│
├── CAPÍTULO VI: CONCLUSIONES Y RECOMENDACIONES
│   ├── 6.1. CONCLUSIONES
│   └── 6.2. RECOMENDACIONES
│
├── REFERENCIAS BIBLIOGRÁFICAS (Normas APA)
└── ANEXOS
```

---

## 3. Lógica de Negocio y Decisiones Técnicas Exigidas por Capítulo

Cada capítulo del informe demanda evidencias formales de toma de decisiones y rigor técnico de ingeniería:

### Capítulo I: Introducción
- **Motivación:** Explicar el origen y justificación de abordar la problemática seleccionada.
- **Evaluación de Propuestas:** Obliga a presentar un **mínimo de 3 propuestas de solución** conceptualmente relacionadas con la problemática antes de haber elegido la definitiva. Cada propuesta debe desglosarse con:
  - Nombre / Título de la propuesta.
  - Descripción detallada.
  - Ventajas operativas y técnicas.
  - Desventajas / limitaciones.
- **Evaluación de Impactos en 6 Dimensiones:** Análisis explícito y fundamentado de cómo el proyecto afecta el contexto en:
  1. *Impacto Social* (beneficiarios directos/indirectos, comunidad).
  2. *Impacto Cultural* (hábitos, adopción tecnológica, contexto local).
  3. *Impacto Político* (cumplimiento de normativas, gobernanza, políticas institucionales).
  4. *Impacto Ambiental* (reducción del uso de papel, huella energética de servidores).
  5. *Impacto Ético* (privacidad de la información, protección de datos sensibles, transparencia).
  6. *Impacto Económico* (reducción de costos operativos, retorno de inversión, viabilidad financiera).

### Capítulo II: Marco Teórico
- **Antecedentes Teóricos:** Exige un **mínimo de 5 antecedentes** (tesis, artículos científicos, proyectos o investigaciones previas) citados y parafraseados rigurosamente bajo estilo APA. Cada antecedente debe explicitar: autor, año, objetivo del estudio, metodología/marco aplicado y resultados cuantitativos o cualitativos alcanzados.
- **Bases Teóricas:** Sustento conceptual de la ingeniería de datos, modelamiento relacional, gestión transaccional y tecnologías empleadas.
- **Análisis del Problema:**
  - *Identificación y formulación:* Diagnóstico de la situación actual y delimitación del campo de acción.
  - *Objetivos:* Formulación clara de 1 Objetivo General y Objetivos Específicos alineados a las fases de ingeniería.
  - *Alcance:* Delimitación de fronteras del sistema, explicitando de forma mandataria las **posturas o funcionalidades no soportadas por la propuesta**.

### Capítulo III: Herramientas de Ingeniería
- **Cuadro comparativo y justificación metodológica:** Comparar metodologías de desarrollo de software / bases de datos o marcos de trabajo (ej. Cascada, Scrum, Metodología de Diseño de BD de Connolly/Begg) y estándares de ingeniería aplicables.
- **Selección de Hardware y Software:** Justificación técnica de la infraestructura computacional, sistema operativo, motor de base de datos (SGBD relacional), herramientas CASE de modelado y entornos de ejecución.

### Capítulo IV: Generación de Soluciones
- **Matriz de Alternativas de Solución:** Tabla comparativa cuantitativa (escala 0 a 10, donde 0 es menos factible y 10 más factible) evaluando las 3 propuestas frente a criterios de selección como: *Costos*, *Recopilación de información*, *Conocimiento en el tema*, *Tiempo de desarrollo*, *Recursos disponibles*, totalizando y sustentando la elección final mediante evaluación de pros y contras.
- **Cronograma del Proyecto:** Diagrama Gantt estructurado que detalle las actividades y fases del ciclo de vida del proyecto.
- **Roles y Responsabilidades:** Asignación explícita de funciones dentro del equipo de trabajo con supervisión de cumplimiento y observaciones de desempeño.
- **Matriz de Responsabilidades Semanales:** Desglose detallado de tareas asignadas por estudiante con seguimiento de estado de cumplimiento (`Cumplió` / `No cumplió`) para cada semana (la plantilla abarca de la Semana 01 a la 16).
- **Modelado del Negocio:** Elaboración del Mapa de Procesos institucional/empresarial, diagramación formal de los procesos que abarca el proyecto y definición exhaustiva de las **Reglas del Negocio** que gobernarán las restricciones en la base de datos.

### Capítulo V: Metodología de Desarrollo
- **Levantamiento de Requerimientos:** Requerimientos funcionales (RF) y no funcionales (RNF), especificación de historias de usuario o plantillas de casos de uso, e inclusión de evidencias/cuestionarios aplicados al cliente/stakeholders.
- **Identificación de Stakeholders:** Matriz o lista detallada de actores interesados y su nivel de impacto/relación con el sistema.
- **Modelado de Datos Integral:**
  - *Modelo Conceptual:* Identificación formal de entidades, atributos (claves primarias, candidatos), relaciones, cardinalidades y limitaciones del dominio.
  - *Modelo Lógico:* Esquema entidad-relación detallado con tipos de datos genéricos y claves foráneas.
  - *Normalización:* Aplicación rigurosa de las formas normales (1FN, 2FN, 3FN / BCNF) demostrando la eliminación de redundancias y dependencias anómalas.
  - *Modelo Físico:* Esquema DDL optimizado para el SGBD objetivo (tablas, constraints, índices, tipos de datos específicos).
- **Migración al SGBD:** Evidencia de despliegue y creación física de la estructura de base de datos en el gestor seleccionado.
- **Políticas de Seguridad:** Definición de roles, esquemas de privilegios/permisos granulares (DCL - `GRANT`/`REVOKE`) y su correspondencia con los usuarios de la base de datos.
- **Plan de Backups y Recuperación de Fallos:** Documento y estrategia técnica de respaldos (completos, diferenciales, transaccionales), políticas de retención, escenarios de contingencia y planes de restauración probados.
- **Contrastación de Requerimientos:** Matriz de trazabilidad que cruza los requerimientos documentados del proyecto contra los responsables y su estado final de implementación (`COMPLETADO`, `NO COMPLETADO`, `NO ABORDADO`).

### Capítulo VI: Conclusiones y Recomendaciones
- **Conclusiones:** Deducciones técnicas basadas en los objetivos cumplidos, el modelo de datos implementado y las métricas del proyecto.
- **Recomendaciones:** Pautas técnicas para escalabilidad futura, optimización de consultas, mantenimiento del SGBD y fases posteriores de integración.

---

## 4. Inventario de Tablas y Artefactos Exigidos

Para completar el informe de forma integral, el equipo debe producir obligatoriamente los siguientes artefactos documentales, esquemas y tablas:

| N° | Artefacto / Tabla | Sección | Descripción y Contenido Requerido |
|---|---|---|---|
| 1 | **Tabla de Autores y Participación** | Carátula | Lista alfabética de integrantes del equipo con su respectivo `% participación`. |
| 2 | **Fichas de Propuestas Preliminares (x3)** | 1.3 | Estructuras individuales con Título, Descripción, Ventajas y Desventajas para 3 alternativas iniciales. |
| 3 | **Fichas de Antecedentes (x5)** | 2.1 | Mínimo 5 síntesis de investigaciones previas en formato APA (Autor, Año, Objetivo, Metodología, Resultados). |
| 4 | **Matriz Comparativa de Metodologías y Herramientas** | Cap. III | Cuadros de justificación técnica y estándares de ingeniería adoptados. |
| 5 | **Matriz de Evaluación de Alternativas de Solución** | 4.1 | Tabla de puntuación (0 a 10) cruzando criterios (Costos, Información, Conocimiento, Tiempo, Recursos) vs Propuestas 1, 2 y 3 con puntaje total acumulado. |
| 6 | **Diagrama Gantt del Proyecto** | 4.2 | Cronograma gráfico de fases y actividades planificadas para el desarrollo. |
| 7 | **Tabla de Roles y Responsabilidades** | 4.3 | Columnas: `ROL`, `NOMBRES`, `RESPONSABILIDADES`, `ESTADO (Cumplió/No cumplió)`, `OBSERVACIONES`. |
| 8 | **Matriz de Responsabilidades por Semana (16 tablas)** | 4.4 | Tablas semanales (Semana 01 a 16) con columnas: `Estudiante (01-05)`, `RESPONSABILIDADES`, `ESTADO`. |
| 9 | **Mapa de Procesos y Diagrama de Procesos** | 4.5 | Diagramas gráficos de la arquitectura de procesos y flujos de negocio del proyecto. |
| 10 | **Catálogo de Reglas del Negocio** | 4.5 | Listado estructurado de restricciones, validaciones y reglas operativas de la organización. |
| 11 | **Matriz de Requerimientos del Negocio (RF y RNF)** | 5.1 | Especificación de requisitos funcionales y no funcionales, historias de usuario o plantillas de casos de uso. |
| 12 | **Instrumentos de Recolección de Datos** | 5.1 | Cuestionarios, guías de entrevista o encuestas aplicadas a los clientes/usuarios. |
| 13 | **Matriz de Stakeholders** | 5.2 | Tabla de identificación de interesados, roles organizacionales, impacto y grado de relación con el sistema. |
| 14 | **Diagrama del Modelo Conceptual de Datos** | 5.3 | Esquema entidad-relación conceptual con entidades, atributos, relaciones y cardinalidades. |
| 15 | **Diagrama del Modelo Lógico de Datos** | 5.4 | Diagrama entidad-relación lógico normalizado con definición de claves primarias y foráneas. |
| 16 | **Documentación de la Normalización** | 5.5 | Registro paso a paso del proceso de normalización aplicando 1FN, 2FN y 3FN sobre los esquemas. |
| 17 | **Diagrama y Scripts del Modelo Físico** | 5.6 | Diagrama físico relacional y scripts DDL de creación de tablas, índices y constraints en el SGBD. |
| 18 | **Evidencia de Migración al SGBD** | 5.7 | Capturas y verificación de la ejecución de scripts y base de datos operativa en el gestor. |
| 19 | **Matriz de Políticas de Seguridad y Privilegios** | 5.8 | Tabla cruzando roles del sistema, permisos DCL (`SELECT`, `INSERT`, `UPDATE`, etc.) y cuentas de usuario en el SGBD. |
| 20 | **Documento del Plan de Backups y Recuperación** | 5.9 | Documento técnico formal de procedimientos de respaldo, periodicidad, scripts y protocolos de restauración ante desastres. |
| 21 | **Tabla de Contrastación de Requerimientos** | 5.10 | Columnas: `Responsable`, `REQUERIMIENTOS DE PROYECTO`, `ESTADO` (`COMPLETADO`, `NO COMPLETADO`, `NO ABORDADO`). |
| 22 | **Lista de Referencias Bibliográficas (APA)** | Referencias | Registro consolidado de fuentes académicas y técnicas citadas. |
| 23 | **Compendio de Anexos y Entregables** | Anexos | Evidencias complementarias, diccionarios de datos o manuales de despliegue. |

---

## 5. Bloqueantes, Inconsistencias y Puntos Ambiguos de la Plantilla

Del análisis exhaustivo del archivo de la plantilla se extraen las siguientes inconsistencias críticas y ambigüedades técnicas que representan bloqueantes para la redacción:

### Inconsistencia Crítica: Temporalidad de 16 Semanas vs Módulo de 8 Semanas
> [!IMPORTANT]
> **Hallazgo Principal:** En la subsección `4.4. MATRIZ DE RESPONSABILIDADES`, la plantilla incluye tablas de seguimiento explícitas y preformateadas desde la **Semana 01 hasta la Semana 16**. Sin embargo, la modalidad de impartición del curso en el sistema modular / WA de UPN contempla un periodo lectivo de **8 semanas**.  
> Esta discrepancia obliga a definir si la matriz debe adaptarse y sintetizarse a las 8 semanas reales de clase o si debe simular un cronograma semestral estándar de 16 semanas.

### Inconsistencias Estructurales y Errores de Numeración
1. **Salto de numeración en el Capítulo I:**  
   En el texto y en el índice se pasa directamente de `1.1. MOTIVACIÓN DEL PROYECTO` a `1.3. PROPUESTAS`, omitiendo completamente el ítem `1.2` (presumiblemente reservado en versiones anteriores para "Descripción del proyecto" o "Realidad problemática").
2. **Discrepancia entre la Tabla de Contenido (TOC) y el Cuerpo del Capítulo IV:**  
   - En el TOC inicial, el Capítulo IV solo lista: *4.1 Alternativas de solución*, *4.2 Cronograma del proyecto* y *4.3 Modelado del negocio*.
   - En el cuerpo del informe, el desglose real es: *4.1 Alternativas de solución*, *4.2 Cronograma del proyecto*, *4.3 Roles y responsabilidades en el proyecto*, *4.4 Matriz de responsabilidades* y *4.5 Modelado del negocio*.
3. **Discrepancias en el Capítulo V (TOC vs Cuerpo):**  
   - La sección `5.7. MIGRACIÓN AL GESTOR DE BASE DE DATOS` aparece en el cuerpo del informe pero fue omitida en el TOC inicial.
   - La sección `5.10. CONTRASTACIÓN DE REQUERIMIENTOS` aparece al final del Capítulo V con su respectiva tabla, pero no figura registrada en el TOC inicial.
4. **Error tipográfico en subíndices de 5.3 (Modelo Conceptual):**  
   En la subsección `5.3. MODELO CONCEPTUAL`, los numerales están redactados como:
   - `5.3.1. Identificación de entidades`
   - `5.3.2. Identificación de atributos`
   - `5.3.3. Identificación de relaciones`
   - `5.5.4. Identificación de cardinalidad` *(error evidente de tipografía: debería ser 5.3.4)*
   - `5.3.5. Limitaciones`

### Ambigüedades de Formato y Lógica Técnica
1. **Incoherencia en los datos del ejemplo de Alternativas de Solución (4.1):**  
   La matriz de ejemplo muestra criterios valorados en 5, 8, 0 para la Propuesta 1, pero indica un total arbitrario de 45; para la Propuesta 2 muestra 6, 1, 8 con total 30; y para la 3 muestra 3, 1, 1 con total 20. No se explicita si se requiere una ponderación porcentual por criterio o si es una suma aritmética simple sobre 10 puntos por factor.
2. **Ambigüedad en la Tabla de Contrastación de Requerimientos (5.10):**  
   La descripción solicita una *"Tabla donde muestre los roles frente a los requerimientos documentados"*, pero la cabecera de la tabla provista lista `Responsable | REQUERIMIENTOS DE PROYECTO | ESTADO`. No queda claro si la contrastación debe evaluar la cobertura funcional del software/BD frente a los casos de uso o el cumplimiento laboral de cada miembro del equipo frente a los requerimientos que le fueron asignados.
3. **Modalidad de entrega del Plan de Backups (5.9):**  
   La plantilla indica *"Plantee un plan de backups y recuperación ante fallos (entregable como documento)"*, lo que genera la duda de si debe incluirse in extenso como subsección de texto dentro del informe o adjuntarse como un manual técnico independiente en los Anexos.

---

## 6. Preguntas Abiertas para el Docente sobre la Plantilla

Para asegurar la correcta elaboración del informe final sin penalizaciones de formato ni de contenido, se plantean las siguientes preguntas formales dirigidas al docente del curso:

1. **Ajuste temporal del cronograma y matriz de responsabilidades (4.2 y 4.4):**  
   *¿La Matriz de Responsabilidades (sección 4.4) y el Diagrama Gantt (sección 4.2) deben ajustarse estrictamente a la duración real de 8 semanas del módulo académico actual, o se debe mantener el formato de 16 semanas simulando un semestre regular?*
2. **Corrección de numeración y correlatividad de secciones (1.2, 5.3.4 y Cap. IV):**  
   *¿Debemos corregir los saltos y errores de numeración de la plantilla (incorporar/reajustar el ítem 1.2, corregir el subíndice 5.5.4 a 5.3.4 y actualizar la Tabla de Contenidos para que refleje 4.3, 4.4, 4.5, 5.7 y 5.10), o es indispensable respetar la numeración literal del archivo original?*
3. **Criterios de ponderación en la Matriz de Alternativas de Solución (4.1):**  
   *¿La evaluación de alternativas en la sección 4.1 debe aplicar una suma directa de puntuaciones (escala 0-10) o se requiere definir pesos ponderados porcentuales para cada criterio de selección (Costos, Factibilidad, etc.)?*
4. **Alcance e interpretación de la Contrastación de Requerimientos (5.10):**  
   *¿La contrastación de requerimientos de la sección 5.10 debe validar la trazabilidad técnica de las entidades y tablas frente a los requerimientos funcionales del sistema, o debe funcionar como una matriz de control de tareas asignadas a los integrantes del grupo?*
5. **Ubicación y formato del Plan de Backups y Recuperación ante Fallos (5.9):**  
   *¿El Plan de Backups debe desarrollarse completamente dentro del cuerpo del Capítulo V, o debe sintetizarse en dicha sección e incluirse como un manual técnico detallado dentro del apartado de Anexos?*
6. **Formato y granularidad del Modelo Conceptual (5.3):**  
   *¿Para las secciones 5.3.1 a 5.3.5 se solicita un formato tabular descriptivo de entidades/atributos/cardinalidades además del diagrama entidad-relación gráfico, o es suficiente con el diagrama acompañado de sus restricciones?*
