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

ENDCLASS.



CLASS ZCL_LAB_07_TABLES_SERGIO_II IMPLEMENTATION.


 METHOD if_oo_adt_classrun~main.

**********************************************************************
* 1. FOR
**********************************************************************
 DATA: lt_flights      TYPE STANDARD TABLE OF ty_flights,
       lt_flights_info TYPE STANDARD TABLE OF ty_flights.

* Lleno primera tabla
  lt_flights = VALUE #( FOR i = 1 UNTIL i > 15
                        ( iduser     = | { 1234 + i } USER|
                          aircode    = 'SQ'
                          flightnum  = 0000 + i
                          key        = 'US'
                          seat       = 0 + i
                          flightdate = cl_abap_context_info=>get_system_date( ) + i
                          ) ).

* Lleno segunda tabla
  lt_flights_info = VALUE #( FOR gs_flights IN lt_flights
                        ( iduser     = gs_flights-iduser
                          aircode    = 'CL'
                          flightnum  = gs_flights-flightnum + 10
                          key        = 'COP'
                          seat       = gs_flights-seat
                          flightdate = gs_flights-flightdate
                          ) ).

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
  DATA mt_flights_type TYPE STANDARD TABLE OF /dmo/flight.
*  DATA mt_airline      TYPE STANDARD TABLE OF /dmo/connection.

  DATA lt_final TYPE SORTED TABLE OF ty_flights
         WITH NON-UNIQUE KEY aircode.

"------------------------------------------------------------
" SELECT de /dmo/flight → MT_FLIGHTS_TYPE
"------------------------------------------------------------
    SELECT *
      FROM /dmo/flight
      INTO TABLE @mt_flights_type.

*    out->write(
*      EXPORTING
*        data = mt_flights_type
*        name = 'MT_FLIGHTS_TYPE - Datos de /dmo/flight'
*    ).

 "------------------------------------------------------------
 " SELECT * FROM /dmo/connection → MT_AIRLINE
 " Campos: carrier_id, connection_id, airport_from_id
 "------------------------------------------------------------
    SELECT
      FROM /dmo/connection
      FIELDS carrier_id, connection_id, airport_from_id, airport_to_id
      INTO TABLE @data(mt_airline).

*    out->write(
*      EXPORTING
*        data = mt_airline
*        name = 'MT_AIRLINE'
*    ).

 "------------------------------------------------------------
 " LOOP Anidado
 "------------------------------------------------------------
  lt_final = VALUE #( FOR gs_final IN MT_FLIGHTS_TYPE
                        WHERE ( carrier_id EQ 'SQ' )

                        FOR gs_final2 IN mt_airline
                          WHERE ( connection_id = gs_final-connection_id )

                          ( iduser     = gs_final-client
                            aircode    = gs_final-carrier_id
                            flightnum  = gs_final2-connection_id
                            key        = gs_final2-airport_from_id
                            seat       = gs_final-seats_occupied
                            flightdate = gs_final-flight_date ) ).

    out->write(
      EXPORTING
        data = lt_final
        name = 'MT_AIRLINE'
    ).


 "------------------------------------------------------------
" 3. Añadir múltiples líneas (SELECT)
"------------------------------------------------------------
" 1. Declarar el tipo local
TYPES: BEGIN OF ty_airlines,
         carrier_id       TYPE /dmo/carrier_id,
         connection_id    TYPE /dmo/connection_id,
         airport_from_id  TYPE /dmo/airport_from_id,
         airport_to_id    TYPE /dmo/airport_to_id,
       END OF ty_airlines.

" 2. Declarar la tabla interna basada en el tipo
DATA mt_airlines TYPE STANDARD TABLE OF ty_airlines WITH EMPTY KEY.

" 3. SELECT sobre la tabla interna MT_AIRLINE
SELECT carrier_id,
       connection_id,
       airport_from_id,
       airport_to_id
  FROM @mt_airline as gt
  INTO TABLE @mt_airlines.

" Mostrar resultado
out->write(
  EXPORTING
    data = mt_airlines
    name = 'Registros con airport_from_id = FRA'
).


 ENDMETHOD.
ENDCLASS.
