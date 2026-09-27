# CAPÍTULO VI: CONCLUSIONES Y RECOMENDACIONES

## 6.1. CONCLUSIONES

1. **Eficacia del Patrón PARTY en la Centralización de Identidad:**  
   La adopción del patrón de modelado PARTY permitió superar definitivamente las patologías del modelo tradicional fragmentado (**AS-IS**). Se demostró que desacoplar la identidad ontológica de las personas naturales y jurídicas (`PARTY`, `PERSON`, `ORGANIZATION`) de sus roles transitorios (`PARTY_ROLE`) elimina la duplicidad de registros al 100%, permitiendo que un mismo sujeto actúe de manera simultánea o sucesiva como prestatario, aval o cobrador de ruta sin provocar redundancia ni inconsistencias de contacto.

2. **Garantía Formal de Normalización e Integridad de Datos:**  
   El esquema relacional diseñado e implementado alcanza de forma intrínseca la **Tercera Forma Normal (3FN)** y la **Forma Normal de Boyce-Codd (BCNF)**. Se erradicaron las anomalías de inserción, modificación y borrado presentes en el modelo plano original, suprimiendo las columnas con valores nulos masivos y garantizando que cada atributo no clave dependa única y exclusivamente de la clave primaria correspondiente.

3. **Trazabilidad y Auditoría Histórica del Riesgo Crediticio:**  
   La estructura de grafo relacional fechado provista por `PARTY_RELATIONSHIP` resolvió el punto ciego operativo de BGG respecto al riesgo de garantías cruzadas. Mediante restricciones declarativas y consultas analíticas sobre los rangos de vigencia (`start_date` y `end_date`), la administración puede auditar en tiempo real cuántas operaciones crediticias activas se encuentran garantizadas por un mismo aval, impidiendo el sobreendeudamiento encubierto y asegurando la rendición de cuentas en las asignaciones de rutas de cobranza.

4. **Robustez Transaccional y Seguridad Operativa en SQL Server:**  
   La implementación sobre **Microsoft SQL Server 2022** garantizó el cumplimiento estricto de las propiedades ACID en las transacciones de colocación y recaudación de cuotas. La segregación de privilegios mediante roles de base de datos (`rol_administrador`, `rol_cobrador`, `rol_auditor`) bajo el principio de menor privilegio, sumada a una política de copias de seguridad combinadas (Full, Diferencial y Log transaccional), asegura la protección de los datos y una recuperación ante desastres con un RPO $\le$ 15 minutos y un RTO $\le$ 30 minutos.

---

## 6.2. RECOMENDACIONES

1. **Implementación de Vistas Indexadas para Mitigar la Sobrecarga de JOINs:**  
   Dado que el patrón PARTY distribuye los atributos de una persona entre varias tablas normalizadas (`PARTY`, `PERSON`, `PARTY_IDENTIFIER`, `CONTACT_MECHANISM`), se recomienda crear vistas indizadas (*Indexed Views*) en SQL Server con la opción `WITH SCHEMABINDING` para los reportes de cobranza diaria más consultados, reduciendo el costo computacional de I/O en lecturas masivas.

2. **Automatización de Mantenimiento mediante el Agente de SQL Server:**  
   Se aconseja programar trabajos automatizados (*SQL Server Agent Jobs*) para la ejecución de la política de copias de seguridad (Full, Diferencial y Log), la reconstrucción/reorganización periódica de índices no agrupados (`ALTER INDEX REORGANIZE / REBUILD`) y la actualización de estadísticas de distribución de datos para optimizar los planes de ejecución del optimizador de consultas.

3. **Capa de Interoperabilidad Móvil y Cifrado en Tránsito (API REST):**  
   Para la fase posterior de digitalización de los cobradores de campo, se recomienda desarrollar una capa de servicios API REST desacoplada y autenticada mediante tokens JWT / OAuth 2.0, garantizando que las inserciones a la tabla `PAGO` viajen encriptadas bajo el protocolo HTTPS/TLS 1.3 desde dispositivos móviles corporativos.

4. **Incorporación de Cifrado Avanzado de Datos Sensibles (Always Encrypted / TDE):**  
   Con el fin de elevar los estándares de cumplimiento normativo y protección de datos personales de los clientes y avales, se recomienda implementar *Transparent Data Encryption (TDE)* a nivel de almacenamiento físico y *Always Encrypted* en columnas críticas como números de documentos de identidad (`id_value` en `PARTY_IDENTIFIER`) y montos financieros.
