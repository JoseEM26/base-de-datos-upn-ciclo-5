# Análisis del Instructivo del Proyecto Final

**Curso:** Base de Datos  
**Carrera:** Ingeniería de Sistemas Computacionales (ISC)  
**Institución:** Universidad Privada del Norte (UPN)  
**Duración:** Módulo intensivo de 8 semanas  

---

## 1. Resumen Ejecutivo
El presente documento analiza las directrices del proyecto final de Base de Datos de la UPN, enfocado en el diseño, modelado e implementación de una solución relacional completa para resolver una problemática real de gestión de datos en una organización verificable, siguiendo la plantilla oficial de 6 capítulos y defendiéndose mediante informe escrito, diapositivas y sustento técnico en vivo a lo largo de un módulo intensivo de 8 semanas.

---

## 2. Objetivo del Proyecto
Capacitar al estudiante para:
- Identificar una necesidad real de gestión de información en una organización, empresa, institución o comunidad.
- Diseñar, modelar e implementar una base de datos relacional completa (a nivel conceptual, lógico y físico) que resuelva de manera efectiva dicha necesidad.
- Aplicar buenas prácticas de ingeniería de datos, normalización, políticas de seguridad de usuarios y planes de contingencia (backups y recuperación ante fallos).
- Partir obligatoriamente de un caso de la vida real verificable (negocio, entidad pública, ONG, emprendimiento o contexto afín), evitando problemáticas genéricas, inventadas o copiadas de repositorios/tutoriales de internet.

---

## 3. Qué se Debe Entregar (Los 3 Entregables)

Los tres entregables deben mantener una estricta coherencia técnica entre sí (mismo caso de negocio, mismos nombres de tablas/atributos y mismos resultados):

| Entregable | Descripción y Contenido Obligatorio | Formato de Entrega |
| :--- | :--- | :--- |
| **1. Informe Completo** | Documento estructurado según la plantilla oficial *"ISC-Informe Proyecto Final Base de Datos"* sin alterar el orden ni omitir secciones:<br>• **Carátula:** Título, autores en orden alfabético con % de participación individual, curso, docente, ciudad y año.<br>• **Índices:** Contenido, tablas, figuras y anexos.<br>• **Resumen y Abstract:** Con 5 palabras clave (versión español e inglés).<br>• **Capítulo I (Introducción):** Motivación, propuestas evaluadas (mínimo 3 alternativas con descripción, ventajas y desventajas) e impactos del proyecto (social, cultural, político, ambiental, ético, económico).<br>• **Capítulo II (Marco Teórico):** Antecedentes (mínimo 5 citados y parafraseados en formato APA), bases teóricas, formulación del problema, objetivo general y específicos, y alcance.<br>• **Capítulo III (Herramientas de Ingeniería):** Comparación de metodologías/estándares y justificación de herramientas de hardware y software.<br>• **Capítulo IV (Generación de Soluciones):** Matriz de alternativas de solución, cronograma Gantt, roles/responsabilidades, matriz semanal y modelado del negocio (mapa de procesos y reglas de negocio).<br>• **Capítulo V (Metodología de Desarrollo):** Requerimientos, stakeholders, modelo conceptual (entidades, atributos, relaciones, cardinalidad, limitaciones), modelo lógico, normalización, modelo físico, migración al SGBD, políticas de seguridad de usuarios, plan de backups/recuperación y contrastación de requerimientos.<br>• **Capítulo VI (Conclusiones y Recomendaciones):** Basadas en los resultados reales obtenidos.<br>• **Referencias Bibliográficas:** Formato APA.<br>• **Anexos:** Scripts SQL, capturas del modelo físico en SGBD y evidencias del caso real (fotos, entrevistas, formularios). | Documento en formato **Word (.docx)** y **PDF** |
| **2. Presentación (PPT)** | Síntesis visual y ejecutiva del proyecto para la exposición ante el docente y compañeros:<br>• Extensión máxima de 15 a 18 diapositivas utilizando el template oficial UPN.<br>• Secuencia estructurada: Portada, Presentación del caso/problemática, Objetivos, Propuestas evaluadas, Modelado del negocio (procesos), Modelo conceptual/lógico (ER), Modelo físico/normalización, Seguridad y backups, Demostración de resultados (consultas/reportes clave), y Conclusiones/recomendaciones.<br>• Énfasis en diagramas, esquemas y capturas; prohibido copiar y pegar bloques de texto del informe. | Presentación en **PowerPoint (.pptx)** |
| **3. Sustento del Trabajo** | Exposición oral y defensa técnica del proyecto ante el docente:<br>• Duración estimada: 15 a 20 minutos de exposición grupal equitativa + ronda de preguntas del docente.<br>• Demostración técnica en vivo dentro del gestor de base de datos (creación/consulta de tablas, al menos una consulta compleja con `JOIN`, subconsulta o función, y aplicación de políticas de seguridad de usuarios).<br>• Defensa individual de cualquier sección del informe (modelo lógico, normalización, backups, etc.). | **Exposición en vivo** + **Script de Base de Datos (.sql)** |

