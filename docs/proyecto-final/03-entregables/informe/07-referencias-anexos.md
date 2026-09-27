# REFERENCIAS BIBLIOGRÁFICAS Y ANEXOS

## REFERENCIAS BIBLIOGRÁFICAS (Normas APA 7ma Edición)

1. **Código Penal Peruano.** (2023). *Decreto Legislativo N° 1585 y Ley N° 31751: Tipificación y endurecimiento de sanciones contra el delito de usura y cobro extorsivo de créditos informales*. Diario Oficial El Peruano.
2. **Connolly, T. M., & Begg, C. E.** (2014). *Database Systems: A Practical Approach to Design, Implementation, and Management* (6th ed.). Pearson Education.
3. **Elmasri, R., & Navathe, S. B.** (2015). *Fundamentals of Database Systems* (7th ed.). Pearson Education.
4. **Instituto Peruano de Economía [IPE].** (2024). *El mercado de crédito informal en el Perú: Dinámica, expansión del 'gota a gota' y tasas de interés en el sector no bancarizado*. Informe Técnico IPE. https://www.ipe.org.pe
5. **Silverston, L.** (2001). *The Data Model Resource Book, Vol. 1: A Library of Universal Data Models for All Enterprises* (Revised ed.). John Wiley & Sons, Inc.
6. **Superintendencia de Banca, Seguros y AFP [SBS].** (2023). *Relación de aplicativos y esquemas informales no autorizados de captación y préstamos de dinero*. Portal Institucional de la SBS Perú. https://www.sbs.gob.pe

---

## ANEXOS

### ANEXO A: SCRIPTS SQL DE CONSULTAS TRANSACCIONALES Y AUDITORÍA EN SQL SERVER

A continuación se incluyen las consultas SQL representativas que demuestran la potencia del patrón PARTY en Microsoft SQL Server, requeridas para la sustentación y defensa técnica en vivo:

#### 1. Consulta Compleja con Múltiples JOINs: Vista Consolidada de Clientes y Roles Activos
```sql
-- Listado de personas con sus documentos oficiales, roles vigentes y teléfonos de contacto
SELECT 
    p.party_id,
    per.first_name + ' ' + per.last_name AS nombre_completo,
    pid.id_type AS tipo_documento,
    pid.id_value AS numero_documento,
    pr.role_type AS rol_ejercido,
    pr.start_date AS fecha_inicio_rol,
    cm.value AS telefono_contacto
FROM PARTY p
INNER JOIN PERSON per ON p.party_id = per.party_id
LEFT JOIN PARTY_IDENTIFIER pid ON p.party_id = pid.party_id AND pid.id_type = 'DNI'
LEFT JOIN PARTY_ROLE pr ON p.party_id = pr.party_id AND (pr.end_date IS NULL OR pr.end_date >= CAST(SYSDATETIME() AS DATE))
LEFT JOIN CONTACT_MECHANISM cm ON p.party_id = cm.party_id AND cm.type = 'PHONE'
WHERE p.status = 'ACTIVE'
ORDER BY per.last_name, per.first_name;
```

#### 2. Consulta de Auditoría de Riesgo: Monitoreo de Avales Cruzados y Créditos Garantizados
```sql
-- Identificación de personas que actúan como avales y el volumen total garantizado
SELECT 
    aval_per.first_name + ' ' + aval_per.last_name AS nombre_aval,
    aval_id.id_value AS dni_aval,
    COUNT(c.credito_id) AS total_creditos_garantizados,
    SUM(c.monto) AS monto_total_garantizado,
    deudor_per.first_name + ' ' + deudor_per.last_name AS nombre_prestatario,
    c.monto AS monto_prestamo,
    c.estado AS estado_credito
FROM PARTY_RELATIONSHIP rel
INNER JOIN PARTY aval_p ON rel.from_party_id = aval_p.party_id
INNER JOIN PERSON aval_per ON aval_p.party_id = aval_per.party_id
LEFT JOIN PARTY_IDENTIFIER aval_id ON aval_p.party_id = aval_id.party_id AND aval_id.id_type = 'DNI'
INNER JOIN PARTY deudor_p ON rel.to_party_id = deudor_p.party_id
INNER JOIN PERSON deudor_per ON deudor_p.party_id = deudor_per.party_id
INNER JOIN PARTY_ROLE pr_deudor ON deudor_p.party_id = pr_deudor.party_id AND pr_deudor.role_type = 'PRESTATARIO'
INNER JOIN PRESTATARIO_DETAIL pd ON pr_deudor.party_role_id = pd.party_role_id
INNER JOIN CREDITO c ON pd.party_role_id = c.party_role_id
WHERE rel.relationship_type = 'AVAL' 
  AND (rel.end_date IS NULL OR rel.end_date >= CAST(SYSDATETIME() AS DATE))
  AND c.estado = 'VIGENTE'
GROUP BY 
    aval_per.first_name, aval_per.last_name, aval_id.id_value,
    deudor_per.first_name, deudor_per.last_name, c.monto, c.estado;
```

#### 3. Consulta de Liquidación Diaria de Recaudación en Ruta por Cobrador
```sql
-- Reporte de liquidación de cuotas cobradas en campo agrupado por cobrador y fecha
SELECT 
    cobr_per.first_name + ' ' + cobr_per.last_name AS cobrador_responsable,
    pg.fecha_pago,
    COUNT(pg.pago_id) AS total_cuotas_cobradas,
    SUM(pg.monto_pagado) AS total_recaudado_soles,
    cli_per.first_name + ' ' + cli_per.last_name AS cliente_pagador,
    pg.monto_pagado AS importe_cuota
FROM PAGO pg
INNER JOIN PARTY_ROLE pr_cobr ON pg.party_role_id = pr_cobr.party_role_id
INNER JOIN PARTY cobr_p ON pr_cobr.party_id = cobr_p.party_id
INNER JOIN PERSON cobr_per ON cobr_p.party_id = cobr_per.party_id
INNER JOIN CREDITO c ON pg.credito_id = c.credito_id
INNER JOIN PRESTATARIO_DETAIL pd ON c.party_role_id = pd.party_role_id
INNER JOIN PARTY_ROLE pr_cli ON pd.party_role_id = pr_cli.party_role_id
INNER JOIN PARTY cli_p ON pr_cli.party_id = cli_p.party_id
INNER JOIN PERSON cli_per ON cli_p.party_id = cli_per.party_id
WHERE pg.fecha_pago = CAST(SYSDATETIME() AS DATE)
GROUP BY 
    cobr_per.first_name, cobr_per.last_name, pg.fecha_pago,
    cli_per.first_name, cli_per.last_name, pg.monto_pagado
ORDER BY cobr_per.last_name;
```

---

### ANEXO B: FICHA DE VALIDACIÓN DEL CASO REAL (SEMANA 1)
*(Se adjunta como referencia la ficha formal aprobada por el docente durante la Semana 1, sustentando el origen y la pertinencia del modelo de negocio de microcréditos BGG con fuentes verificables del IPE y la SBS).*

### ANEXO C: GUÍAS DE ENTREVISTA Y FORMATOS DE CAMPO DE COBRANZA EN RUTA
*(Compendio de cartillas de cobranza física del estado AS-IS digitalizadas para evidenciar la transición hacia el modelo relacional TO-BE).*
