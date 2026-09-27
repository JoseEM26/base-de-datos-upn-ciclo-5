# Bloqueantes y Dependencias del Proyecto Final (Base de Datos — UPN)

> Consolida lo encontrado en `analisis-instructivo.md` y `analisis-informe-plantilla.md`. Este documento responde a una sola pregunta: **¿qué falta definir o entregar antes de poder avanzar con el informe, el modelado y la sustentación?**

---

## 1. Estado actual

> **Decisión tomada:** entidad del caso = **BGG** (nombre completo solo para la carátula/ficha de validación oficial, en el resto de la documentación se usa el acrónimo BGG). Tipo de negocio: entidad financiera de microcréditos (ver `docs/proyecto-final/02-modelo-datos/patron-party.md` §9). Sigue pendiente llenar la ficha de validación de Semana 1 con la problemática concreta — ver dependencia #1 más abajo, ya actualizada.

Equipo, docente y SGBD ya definidos (ver §5 de `patron-party.md` y el historial de decisiones). Todo lo de abajo se mantiene como registro de lo ya resuelto y lo que sigue pendiente.

### Los 4 entregables (confirmados verbalmente por el docente — no estaban los 4 listados como tal en el PDF del instructivo, que solo nombra 3 "entregables obligatorios"; el 4to es el checkpoint de Semana 1 que el instructivo sí exige pero no cuenta en esa tabla)

| # | Entregable | Estado |
|---|---|---|
| 1 | **Ficha de Validación de Semana 1** | ✅ Generada — `docs/proyecto-final/03-entregables/ficha-validacion-semana1.pdf` (con logo BGG y diseño oficial UPN) |
| 2 | **Informe completo** (Word + PDF, 6 capítulos) | Pendiente — no iniciado |
| 3 | **Presentación (PPT)** | Pendiente — reglas ya documentadas en `.claude/skills/upn-ppt-generation/SKILL.md`, no generado |
| 4 | **Sustento del trabajo** (exposición + script SQL) | Pendiente — depende del script SQL en SQL Server, aún no generado |

---

## 2. Bloqueantes críticos (impiden avanzar si no se resuelven)

