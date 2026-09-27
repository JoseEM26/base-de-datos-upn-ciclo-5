---
name: upn-document-design
description: Al generar informes, PPTs o documentos con el formato oficial UPN para este curso.
---

# Sistema de Diseño Visual Oficial UPN

Guía de estilo y diseño visual institucional de la Universidad Privada del Norte (UPN) para la elaboración de documentos técnicos, informes de laboratorio, instructivos y presentaciones de proyectos del curso de Base de Datos.

---

## 1. Paleta de Colores

Valores hexadecimales exactos extraídos de la identidad y documentos oficiales UPN:

| Nombre | Hexadecimal | Uso Principal |
| :--- | :--- | :--- |
| **Dorado / Ámbar** | `#FFC000` | Barras horizontales bajo títulos de sección, separadores de encabezado/pie, bordes de callouts y encabezados de tabla. |
| **Crema Claro** | `#FFF3CC` | Fondo de filas alternas en tablas de datos y fondo de callouts/cajas de notas destacadas. |
| **Negro** | `#000000` | Cajas de portada, encabezados principales de tablas (con texto blanco) y cajas de "Importante" (con texto blanco). |
| **Blanco** | `#FFFFFF` | Fondo general de páginas, fondo base de tablas y color de tipografía sobre fondos negros o dorados oscuros. |

> **Regla de integridad:** No incorporar tonos o colores adicionales fuera de la paleta oficial indicada (`#FFC000`, `#FFF3CC`, `#000000`, `#FFFFFF`).

---

## 2. Tipografía

Jerarquía y familias tipográficas oficiales:

- **Fuente principal / Cuerpo:** `Calibri`
- **Fuentes secundarias / Fallbacks:** `Arial`, `Times New Roman`

### Jerarquía recomendada
- **Títulos de Portada:** Calibri 20-24pt Negrita.
- **Títulos de Sección (H1 / H2):** Calibri / Arial 14-16pt Negrita, en MAYÚSCULAS.
- **Subtítulos (H3):** Calibri 12-13pt Negrita.
- **Cuerpo de texto:** Calibri 11pt Regular (interlineado 1.15).
- **Tablas y notas:** Calibri / Arial 9-10pt Regular.
- **Encabezados y Pies de página:** Calibri / Arial 8-9pt.

---

## 3. Assets Institucionales

- **Logo oficial UPN:**
  - Ubicación relativa: `assets/logos/upn-logo.png`
  - Descripción: Doble flecha institucional con isotipo y wordmark "UPN" en negro sobre fondo transparente/blanco.

---

## 4. Patrones de Layout y Estructura

### A. Portada
1. **Logo UPN:** Logo institucional grande centrado en la parte superior.
2. **Caja Institucional:** Caja de fondo negro (`#000000`) con texto centrado en color blanco (`#FFFFFF`) y acentos dorados (`#FFC000`) con los datos institucionales (Facultad, Carrera, Curso).
3. **Título del Proyecto:** Tipografía en tamaño grande y negrita debajo de la caja institucional.
4. **Datos de Entrega:** Integrantes, docente, grupo y fecha alineados de forma limpia.

### B. Encabezado de Página (Header)
- **Logo UPN:** Ubicado en la esquina superior derecha de cada página (`assets/logos/upn-logo.png`).
- **Barra Divisoria:** Línea horizontal dorada fina (`#FFC000`) debajo del logo, separando el área del encabezado del cuerpo del documento.

### C. Títulos de Sección
- Texto en **MAYÚSCULAS** y negrita.
- Acompañado obligatoriamente de una **barra horizontal dorada fina (`#FFC000`)** directamente debajo del título.

### D. Pie de Página (Footer)
- **Línea Divisoria:** Línea horizontal dorada fina (`#FFC000`) en la parte superior del pie de página.
- **Izquierda:** Texto informativo pequeño (ej. `Curso: Base de Datos — Instructivo del Proyecto Final` o título del informe).
- **Derecha:** Numeración de página con formato `Página N`.

### E. Tablas
- **Fila de Encabezado:** Fondo negro (`#000000`) con texto en blanco (`#FFFFFF`) y negrita (o acento dorado `#FFC000`).
- **Filas de Datos:** Alternancia cebra entre fondo blanco (`#FFFFFF`) y fondo crema claro (`#FFF3CC`).
- **Bordes:** Líneas finas sutiles o doradas `#FFC000`.

### F. Cajas Destacadas y Callouts
- **Cajas "Importante" / Alertas:** Fondo negro (`#000000`), texto blanco (`#FFFFFF`) y borde dorado (`#FFC000`).
- **Cajas de Notas / Consejos:** Fondo crema claro (`#FFF3CC`) con borde izquierdo o contorno dorado (`#FFC000`) y texto en negro (`#000000`).

---

## 5. Guía de Aplicación para Nuevos Documentos

Al generar o formatear cualquier documento (Word `.docx`, PDF o diapositivas PowerPoint `.pptx`) para el curso de Base de Datos en UPN, se deben cumplir los siguientes elementos obligatorios:

### Elementos Obligatorios
1. **Inclusión del Logo:** Usar siempre el archivo oficial en `assets/logos/upn-logo.png` (en la esquina superior derecha en páginas de contenido o centrado en portadas/slides iniciales).
2. **Barra Dorada Separadora:** Uso consistente del color `#FFC000` bajo títulos y delimitando header/footer.
3. **Footer Institucional:** Información del curso a la izquierda y número de página a la derecha.
4. **Tablas con Formato Cebra:** Encabezado negro `#000000` con texto blanco `#FFFFFF`, y alternancia blanco `#FFFFFF` / crema `#FFF3CC`.

### Aplicación en Presentaciones (PPTX)
- **Diapositiva de Título:** Fondo blanco o bloque negro institucional, logo UPN centrado arriba, barra dorada `#FFC000` delimitando el tema principal.
- **Diapositivas de Contenido:** Logo UPN pequeño arriba a la derecha, título de la lámina con barra dorada `#FFC000` debajo, pie de página institucional con numeración y tema.
- **Cajas de Resumen / Énfasis:** Callouts con fondo crema `#FFF3CC` y borde dorado `#FFC000` o fondo negro `#000000` para puntos clave.
