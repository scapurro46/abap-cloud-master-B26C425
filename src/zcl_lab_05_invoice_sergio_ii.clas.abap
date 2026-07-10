CLASS zcl_lab_05_invoice_sergio_ii DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
     INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_05_invoice_sergio_ii IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

**********************************************************************
* 1. OVERLAY
**********************************************************************

*DATA(lv_sale)        = 'Purchase Completed'.
*DATA(lv_sale_status) = 'Invoice'.
*
*OVERLAY lv_sale WITH lv_sale_status.
*
*out->write( |Valor lv_sale: { lv_sale }| ).
*out->write( |Valor lv_sale_status: { lv_sale_status }| ).
*out->write( |Resultado OVERLAY: { lv_sale }| ).


**********************************************************************
* 2. Función SUBSTRING
**********************************************************************
*DATA(lv_result) = 'SAP-ABAP-32-PE'.
*
*" Extraer desde posición 9 a 14 usando SUBSTRING
*lv_result = substring( val = lv_result off = 8 len = 6 ).
*
*out->write( |Antes de ABAP: SAP-| ).
*out->write( |Después de ABAP: { lv_result }| ).


**********************************************************************
* 3.    FIND
**********************************************************************
*DATA(lv_status) = 'INVOICE GENERATED SUCCESSFULLY'.
*
*" Buscar cualquiera de los caracteres G, E o N
*DATA(lv_count) = FIND_ANY_OF( val = lv_status sub = 'GEN' ).
*
*" Mostrar por pantalla  la posición real de los caracteres buscados.
*DATA(lv_pos) = sy-fdpos + 1.
*
*out->write( |Texto: { lv_status }| ).
*out->write( |Posición real de GEN: { lv_pos }| ).
*
*" Contar cantidad de letras A usando COUNT()
*lv_count = count( val = lv_status sub = 'A' ).
*
*out->write( |Cantidad de letras A: { lv_count }| ).

**********************************************************************
* 4. REPLACE
**********************************************************************
*DATA(lv_request) = 'SAP-ABAP-32-PE'.
*
*out->write( |Antes del REPLACE: { lv_request }| ).
*
*REPLACE ALL OCCURRENCES OF '-' IN lv_request WITH '/'.
*
*out->write( |Después del REPLACE: { lv_request }| ).

**********************************************************************
* 5. PCRE Regex
**********************************************************************
*DATA(lv_regex) = '^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$'.
*DATA(lv_email) = 'sergio@example.com'.
*
*" Validar el correo con FIND REGEX
*FIND REGEX lv_regex IN lv_email.
*
*IF sy-subrc EQ 0.
*    out->write( |Correo válido: { lv_email }| ).
*ELSE.
*    out->write( |Correo inválido: { lv_email }| ).
*ENDIF.

**********************************************************************
* 6. Expresiones regulares
**********************************************************************
*DATA(lv_idcustomer) = '0000012345'.
*DATA(lv_regex)      = '0*'.
*
*out->write( |Antes: { lv_idcustomer }| ).
*
*lv_idcustomer = replace( val = lv_idcustomer
*                    pcre = lv_regex
*                    with = ''
*                    occ = 1 ).
*
*out->write( |Después: { lv_idcustomer }| ).

**********************************************************************
* 7.    Repetición de strings
**********************************************************************
*DATA(lv_idcustomer) = '12345'.   " Reutilizada del punto anterior
*
*DATA(lv_repeat) = repeat( val = lv_idcustomer occ = 3 ).
*
*
*out->write( |Resultado REPEAT: { lv_repeat }| ).

**********************************************************************
* 8.    Función ESCAPE
**********************************************************************
DATA(lv_format) = 'Send payment data via Internet'.

" URL
DATA(lv_url) = escape(
    val    = lv_format
    format = cl_abap_format=>e_url_full
).
out->write( |URL: { lv_url }| ).

" JSON
DATA(lv_json) = escape(
    val    = lv_format
    format = cl_abap_format=>e_json_string
).
out->write( |JSON: { lv_json }| ).

" String Templates
DATA(lv_string_tpl) = escape(
    val    = lv_format
    format = cl_abap_format=>e_string_tpl
).
out->write( |String Template: { lv_string_tpl }| ).

" Con carácter especial
DATA(lv_format_2) = 'Special "chars" in |templates| and \slashes\ {here}'.

DATA(lv_json_2) = escape(
  val    = lv_format_2
  format = cl_abap_format=>e_json_string
).

out->write( |Con caracter especial: | ).
out->write( |JSON: { lv_json_2 }| ).

DATA(lv_string_tpl_2) = escape(
  val    = lv_format_2
  format = cl_abap_format=>e_string_tpl
).
out->write( |String Template: { lv_string_tpl_2 }| ).



  ENDMETHOD.

ENDCLASS.
