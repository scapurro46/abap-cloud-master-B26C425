CLASS zcl_lab_07_tables_sergio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
          INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_07_tables_sergio IMPLEMENTATION.
 METHOD if_oo_adt_classrun~main.

*"------------------------------------------------------------
*" 1. Declaración de estructura y tabla interna
*"------------------------------------------------------------
*  DATA ms_employees TYPE zemp_logali.
*  DATA mt_employees TYPE STANDARD TABLE OF
*        zemp_logali WITH EMPTY KEY.
*
*"------------------------------------------------------------
*" 2. Añadir registros usando VALUE
*"------------------------------------------------------------
*  ms_employees = VALUE zemp_logali(
*      employee_id = '001'
*      email       = 'juan.perez@example.com'
*      ape1        = 'Perez'
*      ape2        = 'Gomez'
*      name        = 'Juan'
*      fechan      = '19900101'
*      fechaa      = '20230101'
*    ).
*
*    APPEND ms_employees TO mt_employees.
*
*    ms_employees = VALUE zemp_logali(
*      employee_id = '002'
*      email       = 'maria.lopez@example.com'
*      ape1        = 'Lopez'
*      ape2        = 'Diaz'
*      name        = 'Maria'
*      fechan      = '19950510'
*      fechaa      = '20230215'
*    ).
*
*    APPEND ms_employees TO mt_employees.
*
*    "------------------------------------------------------------
*    " 3. Mostrar en consola usando out->write
*    "------------------------------------------------------------
*    out->write(
*      EXPORTING
*        data = mt_employees
*        name = 'Registros añadidos a MT_EMPLOYEES'
*    ).
*
*
*"------------------------------------------------------------
*" 2. Insertar un tercer registro con INSERT
*"------------------------------------------------------------
*ms_employees = VALUE zemp_logali(
*  employee_id = '003'
*  email       = 'carlos.ramirez@example.com'
*  ape1        = 'Ramirez'
*  ape2        = 'Jimenez'
*  name        = 'Carlos'
*  fechan      = '19881212'
*  fechaa      = '20230320'
*).
*
*" INSERT → agrega la línea en la posición indicada
*INSERT ms_employees INTO TABLE mt_employees.
*
*" Mostrar resultado actualizado
*out->write(
*  EXPORTING
*    data = mt_employees
*    name = 'MT_EMPLOYEES con registro insertado'
*).
*
*"------------------------------------------------------------
*" 3. Añadir registros con APPEND
*"------------------------------------------------------------
*" Declaración de la nueva tabla interna
*DATA mt_employees_2 TYPE STANDARD TABLE OF zemp_logali WITH EMPTY KEY.
*
*"------------------------------------------------------------
*" 3.1 APPEND usando estructura MS_EMPLOYEES (forma clásica)
*"------------------------------------------------------------
*ms_employees = VALUE zemp_logali(
*  employee_id = '010'
*  email       = 'classic.append@example.com'
*  ape1        = 'Gonzalez'
*  ape2        = 'Lopez'
*  name        = 'Carlos'
*  fechan      = '19800101'
*  fechaa      = '20230101'
*).
*
*APPEND ms_employees TO mt_employees_2.
*
*"------------------------------------------------------------
*" 3.2 APPEND VALUE (forma moderna)
*"------------------------------------------------------------
*APPEND VALUE zemp_logali(
*  employee_id = '011'
*  email       = 'modern.append@example.com'
*  ape1        = 'Martinez'
*  ape2        = 'Suarez'
*  name        = 'Lucia'
*  fechan      = '19921212'
*  fechaa      = '20230202'
*) TO mt_employees_2.
*
*"------------------------------------------------------------
*" 3.3 Copiar líneas 2 a 3 de MT_EMPLOYEES_1 hacia MT_EMPLOYEES_2
*"     (MT_EMPLOYEES_1 es la tabla creada en Actividad 1)
*"------------------------------------------------------------
*APPEND LINES OF mt_employees FROM 2 TO 3 TO mt_employees_2.
*
*"------------------------------------------------------------
*" Mostrar resultado en consola
*"------------------------------------------------------------
*out->write(
*  EXPORTING
*    data = mt_employees_2
*    name = 'MT_EMPLOYEES_2 - Actividad 3'
*).