| # | Bloqueante | Por qué bloquea | Quién lo resuelve |
|---|---|---|---|
| 1 | ~~No hay caso real de negocio elegido~~ → **Entidad decidida: BGG.** Falta cerrar la problemática concreta y la ficha de validación de Semana 1. | Todo el informe (6 capítulos), el modelo de datos y la sustentación dependen de un único caso. | Equipo, en Semana 1 |
| 2 | ~~Ficha de validación de Semana 1 no entregada/aprobada~~ → **Ficha generada (PDF), falta solo la entrega física/virtual al docente y su aprobación.** | El instructivo exige que el docente apruebe el caso antes de continuar; sin aprobación, cualquier avance corre riesgo de rehacerse. | Equipo → Docente |
| 3 | ~~Conformación del grupo no definida~~ → **Resuelto: 4 integrantes** (Aquino Rivera, Espinoza Morales, León Ccahuana, Ramos Guerra), 25% de participación c/u. | El nivel de exigencia y alcance esperado depende del tamaño del grupo — grupo de 4 exige mayor profundidad de análisis. | — |
| 4 | ~~SGBD no elegido~~ → **Resuelto: SQL Server.** El DDL de ejemplo en `patron-party.md` está en sintaxis PostgreSQL — falta adaptarlo (`BIGSERIAL`→`IDENTITY(1,1)`, `now()`→`GETDATE()`) cuando se genere el script real. | El Capítulo III exige justificar la herramienta de software, y el Capítulo V exige migración/implementación en un gestor concreto. | — |
| 5 | **Regla de coherencia entre capítulos** | El instructivo advierte: cambiar de caso a mitad de informe es "observación grave". El caso del Cap. I debe ser exactamente el mismo del Cap. V y el de la base de datos del sustento — cualquier cambio de rumbo después de la Semana 1 es costoso. | Equipo (disciplina de proceso) |
| 6 | **Inconsistencia de cronograma: plantilla pide 16 semanas, el curso dura 8** | La Matriz de Responsabilidades (4.4) trae tablas semanales hasta la Semana 16, pero el módulo real dura 8 semanas. Si no se aclara con el docente, se puede perder tiempo llenando 8 semanas de tablas que no corresponden. | Docente (ver pregunta abierta #1 de la plantilla) |
| 7 | **No se acepta reutilizar un caso de ciclos anteriores sin autorización expresa** | Si algún integrante ya tiene un caso hecho en otro ciclo, necesita autorización explícita del docente antes de reusarlo — no asumir que se puede. | Equipo → Docente |
| 8 | **Roles "decorativos" no se aceptan** | El docente puede preguntar a cualquier integrante sobre cualquier sección, independientemente de quién la escribió. Si el reparto de trabajo no cubre a todos en todas las etapas, hay riesgo directo en la nota individual del sustento (20%). | Equipo |

---

## 3. Dependencias de información (datos que el equipo debe entregarme/definir)

Para poder generar contenido concreto de aquí en adelante (informe, PPT, script SQL) necesito que el equipo defina y me indique:

1. **Caso real de negocio**: ✅ entidad decidida (BGG). Falta: contacto o fuente de verificación, y la problemática concreta que resuelve la base de datos (ej. control de clientes/créditos, cobranza, gestión de avales, etc.).
2. **Integrantes del grupo**: nombres completos en orden alfabético, % de participación de cada uno, docente del curso.
3. **SGBD objetivo**: motor de base de datos elegido (MySQL, PostgreSQL, SQL Server, Oracle, etc.).
4. **Alcance aproximado**: qué procesos/entidades del negocio va a cubrir el sistema (esto define cuántas tablas se modelan).
5. **Evidencia disponible del caso real**: si hay fotos, formularios, entrevistas o acceso directo a la organización (o si se optará por un caso simulado con referencia verificable).

Sin estos 5 puntos no puedo redactar contenido real de ningún capítulo — solo puedo seguir trabajando sobre plantillas y estructura.

---

## 4. Dependencias documentales (qué archivos hacen falta generar o conseguir)

| Documento/artefacto | Estado | Depende de |
|---|---|---|
| Ficha de validación de caso (máx. 1 página) | Falta | Punto 2.1 (elección del caso) |
| Cuestionarios/entrevistas al "cliente" del caso real | Falta | Acceso a la organización elegida |
| Script SQL de creación + carga de datos | Falta | SGBD elegido + modelo físico terminado |
| Diagrama de modelo conceptual, lógico y físico | Falta | Caso real + entidades identificadas |
| Diagrama Gantt del proyecto | Falta | Fecha de inicio real y tamaño del grupo |
| Matriz de responsabilidades semanal | Falta (y pendiente de aclarar si son 8 o 16 semanas, ver bloqueante #6) | Respuesta del docente + integrantes definidos |
| Plantilla oficial de PPT UPN | No confirmado si se tiene el archivo template real (el instructivo solo lo recomienda) | Conseguir el .pptx oficial si existe, o usar `.claude/skills/upn-document-design/` como base |

---

## 5. Preguntas abiertas consolidadas (ya detectadas en los análisis previos, agrupadas por a quién preguntar)

### Para el docente
1. ¿La Matriz de Responsabilidades (4.4) y el Gantt (4.2) deben ajustarse a 8 semanas reales o mantenerse en formato de 16 semanas?
2. ¿Hay un SGBD obligatorio o la elección es libre mientras sea relacional?
3. ¿Existe un mínimo/máximo de entidades/tablas esperado según el tamaño del grupo (2, 3 o 4 integrantes)?
4. ¿Qué evidencia se exige si se usa un caso simulado (no un negocio con acceso directo)?
5. ¿Cómo se traduce el % de participación individual en la nota final de cada integrante?
6. ¿Se debe corregir la numeración de la plantilla (falta 1.2, error 5.5.4 en vez de 5.3.4, TOC desactualizado) o respetar el archivo original tal cual?
7. ¿La Contrastación de Requerimientos (5.10) evalúa cobertura funcional del sistema o cumplimiento de tareas del equipo?
8. ¿El Plan de Backups (5.9) va dentro del cuerpo del Cap. V o como manual aparte en Anexos?
9. ¿La Matriz de Alternativas (4.1) usa suma simple 0-10 o pesos ponderados por criterio?
10. ¿Se requiere implementación funcional de seguridad (roles/usuarios reales vía DCL) y backups ejecutables, o basta con la propuesta documental?
11. ¿Habrá entregas parciales semanales calificadas en la plataforma virtual, o solo revisión verbal en clase?

### Para el equipo (decisiones internas, no requieren al docente)
- Confirmar el caso real y su fuente de verificación antes de fin de Semana 1.
- Repartir capítulos garantizando que cada integrante domine al menos una parte del modelo de datos (por el riesgo del bloqueante #8).
- Decidir el SGBD y probarlo desde la Semana 4 en paralelo a la redacción, tal como recomienda el instructivo.

---

## 6. Siguiente acción recomendada

1. Elegir el caso real de negocio y llenar la ficha de validación de Semana 1.
2. Enviar al docente las preguntas 1-4 de la lista anterior (son las que más impactan el cronograma y el alcance técnico).
3. Una vez resuelto lo anterior, usar `.claude/agents/criteria-guardian.md` para auditar cada entregable a medida que se va escribiendo, en vez de esperar al final.
