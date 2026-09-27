---
name: upn-ppt-generation
description: Al preparar o revisar la Presentación (PPT) del Proyecto Final de Base de Datos (UPN) — estructura de diapositivas, secuencia, coherencia con el informe y con el criterio de evaluación "Presentación (PPT)" que vale 10%. No generar el archivo .pptx real hasta que el usuario lo pida explícitamente: este skill solo documenta las reglas a seguir.
---

# Generación de la Presentación (PPT) — Proyecto Final Base de Datos UPN

> **Regla de arranque:** este skill define CÓMO debe construirse la PPT cuando llegue el momento. No dispara la generación de ningún `.pptx`. Antes de crear el archivo real, confirmar explícitamente con el usuario que ya toca esa fase (normalmente Semana 7 del cronograma, con el informe ya redactado).

Fuente de verdad de los requisitos: `docs/proyecto-final/01-analisis/analisis-instructivo.md` (sección 3 y criterios de evaluación) y `docs/proyecto-final/01-analisis/analisis-informe-plantilla.md`.

---

## 1. Reglas obligatorias del instructivo (no negociables)

- **Extensión:** 15 a 18 diapositivas como máximo. Más de 18 es motivo de observación por exceso de contenido.
- **Prohibido copiar y pegar párrafos del informe.** La PPT debe priorizar diagramas, capturas del modelo de datos y resultados visuales — nunca bloques de texto largo.
- **Coherencia obligatoria con el informe:** mismo caso de negocio, mismos nombres de tablas, mismos resultados. Cualquier discrepancia entre informe y PPT es una bandera roja para el criterio "Presentación (PPT)" (10%) y para "Pertinencia del caso real" (10%).
- **Secuencia sugerida por el instructivo** (usar como columna vertebral, no como camisa de fuerza — se puede fusionar/expandir siempre que se respete el máximo de slides):
  1. Portada (título, integrantes, curso, docente).
  2. Presentación del caso real: organización/contexto, problemática y motivación.
  3. Objetivo general y específicos.
  4. Propuestas evaluadas y justificación de la elegida.
  5. Modelado del negocio (mapa de procesos).
  6. Modelo conceptual y modelo lógico (diagramas entidad-relación).
  7. Modelo físico y decisiones de normalización.
  8. Políticas de seguridad de usuario y plan de backups.
  9. Demostración de resultados (consultas clave, reportes obtenidos).
  10. Conclusiones y recomendaciones.
- **Template recomendado:** el instructivo sugiere usar el template oficial UPN. Mientras no se consiga el `.pptx` oficial de la universidad, usar como base visual el sistema de diseño documentado en `.claude/skills/upn-document-design/SKILL.md` (logo, `#FFC000`, footer curso+página, tablas cebra).

---

## 2. Cómo se conecta con el resto del proyecto

- **Modelo conceptual/lógico/físico (slides 6-7):** si el proyecto usa el patrón PARTY (ver `docs/proyecto-final/02-modelo-datos/patron-party.md`), estas slides deben mostrar el diagrama hub-and-spoke (`party` como hub, `party_role`, `party_identifier`, `party_relationship`, `contact_mechanism` como satélites) ya adaptado al caso real elegido — no el ejemplo genérico del documento de referencia.
- **Demostración de resultados (slide 9):** debe reflejar exactamente las consultas que se van a ejecutar en vivo durante el sustento (al menos un `JOIN`, subconsulta o función, según exige el criterio "Sustento del trabajo").
- **Auditoría antes de dar por lista la PPT:** invocar al agente `criteria-guardian` (`.claude/agents/criteria-guardian.md`) para verificar el criterio "Presentación (PPT)" contra el archivo real, no solo contra esta guía.

---

## 3. Checklist de generación (para cuando el usuario autorice construir el .pptx)

1. Confirmar que el informe (Cap. I-VI) ya tiene contenido real del caso elegido — no se resume lo que no existe.
2. Extraer del informe: nombre del caso, objetivos, propuestas evaluadas, diagramas de modelo conceptual/lógico/físico, políticas de seguridad, resultados de consultas.
3. Aplicar el sistema de diseño de `upn-document-design` (logo, paleta, tipografía, footer).
4. Contar las diapositivas finales: si superan 18, fusionar o mover contenido a anexos del informe.
5. Pasar el resultado por `criteria-guardian` antes de considerar la PPT terminada.

## 4. Qué NO hacer

- No generar el `.pptx` sin que el usuario lo pida explícitamente en esa conversación.
- No inventar contenido del caso real que no esté ya en el informe — la PPT resume, no inventa.
- No usar un caso, tablas o resultados distintos a los del informe y del sustento.
