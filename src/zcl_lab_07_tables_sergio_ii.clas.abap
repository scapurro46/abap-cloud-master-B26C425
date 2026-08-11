 CLASS zcl_lab_07_tables_sergio_ii DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
            INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
   TYPES: BEGIN OF ty_flights,
             iduser      TYPE c LENGTH 40,
             aircode     TYPE /dmo/carrier_id,
             flightnum   TYPE /dmo/connection_id,
             key         TYPE land1,
             seat        TYPE /dmo/plane_seats_occupied,
             flightdate  TYPE /dmo/flight_date,
           END OF ty_flights.

"***** Tipo local para COLLECT
   TYPES: BEGIN OF ty_seats,
             carrier_id      TYPE /dmo/carrier_id,
             connection_id   TYPE /dmo/connection_id,
             seats_occupied  TYPE /dmo/plane_seats_occupied,
             price           TYPE /dmo/flight_price,
             seats_max       TYPE /dmo/plane_seats_max,
          END OF ty_seats.

ENDCLASS.



CLASS ZCL_LAB_07_TABLES_SERGIO_II IMPLEMENTATION.


 METHOD if_oo_adt_classrun~main.

***********************************************************************
** 1. FOR
***********************************************************************
* DATA: lt_flights      TYPE STANDARD TABLE OF ty_flights,
*       lt_flights_info TYPE STANDARD TABLE OF ty_flights.
*
** Lleno primera tabla
*  lt_flights = VALUE #( FOR i = 1 UNTIL i > 15
*                        ( iduser     = | { 1234 + i } USER|
*                          aircode    = 'SQ'
*                          flightnum  = 0000 + i
*                          key        = 'US'
*                          seat       = 0 + i
*                          flightdate = cl_abap_context_info=>get_system_date( ) + i
*                          ) ).
*
** Lleno segunda tabla
*  lt_flights_info = VALUE #( FOR gs_flights IN lt_flights
*                        ( iduser     = gs_flights-iduser
*                          aircode    = 'CL'
*                          flightnum  = gs_flights-flightnum + 10
*                          key        = 'COP'
*                          seat       = gs_flights-seat
*                          flightdate = gs_flights-flightdate
*                          ) ).
*
*    out->write(
*      EXPORTING
*        data = lt_flights
*        name = 'LT_FLIGHTS - Datos Originales'
*    ).
*
*        out->write(
*      EXPORTING
*        data = lt_flights_info
*        name = 'LT_FLIGHTS - Datos Añadidos'
*    ).

**********************************************************************
* 2. FOR Anidado
**********************************************************************
"------------------------------------------------------------
" Declaración de tablas internas
"------------------------------------------------------------
*  DATA mt_flights_type TYPE STANDARD TABLE OF /dmo/flight.
*  DATA mt_airline      TYPE STANDARD TABLE OF /dmo/connection.

*  DATA lt_final TYPE SORTED TABLE OF ty_flights
*         WITH NON-UNIQUE KEY aircode.
*
*"------------------------------------------------------------
*" SELECT de /dmo/flight → MT_FLIGHTS_TYPE
*"------------------------------------------------------------
*    SELECT *
*      FROM /dmo/flight
*      INTO TABLE @mt_flights_type.
*
**    out->write(
**      EXPORTING
**        data = mt_flights_type
**        name = 'MT_FLIGHTS_TYPE - Datos de /dmo/flight'
**    ).
*
* "------------------------------------------------------------
* " SELECT * FROM /dmo/connection → MT_AIRLINE
* " Campos: carrier_id, connection_id, airport_from_id
* "------------------------------------------------------------
*    SELECT
*      FROM /dmo/connection
*      FIELDS carrier_id, connection_id, airport_from_id, airport_to_id
*      INTO TABLE @data(mt_airline).
*
*    out->write(
*      EXPORTING
*        data = mt_airline
*        name = 'MT_AIRLINE'
*    ).
*
* "------------------------------------------------------------
* " LOOP Anidado
* "------------------------------------------------------------
*  lt_final = VALUE #( FOR gs_final IN MT_FLIGHTS_TYPE
*                        WHERE ( carrier_id EQ 'SQ' )
*
*                        FOR gs_final2 IN mt_airline
*                          WHERE ( connection_id = gs_final-connection_id )
*
*                          ( iduser     = gs_final-client
*                            aircode    = gs_final-carrier_id
*                            flightnum  = gs_final2-connection_id
*                            key        = gs_final2-airport_from_id
*                            seat       = gs_final-seats_occupied
*                            flightdate = gs_final-flight_date ) ).
*
*    out->write(
*      EXPORTING
*        data = lt_final
*        name = 'MT_AIRLINE'
*    ).
*
*
* "------------------------------------------------------------
*" 3. Añadir múltiples líneas (SELECT)
*"------------------------------------------------------------
*" 1. Declarar el tipo local
*TYPES: BEGIN OF ty_airlines,
*         carrier_id       TYPE /dmo/carrier_id,
*         connection_id    TYPE /dmo/connection_id,
*         airport_from_id  TYPE /dmo/airport_from_id,
*         airport_to_id    TYPE /dmo/airport_to_id,
*       END OF ty_airlines.
*
*" 2. Declarar la tabla interna basada en el tipo
*DATA mt_airlines TYPE STANDARD TABLE OF ty_airlines WITH EMPTY KEY.
*
*" 3. SELECT sobre la tabla interna MT_AIRLINE
*SELECT carrier_id,
*       connection_id,
*       airport_from_id,
*       airport_to_id
*  FROM @mt_airline as gt
**  WHERE airport_from_id = 'FRA'
*  INTO TABLE @mt_airlines.
*
*" Mostrar resultado
*out->write(
*  EXPORTING
*    data = mt_airlines
*    name = 'Registros con airport_from_id = FRA'
*).
*
*" 4. Ordenar registros (SORT)
*SORT mt_airlines BY connection_id DESCENDING.
*
*out->write(
*  EXPORTING
*    data = mt_airlines
*    name = 'MT_AIRLINES ordenada'
*).