---

## 4. Criterios de Evaluación

| Criterio | Descripción | Peso (%) |
| :--- | :--- | :---: |
| **Pertinencia del caso real** | El caso es verificable, real o basado en un modelo real, y coherente a lo largo de todo el informe. | **10%** |
| **Informe completo** | Cumplimiento estricto de la estructura oficial de la plantilla, redacción técnica clara, citas y referencias en formato APA, y capítulos desarrollados a profundidad. | **30%** |
| **Modelado y base de datos** | Correcta identificación de entidades/relaciones, proceso riguroso de normalización, modelo físico implementado y base de datos funcional en el SGBD. | **30%** |
| **Presentación (PPT)** | Claridad visual, síntesis técnica adecuada, uso correcto de recursos gráficos y total coherencia con el informe escrito. | **10%** |
| **Sustento del trabajo** | Dominio conceptual y técnico del tema, ejecución exitosa de la demostración en vivo en el SGBD y participación equitativa de todos los integrantes del grupo. | **20%** |
| **TOTAL** | | **100%** |

---

## 5. Cronograma de 8 Semanas

| Semana | Hito Principal de Trabajo |
| :---: | :--- |
| **Semana 1** | Conformación formal de grupos, selección del caso real de negocio y elaboración/entrega de la ficha de validación al docente. |
| **Semana 2** | Desarrollo del **Capítulo I:** Introducción, motivación del proyecto, evaluación de propuestas (mínimo 3) y análisis de impactos (social, cultural, político, ambiental, ético, económico). |
| **Semana 3** | Desarrollo del **Capítulo II:** Marco teórico, antecedentes (mínimo 5 en APA), definición del problema, objetivos y alcance. Inicio del **Capítulo III:** Herramientas de ingeniería y justificación de hardware/software. |
| **Semana 4** | Desarrollo del **Capítulo IV:** Matriz de alternativas de solución, cronograma Gantt, matriz de responsabilidades y modelado del negocio (mapa de procesos y reglas de negocio). |
| **Semana 5** | Desarrollo del **Capítulo V (Parte 1):** Requerimientos del negocio, stakeholders, diseño del modelo conceptual y modelo lógico relacional. |
| **Semana 6** | Desarrollo del **Capítulo V (Parte 2):** Proceso de normalización, diseño del modelo físico, migración e implementación en el gestor de BD, políticas de seguridad de usuarios y plan de backups/recuperación. |
| **Semana 7** | Desarrollo del **Capítulo VI:** Conclusiones y recomendaciones finales. Consolidación y revisión integral del informe completo. Diseño de la presentación PPT y ensayo general del sustento. |
| **Semana 8** | **Sustentación final del proyecto** (exposición oral, defensa técnica y demostración en vivo en el SGBD ante el docente). |

> **Nota metodológica:** Al ser un módulo intensivo de 8 semanas, se exige avanzar en paralelo la redacción documental y la implementación técnica en el SGBD a partir de la Semana 4, evitando posponer el desarrollo en base de datos.

---

## 6. Reglas de Conformación de Grupos

- **Tamaño del grupo:** Mínimo 2 y máximo 4 integrantes.
- **Participación obligatoria:** Todos los miembros deben involucrarse activamente en todas las fases del ciclo de vida del proyecto (análisis, modelado, desarrollo en SGBD y sustentación). **No se aceptan roles "decorativos" ni división aislada de tareas.**
- **Transparencia en autoría:** La carátula del informe oficial debe consignar explícitamente el porcentaje (%) de participación individual de cada integrante.
- **Evaluación y defensa individual:** El docente está facultado para interrogar individualmente a cualquier miembro sobre cualquier capítulo o componente técnico del proyecto, con independencia de quién haya redactado la sección.
- **Diferenciación de exigencia por tamaño:**
  - **Grupos de 2 integrantes:** Evaluados bajo el mismo estándar de rigor y calidad técnica; el alcance del caso de negocio debe ser realista y manejable para dos personas.
  - **Grupos de 4 integrantes:** Se exige mayor profundidad analítica, mayor volumen y complejidad de entidades/tablas en el modelo relacional, y un caso de negocio con procesos más amplios y complejos.

---

## 7. Reglas Sobre el Caso Real de Negocio

### 7.1. Orígenes Válidos y Aceptados
1. **Negocio o emprendimiento real:** Perteneciente a un integrante, familiar o conocido cercano (ejemplos: bodega, restaurante, taller mecánico, clínica veterinaria, gimnasio, ferretería, etc.).
2. **Área o proceso institucional (público o privado):** Organización donde un integrante labore, realice prácticas preprofesionales o tenga acceso formal a información operativa (ejemplos: colegio, posta de salud, municipalidad, ONG, hospital, empresa comercial).
3. **Problemática social o comunitaria verificable:** Gestión de donaciones, padrón y control de voluntariado, seguimiento de pacientes en campañas de salud pública, etc.
4. **Caso simulado con base real (excepción condicionada):** Únicamente permitido si el grupo no dispone de acceso directo a una organización física, siempre que esté fundamentado en un modelo de negocio real y existente con fuentes y referencias verificables (no ideas puramente ficticias o abstractas).

