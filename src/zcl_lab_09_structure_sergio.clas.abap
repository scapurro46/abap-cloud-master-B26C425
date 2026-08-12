CLASS zcl_lab_09_structure_sergio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
         INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_09_structure_sergio IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
*  "***** Punto 1:
" Declaración de estructuras.
  TYPES:BEGIN OF TY_FLIGHTS,
    IDUSER     TYPE C LENGTH 40,
    AIRCODE    TYPE /dmo/carrier_id,
    FLIGHTNUM  TYPE /dmo/connection_id,
    KEY        TYPE land1,
    SEAT       TYPE /dmo/plane_seats_occupied,
    FLIGHTDATE TYPE /dmo/flight_date,
  END OF TY_FLIGHTS.

   TYPES:BEGIN OF TY_AIRLINES,
    CARRID    TYPE /dmo/carrier_id,
    CONNID    TYPE /dmo/connection_id,
    COUNTRYFR TYPE land1,
    CITYFROM  TYPE /dmo/city,
    AIRPFROM  TYPE /dmo/airport_id,
    COUNTRYTO TYPE land1,
  END OF TY_AIRLINES.

*  "***** Punto 2:
" Estructuras anidadas (NESTED)
  DATA: BEGIN OF LS_NESTED,
         flights  TYPE ty_flights,
         airlines TYPE ty_airlines,
         END OF LS_NESTED.

*  "***** Punto 3:
" Estructuras complejas (DEEP)
  DATA: BEGIN OF LS_DEEP,
         carrid  TYPE /dmo/carrier_id,
         connid  TYPE /dmo/connection_id,
         flights TYPE TABLE OF TY_FLIGHTS,
        END OF LS_DEEP.

*  "***** Punto 4:
" Añadir datos
" Estructura NESTED (TY_NESTED)
  LS_NESTED = VALUE #(
                flights = VALUE #(  iduser     = 'SERGIO'
                                    aircode    = 'AA'
                                    flightnum  = '0017'
                                    key        = 'AR'
                                    seat       = 120
                                 flightdate = '20250101' )
                airlines = VALUE #(  carrid    = 'AA'
                                     connid    = '0017'
                                     countryfr = 'AR'
                                     cityfrom  = 'BUENOS_AIRES'
                                     airpfrom  = 'EZE'
                                     countryto = 'US' )  ).

  out->write( data = LS_NESTED name = 'NESTED: FLIGHTS & AIRLINES' ).

 "***** Estructura DEEP (TY_DEEP)
  LS_DEEP = VALUE #(
                carrid = 'AA'
                connid = '0017'
                flights = VALUE #(
                    ( iduser     = 'SERGIO'
                      aircode    = 'AA'
                      flightnum  = '0017'
                      key        = 'AR'
                      seat       = 120
                      flightdate = '20250101'  )
                     )
   ).

  out->write( data = LS_DEEP name = 'DEEP: FLIGHTS & AIRLINES' ).


"***** Punto 5: Estructura INCLUDE
*TYPES BEGIN OF ty_include_flights.
*         INCLUDE TYPE ty_flights.
*         INCLUDE TYPE ty_airlines.
*TYPES END OF ty_include_flights.
*
*DATA ls_include TYPE ty_include_flights.
*
*" Campos de TY_FLIGHTS
*ls_include-iduser     = 'SERGIO'.
*ls_include-aircode    = 'AA'.
*ls_include-flightnum  = '0017'.
*ls_include-key        = 'AR'.
*ls_include-seat       = 120.
*ls_include-flightdate = '20250101'.
*
*" Campos de TY_AIRLINES
*ls_include-carrid    = 'AA'.
*ls_include-connid    = '0017'.
*ls_include-countryfr = 'AR'.
*ls_include-cityfrom  = 'BUENOS_AIRES'.
*ls_include-airpfrom  = 'EZE'.
*ls_include-countryto = 'US'.
*
*out->write( ls_include ).


"***** Punto 6: Eliminar datos
" Borrar IDUSER y AIRCODE de NESTED
ls_nested-flights-iduser = ''.
ls_nested-flights-aircode = ''.

  out->write( data = LS_NESTED name = 'DEEP: BORRAR' ).

" Borrar completa DEEP
CLEAR ls_deep.

  out->write( data = LS_DEEP name = 'DEEP: BORRAR' ).


  ENDMETHOD.

ENDCLASS.
