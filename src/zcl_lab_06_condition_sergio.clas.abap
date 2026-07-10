CLASS zcl_lab_06_condition_sergio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
       INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
*   METHODS validate_value
*      IMPORTING iv_string TYPE string
*      RETURNING VALUE(rv_result) TYPE string.
   METHODS validate_switch
      IMPORTING iv_string TYPE string
      RETURNING VALUE(rv_result) TYPE string.
ENDCLASS.



CLASS zcl_lab_06_condition_sergio IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

**********************************************************************
* 1. IF / ENDIF
**********************************************************************
*  DATA LV_CONDITIONAL TYPE I VALUE '7'.
*
*" Caso valor igual a 7
*  IF LV_CONDITIONAL EQ '7'.
*    out->write( |El Valor es IGUAL: { LV_CONDITIONAL }| ).
*  ELSE.
*    out->write( |El Valor es DISTINTO: { LV_CONDITIONAL }| ).
*  ENDIF.
*
* " Caso valor distinto de  7
*  LV_CONDITIONAL = '1'.
*  IF LV_CONDITIONAL EQ '7'.
*    out->write( |El Valor es IGUAL: { LV_CONDITIONAL }| ).
*  ELSE.
*    out->write( |El Valor es DISTINTO: { LV_CONDITIONAL }| ).
*  ENDIF.

**********************************************************************
* 2. CASE /ENDCASE
**********************************************************************
*DATA lv_string TYPE string.
*DATA lv_output TYPE string.
*
*    " Escenario 1: LOGALI
*    lv_string = 'LOGALI'.
*    lv_output = validate_value( lv_string ).
*    out->write( |Entrada: { lv_string } -> Resultado: { lv_output }| ).
*
*    " Escenario 2: SAP
*    lv_string = 'SAP'.
*    lv_output = validate_value( lv_string ).
*    out->write( |Entrada: { lv_string } -> Resultado: { lv_output }| ).
*
*    " Escenario 3: Otro valor
*    lv_string = 'HELLO'.
*    lv_output = validate_value( lv_string ).
*    out->write( |Entrada: { lv_string } -> Resultado: { lv_output }| ).
*
*  ENDMETHOD.
*
*  METHOD validate_value.

*    CASE iv_string.
*      WHEN 'LOGALI'.
*        rv_result = 'Academy'.
*
*      WHEN 'SAP'.
*        rv_result = 'Enterprise software'.
*
*      WHEN OTHERS.
*        rv_result = 'Unknown'.
*    ENDCASE.
*
*  ENDMETHOD.

**********************************************************************
* 3. DO / ENDDO
**********************************************************************
*DATA(lv_counter) = 0.
*
*DO 10 TIMES.
*  lv_counter = lv_counter + 1.
*  out->write( |Iteración { sy-index }: Valor del contador = { lv_counter }| ).
*ENDDO.

**********************************************************************
* 4. CHECK
**********************************************************************
*DATA(lv_counter) = 0.
*
*DO 10 TIMES.
*
*  lv_counter = lv_counter + 1.
*
*  " Terminar el ciclo en la séptima vuelta
*  CHECK lv_counter <= 7.
*
*  out->write( |Iteración { sy-index }: Valor del contador = { lv_counter }| ).
*
*ENDDO.

**********************************************************************
* 5. SWITCH
**********************************************************************
DATA: lv_string_2 TYPE string,
      lv_output_2 TYPE string.

" Escenario 1: LOGALI
lv_string_2 = 'LOGALI'.
lv_output_2 = validate_switch( lv_string_2 ).
out->write( |Entrada: { lv_string_2 } -> Resultado: { lv_output_2 }| ).

" Escenario 2: SAP
lv_string_2 = 'SAP'.
lv_output_2 = validate_switch( lv_string_2 ).
out->write( |Entrada: { lv_string_2 } -> Resultado: { lv_output_2 }| ).

" Escenario 3: MOVISTAR
lv_string_2 = 'MOVISTAR'.
lv_output_2 = validate_switch( lv_string_2 ).
out->write( |Entrada: { lv_string_2 } -> Resultado: { lv_output_2 }| ).

" Escenario 4: Otro valor
lv_string_2 = 'HELLO'.
lv_output_2 = validate_switch( lv_string_2 ).
out->write( |Entrada: { lv_string_2 } -> Resultado: { lv_output_2 }| ).

ENDMETHOD.

METHOD validate_switch.

  rv_result = SWITCH string( iv_string
      WHEN 'LOGALI'    THEN 'SAP Academy'
      WHEN 'SAP'       THEN 'Enterprise software'
      WHEN 'MOVISTAR'  THEN 'Telephony'
      ELSE 'Unknown'
  ).

ENDMETHOD.

ENDCLASS.