### 7.2. Lo que NO se Acepta
- Casos genéricos o plantillas extraídas textualmente de tutoriales, videos de YouTube o repositorios públicos de internet (ej. "tienda de ejemplo", "videoclub genérico").
- Reutilización de proyectos o casos presentados en ciclos académicos anteriores sin autorización expresa del docente.
- Bases de datos desvinculadas de un contexto organizacional, operativo o de servicio identificable.

### 7.3. Validación Obligatoria en Semana 1
Durante la Semana 1 es mandatorio entregar una **Ficha de Validación** (máximo 1 página) que detalle:
1. Nombre del caso.
2. Organización u origen del caso.
3. Problemática identificada.
4. Objetivo general del proyecto.  
*El docente debe emitir su aprobación o solicitar ajustes antes de proseguir.*

---

## 8. Bloqueantes y Riesgos Críticos para el Equipo

1. **Retraso en la elección del caso (Bloqueante crítico):** En un periodo de 8 semanas, no tener el caso aprobado en Semana 1 genera un efecto bola de nieve que invalida el cumplimiento del cronograma de entregables semanales.
2. **Incoherencia entre capítulos (Observación grave):** El caso delimitado en el Capítulo I debe coincidir exactamente con el modelado en el Capítulo V y con los scripts/tablas implementados en el SGBD. Modificar o cambiar de caso a mitad del proyecto se penaliza como falta grave.
3. **Falta de evidencias reales tempranas:** No recopilar evidencias físicas o digitales (fotografías, entrevistas, formatos de registro, boletas, fichas operativas) desde la Semana 1 debilita el sustento del Capítulo I, los Anexos y la calificación de pertinencia del caso (10%).
4. **Desfase entre documentación e implementación técnica:** Esperar a la Semana 6 o 7 para programar la base de datos en el SGBD suele derivar en errores de integridad referencial, tipos de datos incompatibles o consultas complejas incompletas.
5. **Existencia de roles "decorativos" o falta de dominio cruzado:** La evaluación en el sustento oral es individual y no programada por roles; si un miembro desconoce la normalización o el plan de backups, impacta directamente la nota individual y la del criterio de sustento (20%).
6. **Fallas en vivo del script SQL / entorno de demostración:** No haber probado previamente la ejecución limpia del script de creación, poblado de datos y consultas en el equipo donde se sustentará puede arruinar la demostración técnica en vivo.

---

## 9. Preguntas Abiertas para Resolver con el Docente Antes de Empezar

Con base en las ambigüedades e indeterminaciones detectadas en el instructivo oficial, el equipo debe plantear y clarificar las siguientes dudas con el docente:

1. **Gestor de Base de Datos (SGBD) homologado:**  
   El instructivo menciona *"migración al gestor de base de datos"* de forma general. ¿Existe un motor de base de datos relacional obligatorio (ej. Microsoft SQL Server, MySQL, PostgreSQL, Oracle) o la elección del SGBD es completamente libre a criterio del equipo siempre que sea relacional?
2. **Rango cuantitativo de entidades/tablas según el tamaño del grupo:**  
   El instructivo señala que a los grupos de 4 integrantes se les exigirá *"más entidades/tablas"* y *"mayor complejidad"* que a los de 2. ¿Existe un número mínimo y máximo de tablas/entidades esperado para un grupo de 2, 3 o 4 integrantes?
3. **Criterios de evidencia y validación para la excepción de casos simulados:**  
   En caso de recurrir a la modalidad de *"caso simulado basado en un modelo real existente"*, ¿qué tipo de documentación o fuente de referencia verificable requerirá el docente en la ficha de Semana 1 para validar el caso sin penalizar el 10% de *"Pertinencia del caso real"*?
4. **Mecanismo de aplicación del porcentaje (%) de participación en la calificación:**  
   El instructivo estipula registrar el porcentaje de participación individual en la carátula y realizar preguntas orales individuales, pero la rúbrica presenta porcentajes globales (30% informe, 30% BD, 20% sustento, 10% PPT, 10% pertinencia). ¿Cómo se computa matemáticamente el porcentaje de participación sobre la nota final de cada estudiante?
5. **Nivel de profundidad técnica en seguridad y plan de contingencia:**  
   En el Capítulo V y en el sustento se solicitan *"políticas de seguridad de usuario"* y *"plan de backups y recuperación de fallos"*. ¿Se requiere la implementación funcional en el SGBD mediante sentencias DCL (`CREATE LOGIN`, `USER`, `ROLE`, `GRANT/REVOKE`) y scripts ejecutables de backups automáticos (completos, diferenciales, log de transacciones), o basta con una propuesta documental procedimental?
6. **Canal y política de entregas parciales semanales:**  
   El cronograma lista hitos por semana, pero no aclara si se habilitarán tareas de entrega semanal formal en la plataforma virtual (Blackboard) para retroalimentación calificada, o si las revisiones se realizarán únicamente de manera verbal y formativa en clase.