*"------------------------------------------------------------
*" 4. CORRESPONDING
*"------------------------------------------------------------
*" Declaración de estructuras y tabla interna
*DATA mt_spfli   TYPE STANDARD TABLE OF /dmo/connection WITH EMPTY KEY.
*DATA ms_spfli   TYPE /dmo/connection.
*DATA ms_spfli_2 TYPE /dmo/connection.
*
*"------------------------------------------------------------
*" 4.1 SELECT de vuelos con carrier_id = 'LH'
*"------------------------------------------------------------
*SELECT *
*  FROM /dmo/connection
*  WHERE carrier_id = 'LH'
*  INTO TABLE @mt_spfli.
*
*" Mostrar la tabla resultante
*out->write(
*  EXPORTING
*    data = mt_spfli
*    name = 'Vuelos LH - MT_SPFLI'
*).
*
*"------------------------------------------------------------
*" 4.2 Leer primer registro
*"------------------------------------------------------------
*READ TABLE mt_spfli INTO ms_spfli INDEX 1.
*
*"------------------------------------------------------------
*" 4.3 Mover campos con MOVE-CORRESPONDING
*"------------------------------------------------------------
*MOVE-CORRESPONDING ms_spfli TO ms_spfli_2.
*
*" Alternativa moderna:
*" ms_spfli_2 = CORRESPONDING #( ms_spfli ).
*
*"------------------------------------------------------------
*" Mostrar estructuras
*"------------------------------------------------------------
*out->write(
*  EXPORTING
*    data = ms_spfli
*    name = 'MS_SPFLI (primer registro)'
*).
*
*out->write(
*  EXPORTING
*    data = ms_spfli_2
*    name = 'MS_SPFLI_2 (MOVE-CORRESPONDING)'
*).
*
*"------------------------------------------------------------
*" 5. READ TABLE con índice
*"------------------------------------------------------------
*DATA lv_cityfrom TYPE /dmo/connection-airport_from_id.
*
*" Leer el primer registro de la tabla MT_SPFLI
*READ TABLE mt_spfli INTO ms_spfli INDEX 1.
*
*IF sy-subrc = 0.
*  lv_cityfrom = ms_spfli-airport_from_id.
*ENDIF.
*
*" Mostrar la ciudad de partida
*out->write(
*  EXPORTING
*    data = lv_cityfrom
*    name = 'Primera ciudad de partida (INDEX 1)'
*).
*
*"------------------------------------------------------------
*" 6. READ TABLE con clave
*"------------------------------------------------------------
*
*DATA lv_airport_from_fra TYPE /dmo/connection-airport_from_id.
*
*" Leer el vuelo cuyo aeropuerto de destino es FRA
*READ TABLE mt_spfli INTO ms_spfli WITH KEY airport_to_id = 'FRA'.
*
*IF sy-subrc = 0.
*  lv_airport_from_fra = ms_spfli-airport_from_id.
*ENDIF.
*
*" Mostrar el aeropuerto de partida del vuelo hacia FRA
*out->write(
*  EXPORTING
*    data = lv_airport_from_fra
*    name = 'Aeropuerto de partida para destino FRA'
*).
*
*
*"------------------------------------------------------------
*" 7. Chequeo de registros
*"------------------------------------------------------------
*" Nueva tabla para vuelos con connection_id > '0400'
*DATA mt_spfli_gt_0400 TYPE STANDARD TABLE OF /dmo/connection WITH EMPTY KEY.
*DATA ms_spfli_gt_0400 TYPE /dmo/connection.
*
*"------------------------------------------------------------
*" 7.1 SELECT de vuelos con connection_id mayor a '0400'
*"------------------------------------------------------------
*SELECT *
*  FROM /dmo/connection
*  WHERE connection_id > '0400'
*  INTO TABLE @mt_spfli_gt_0400.
*
*out->write(
*  EXPORTING
*    data = mt_spfli_gt_0400
*    name = 'Vuelos con CONNECTION_ID > 0400'
*).
*
*"------------------------------------------------------------
*" 7.2 Validar si existe el vuelo 0407
*"------------------------------------------------------------
*" Forma clásica con READ TABLE
*READ TABLE mt_spfli_gt_0400 INTO ms_spfli_gt_0400
*     WITH KEY connection_id = '0407'.
*
*DATA lv_exists_read TYPE abap_bool.
*lv_exists_read = xsdbool( sy-subrc = 0 ).
*
*" Forma moderna con line_exists
*DATA lv_exists_line TYPE abap_bool.
*lv_exists_line = xsdbool( line_exists( mt_spfli_gt_0400[ connection_id = '0407' ] ) ).
*
*"------------------------------------------------------------
*" Mostrar resultados
*"------------------------------------------------------------
*out->write(
*  EXPORTING
*    data = lv_exists_read
*    name = 'Existe 0407 (READ TABLE)'
*).
*
*out->write(
*  EXPORTING
*    data = lv_exists_line
*    name = 'Existe 0407 (line_exists)'
*).
*
*"------------------------------------------------------------
*" 8. Índice de un registro
*"------------------------------------------------------------
*
*DATA lv_index_read TYPE i.
*DATA lv_index_line TYPE i.
*
*"------------------------------------------------------------
*" 8.1 Forma clásica con READ TABLE (sy-tabix)
*"------------------------------------------------------------
*READ TABLE mt_spfli_gt_0400 INTO ms_spfli_gt_0400
*     WITH KEY connection_id = '0407'.
*
*IF sy-subrc = 0.
*  lv_index_read = sy-tabix.
*ENDIF.
*
*"------------------------------------------------------------
*" 8.2 Forma moderna con line_index
*"------------------------------------------------------------
*lv_index_line = line_index( mt_spfli_gt_0400[ connection_id = '0407' ] ).
*
*"------------------------------------------------------------
*" Mostrar resultados
*"------------------------------------------------------------
*out->write(
*  EXPORTING
*    data = lv_index_read
*    name = 'Índice con READ TABLE'
*).
*
*out->write(
*  EXPORTING
*    data = lv_index_line
*    name = 'Índice con line_index'
*).

"------------------------------------------------------------
" 9. Sentencia LOOP
"------------------------------------------------------------
" Nueva tabla para almacenar vuelos con distancia en KM
DATA mt_spfli_km TYPE STANDARD TABLE OF /dmo/connection WITH EMPTY KEY.
DATA ms_spfli_km TYPE /dmo/connection.

"------------------------------------------------------------
" 9.1 SELECT de vuelos con unidad de distancia KM
"------------------------------------------------------------
SELECT *
  FROM /dmo/connection
  WHERE distance_unit = 'KM'
  INTO TABLE @mt_spfli_km.

"------------------------------------------------------------
" 9.2 Recorrer la tabla con LOOP y mostrar cada registro
"------------------------------------------------------------
LOOP AT mt_spfli_km INTO ms_spfli_km.

  out->write(
    EXPORTING
      data = ms_spfli_km
      name = 'Vuelo con distancia en KM'
  ).

ENDLOOP.


 ENDMETHOD.
ENDCLASS.