*"------------------------------------------------------------
*" 5. Modificar registros
*"------------------------------------------------------------
*DATA lv_current_time TYPE d.
**lv_current_time = cl_abap_context_info=>get_system_time( ).
*lv_current_time = '20270411'.
*
*LOOP AT mt_flights_type ASSIGNING FIELD-SYMBOL(<ls_mt_flights_type>).
*
*  IF <ls_mt_flights_type>-flight_date > '20270301'.
*    <ls_mt_flights_type>-flight_date = lv_current_time.
*    MODIFY mt_flights_type FROM <ls_mt_flights_type>.
*  ENDIF.
*
*ENDLOOP.
*
*out->write(
*  EXPORTING
*    data = mt_flights_type
*    name = 'MT_FLIGHTS_TYPE - Horas modificadas'
*).
*
*"------------------------------------------------------------
*" 6. Eliminar registros
*"------------------------------------------------------------
*LOOP AT mt_airlines ASSIGNING FIELD-SYMBOL(<ls_airline>).
*
*  IF <ls_airline>-airport_to_id = 'FRA'.
*    DELETE mt_airlines INDEX sy-tabix.
*  ENDIF.
*
*ENDLOOP.
*
*out->write(
*  EXPORTING
*    data = mt_airlines
*    name = 'MT_AIRLINES - Registros sin destino FRA'
*).
*
*"------------------------------------------------------------
*" 7. CLEAR / FREE
*"------------------------------------------------------------
*
*CLEAR mt_airlines.   "Limpia la tabla interna (queda vacía, pero con memoria reservada)
*FREE  mt_airlines.   "Libera la memoria asociada a la tabla interna
*
*"------------------------------------------------------------
*" 8. Instrucción COLLECT
*"------------------------------------------------------------
*DATA lt_seats   TYPE HASHED TABLE OF ty_seats
*       WITH UNIQUE KEY carrier_id connection_id.
*
*DATA lt_seats_2 TYPE STANDARD TABLE OF ty_seats.
*
*"------------------------------------------------------------
*" Inserción comprimida → LT_SEATS
*"------------------------------------------------------------
*SELECT carrier_id,
*       connection_id,
*       seats_occupied,
*       price,
*       seats_max
*  FROM /dmo/flight
*  WHERE seats_max = 140
*  INTO TABLE @DATA(lt_flight_filtered).
*
*LOOP AT lt_flight_filtered ASSIGNING FIELD-SYMBOL(<ls_flight>).
*
*" Agrupa por carrier_id + connection_id
*" Suma automáticamente seats_occupied y price
*  COLLECT VALUE ty_seats(
*    carrier_id     = <ls_flight>-carrier_id
*    connection_id  = <ls_flight>-connection_id
*    seats_occupied = <ls_flight>-seats_occupied
*    price          = <ls_flight>-price
*    seats_max      = <ls_flight>-seats_max
*  ) INTO lt_seats.
*
*ENDLOOP.
*
*"------------------------------------------------------------
*" SELECT → LT_SEATS_2
*"------------------------------------------------------------
*SELECT carrier_id,
*       connection_id,
*       seats_occupied,
*       price,
*       seats_max
*  FROM /dmo/flight
*  INTO TABLE @lt_seats_2.
*
*"------------------------------------------------------------
*" COLLECT → Agrupación final
*"------------------------------------------------------------
*" Agrupa por carrier_id + connection_id
*" Suma automáticamente seats_occupied y price
*
*LOOP AT lt_seats_2 ASSIGNING FIELD-SYMBOL(<ls_seats2>).
*
*  COLLECT <ls_seats2> INTO lt_seats.
*
*ENDLOOP.
*
*out->write(
*  EXPORTING
*    data = lt_seats
*    name = 'LT_SEATS - Agrupación con COLLECT'
*).
*
"------------------------------------------------------------
" 9. Instrucción LET
"------------------------------------------------------------
"------------------------------------------------------------
" Declaración de tablas internas
"------------------------------------------------------------
DATA mt_flights_type TYPE STANDARD TABLE OF /dmo/flight.
DATA mt_scarr        TYPE STANDARD TABLE OF /dmo/carrier.

