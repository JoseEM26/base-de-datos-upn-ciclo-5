# Ficha de Validación del Caso — Proyecto Final

> **Estado: BORRADOR para revisión del equipo.** Aún no es el PDF final. Formato objetivo: 1 página, PDF, con el diseño oficial UPN (`.claude/skills/upn-document-design/`) cuando se apruebe el contenido.

---

**Facultad:** Ingeniería
**Carrera:** Ingeniería de Sistemas Computacionales
**Curso:** Base de Datos
**Docente:** Juan Emilio Asto Vara
**Ciudad y periodo:** Cajamarca – Perú, 2026-1

**Integrantes (orden alfabético) y % de participación:**

| Apellidos y Nombres | Código | % Participación |
|---|---|---|
| Aquino Rivera, Oswaldo Jader | N00571142 | 25% |
| Espinoza Morales, Jose Angel | N00575318 | 25% |
| León Ccahuana, Jeffre Carlos | N00423806 | 25% |
| Ramos Guerra, Jaime Eloy | N00377672 | 25% |

---

## 1. Nombre del caso

**BGG** — sistema de gestión de clientes, avales y cobranza para una entidad de microcréditos bajo esquema de préstamo diario ("gota a gota").

## 2. Organización u origen

Caso simulado, basado en el modelo de negocio real y existente de las entidades de microcrédito informal de préstamo diario ("gota a gota") que operan en el mercado peruano, con cobro de cuotas en ruta por parte de cobradores asignados.

**Referencia verificable del modelo de negocio:**
- Instituto Peruano de Economía (IPE), *El mercado de crédito informal en el Perú*: los préstamos "gota a gota" pasaron de representar el 22% (2022) al 35% (2024) del crédito informal, afectando a cerca de 211,000 familias, con tasas de interés anualizadas que superan el 1,400%.
- La Superintendencia de Banca, Seguros y AFP (SBS) supervisa activamente 18 aplicativos identificados que ofrecen este tipo de préstamos informales en el país.
- En 2023 se tipificó el delito de usura en el Código Penal peruano a raíz de este mismo fenómeno.

Estas fuentes acreditan que el modelo de negocio (no la empresa BGG en sí, que es ficticia) es real, existente y verificable, tal como exige el instructivo.

## 3. Problemática identificada

BGG opera bajo el esquema de préstamo "gota a gota" (cuotas diarias/semanales cobradas en ruta). Actualmente (**estado AS-IS**) su información se lleva de forma dispersa por rol — registros separados para clientes, avales y cobradores — lo que genera:

- Duplicación de datos cuando una misma persona pasa de cliente a aval de otro crédito, o de cliente a cobrador.
- Imposibilidad de saber cuántos créditos tiene garantizados una misma persona como aval en un momento dado.
- Pérdida de trazabilidad histórica de qué cobrador tuvo asignada la cobranza de qué cliente y en qué periodo.
- Riesgo de sobre-endeudamiento no detectado al no cruzarse la información de una persona en sus distintos roles.

La solución propuesta (**estado TO-BE**) migra este esquema disperso a un modelo relacional único basado en el patrón de modelado PARTY (identidad única + roles temporales + relaciones dirigidas), documentado en `docs/proyecto-final/02-modelo-datos/patron-party.md`.

## 4. Objetivo general

Diseñar e implementar una base de datos relacional para BGG que centralice la identidad de cada persona/organización (cliente, aval, cobrador) bajo un modelo único, evitando duplicación y permitiendo trazabilidad histórica de créditos, avales y cobranza, comparando el estado actual (AS-IS) frente al modelo migrado (TO-BE) para evidenciar los beneficios de la migración.

---

## Notas para el equipo (no van en la ficha final)

- SGBD elegido para la implementación: **SQL Server**.
- Enfoque de análisis: **AS-IS** (modelo disperso actual) vs. **TO-BE** (modelo migrado al patrón PARTY) — se usará también en Cap. I/IV del informe y en la demostración de resultados de la PPT/sustento.
- Referencia verificable del modelo de negocio ya resuelta (IPE + SBS, sección 2). Sin pendientes para pasar esto a PDF.
