CLASS zcl_lab_04_message_sergio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_04_message_sergio IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**********************************************************************
* 1. Símbolos de texto
**********************************************************************
" Crear símbolo de texto con ID “001” y texto “Test with text symbols”

*  out->write( text-001 ).

**********************************************************************
* 2. Funciones de descripción
**********************************************************************
" Declaraciones
DATA: LV_ORDER_STATUS TYPE string
                      VALUE 'Purchase Completed Successfully',
      LV_CHAR_NUMBER  TYPE I.

*" Contar la longitud de caracteres de la primera variable
*  lv_char_number = strlen( lv_order_status ).
*  out->write( |STRLEN: { lv_char_number }| ).
*
*  lv_char_number = numofchar( lv_order_status ).
*  out->write( |NUMOFCHAR: { lv_char_number }| ).
*
*" Contar cantidad de “A” (sin distinguir may/min)
*  lv_char_number = count( val = lv_order_status sub = 'A' case = abap_false ).
*  out->write( |Cantidad de A: { lv_char_number }| ).
*
*" Encontrar posición del patrón “Exit”
*  FIND 'Exit' IN lv_order_status MATCH OFFSET lv_char_number.
*  out->write( |Posición de 'Exit': { lv_char_number }| ).

**********************************************************************
* 3. Funciones de procesamiento
**********************************************************************
*" Mayúsculas, minúsculas y mixto
*  out->write( to_upper( lv_order_status ) ).
*  out->write( to_lower( lv_order_status ) ).
*  out->write( to_mixed( lv_order_status ) ).
*
*" Desplazar los 9 primeros caracteres al final
*  DATA(lv_shifted) = shift_left( val = lv_order_status places = 9 ).
*  out->write( lv_shifted ).
*
*" Extraer la palabra “Completed”
*  DATA(lv_completed) = substring( val = lv_order_status off = 9 len = 9 ).
*  out->write( lv_completed ).
*
*  DATA(lv_completed_2) = substring_after( val = lv_order_status sub = 'Purchase ' ).
*  lv_completed_2 = substring_before( val = lv_completed_2 sub = ' Successfully' ).
*  out->write( lv_completed_2 ).
*
*" Revertir el orden de los caracteres
*  DATA(lv_reverse) = reverse( lv_order_status ).
*  out->write( lv_reverse ).

**********************************************************************
* 4. Funciones de contenido (CONTAINS)
**********************************************************************
" Declarar las siguientes variables del tipo “STRING”:
  DATA lv_pattern TYPE string VALUE `\d{3}-\d{3}-\d{4}`.
  DATA lv_phone   TYPE string VALUE '123-456-7890'.

" Validar utilizando la función “CONTAINS()” el teléfono ingresado
*  IF contains( val = lv_phone pcre = lv_pattern ).
*    out->write( | { lv_phone } 'Formato de teléfono válido' | ).
*  ELSE.
*    out->write( | { lv_phone } 'Formato de teléfono inválido' | ).
*  ENDIF.

**********************************************************************
* 5. Funciones con expresiones regulares
**********************************************************************
" Declarar las siguientes variables del tipo “STRING”:
  DATA LV_EMAIL TYPE string VALUE 'kpu.motion@gmail.com'.
  DATA LV_PATTER TYPE string VALUE `\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b`.

" validar si el correo contiene el formato correcto.
  IF contains( val = lv_email pcre = lv_pattern ).
    out->write( | { lv_email } 'Formato de email válido' | ).
  ELSE.
    out->write( | { lv_email } 'Formato de email inválido' | ).
  ENDIF.

  ENDMETHOD.

ENDCLASS.