"------------------------------------------------------------
" SELECT de /dmo/flight → MT_FLIGHTS_TYPE
"------------------------------------------------------------
SELECT FROM /dmo/flight
    FIELDS *
    INTO TABLE @mt_flights_type.

"------------------------------------------------------------
" SELECT de /dmo/carrier → MT_SCARR
"------------------------------------------------------------
SELECT FROM /dmo/carrier
    FIELDS *
    INTO TABLE @mt_scarr.
*
*"------------------------------------------------------------
*" LOOP + LET dentro de VALUE (estilo Logali)
*"------------------------------------------------------------
*LOOP AT mt_flights_type INTO DATA(ls_flights_let).
*
*  DATA(lv_flights) = CONV string( LET lv_scarr  = mt_scarr[ carrier_id = ls_flights_let-carrier_id ]-carrier_id
*                                      lv_flight = mt_flights_type[ carrier_id    = ls_flights_let-carrier_id
*                                                                   connection_id = ls_flights_let-connection_id ]-price
*                                  IN | / Airline ID: { lv_scarr } / Flight Price: { lv_flight } | ).
*
*  out->write( data = lv_flights ).
*
*  EXIT.
*
*ENDLOOP.
*
**********************************************************************
* 10. Instrucción BASE
**********************************************************************
*"------------------------------------------------------------
*" Declaración de tablas internas
*"------------------------------------------------------------
*DATA lt_flights_base TYPE STANDARD TABLE OF /dmo/flight.
*
*"------------------------------------------------------------
*" BASE: copiar registros desde MT_FLIGHTS_TYPE
*"------------------------------------------------------------
*out->write(
*  EXPORTING
*    data = lt_flights_base
*    name = 'Initial LT_FLIGHTS_BASE' ).
*
*" Forma 1
**  lt_flights_base = VALUE #( BASE lt_flights_base ( LINES OF mt_flights_type ) ).
*
*"Forma 2
*  lt_flights_base = CORRESPONDING #( BASE ( lt_flights_base ) mt_flights_type ).
*
*out->write(
*  EXPORTING
*    data = lt_flights_base
*    name = 'LT_FLIGHTS_BASE - Copia con BASE'
*).

**********************************************************************
* 11. Agrupación de registros
**********************************************************************
**********************************************************************
* 2.11. Agrupación de registros
**********************************************************************

"------------------------------------------------------------
" Declaración de tablas internas
"------------------------------------------------------------
DATA mt_spfli TYPE STANDARD TABLE OF /dmo/connection.

"------------------------------------------------------------
" SELECT de /dmo/connection → MT_SPFLI
"------------------------------------------------------------
SELECT FROM /dmo/connection
  FIELDS *
  INTO TABLE @mt_spfli.

"------------------------------------------------------------
" Agrupación por airport_from_id
"------------------------------------------------------------
LOOP AT mt_spfli INTO DATA(ls_spfli)

     GROUP BY ls_spfli-airport_from_id.

*  out->write(
*    EXPORTING
*      data = ls_spfli
*      name = |Grupo: { ls_spfli-airport_from_id }|
*  ).

"------------------------------------------------------------
  " Miembros del grupo
  "------------------------------------------------------------
  LOOP AT GROUP ls_spfli ASSIGNING FIELD-SYMBOL(<member>).

    out->write(
      EXPORTING
        data = <member>
        name = |Grupo: { ls_spfli-airport_from_id }|
    ).

  ENDLOOP.

" PRUEBA Push.

ENDLOOP.

 ENDMETHOD.
ENDCLASS.
