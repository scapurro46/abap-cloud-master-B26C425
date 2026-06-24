CLASS zcl_lab_05_invoice_sergio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_05_invoice_sergio IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

**********************************************************************
* 1. Concatenación
**********************************************************************

" Declaración de variables
*DATA: MV_EXERCISE   TYPE N LENGTH 4,
*      MV_INVOICE_NO TYPE N LENGTH 8,
*      MV_INVOICE_CODE TYPE string.
*
*" Asignación de valores
*  MV_EXERCISE   = 1234.
*  MV_INVOICE_NO = 12345678.
*
*" Concatenación con separador '/'
*  MV_INVOICE_CODE = |{ MV_EXERCISE }/{ MV_INVOICE_NO }|.
*  CONCATENATE MV_EXERCISE MV_INVOICE_NO INTO DATA(MV_INVOICE_CODE_2) SEPARATED BY '/'.
*
*" Mostrar resultado
*    out->write( |Código de factura generado: { MV_INVOICE_CODE } / { MV_INVOICE_CODE_2 }| ).

**********************************************************************
* 2. Concatenaciones líneas de Tablas
**********************************************************************
*
*" SELECT a la tabla
*  SELECT FROM /dmo/flight
*    FIELDS carrier_id
*    INTO TABLE @DATA(lt_employees).
*
*" Concatenar con espacio
*  DATA(LV_STRING_ITAB) = CONCAT_LINES_OF( table = lt_employees sep = ` ` ).
*
*  out->write( |Datos del empleado: { LV_STRING_ITAB }| ).
*
**********************************************************************
* 3. Condensación
**********************************************************************
*
*" Declaración de variables
*DATA: MV_CASE1 TYPE STRING,
*      MV_CASE2 TYPE STRING.
*
*  MV_CASE1 = 'Sales invoice with status in     process'.
*  MV_CASE2 = '***ABAP*Cloud***'.
*
*" Valos incial.
*  out->write( |Valor inicial: { MV_CASE1 }| ).
*
*" Valor sin espacios de más.
*  CONDENSE MV_CASE1.
*  out->write( |Valor sin espacios de más: { MV_CASE1 }| ).
*
*" Valor sin espacios.
*  CONDENSE MV_CASE1 NO-GAPS.
*  out->write( |Valor sin espacios: { MV_CASE1 }| ).
*
*" Valor sin asteriscos.
*  REPLACE ALL OCCURRENCES OF `*` IN MV_CASE2 WITH ` `.
*" Elimino espacios de más.
*  CONDENSE MV_CASE2.
*  out->write( |Valor sin asteriscos: { MV_CASE2 }| ).
*
**********************************************************************
* 4. Split
**********************************************************************
*DATA: MV_DATA TYPE string VALUE '0001111111;LOGALI GROUP;2024',
*      MV_ID_CUSTOMER TYPE string,
*      MV_CUSTOMER TYPE string,
*      MV_YEAR TYPE string.
*
* " Separa el valor de la primera variable en las secciones separadas
* " por el carácter “;” y asigna los valores en el resto de ellas con
* " la instrucción “SPLIT”.
*
*  SPLIT MV_DATA AT `;` INTO MV_ID_CUSTOMER MV_CUSTOMER MV_YEAR.
*
*" Mostrar resultados
*  out->write( |ID Customer: { mv_id_customer }| ).
*  out->write( |Customer:    { mv_customer }| ).
*  out->write( |Year:        { mv_year }| ).
*
**********************************************************************
* 5. Shift
**********************************************************************
*DATA: MV_INVOICE_NUM TYPE string VALUE '2015ABCD'.
*
*" Eliminar 2 caracteres al inicio
*  SHIFT MV_INVOICE_NUM BY 2 PLACES LEFT.
*  MV_INVOICE_NUM = shift_right( val = MV_INVOICE_NUM places = 2 ).
*
*" Mostrar resultado
*  out->write( |Resultado SHIFT : { mv_invoice_num }| ).

**********************************************************************
* 6. Funciones STRLEN y NUMOFCHAR
**********************************************************************
*DATA mv_response TYPE string.
*DATA mv_count    TYPE i.
*
*mv_response = ' Generating Invoice '. "con espacios al inicio y final
*
*" STRLEN: cuenta absolutamente todos los caracteres
*mv_count = strlen( mv_response ).
*out->write( |STRLEN: { mv_count }| ).
*
*" NUMOFCHAR: ignora espacios en blanco
*mv_count = numofchar( mv_response ).
*out->write( |NUMOFCHAR: { mv_count }| ).
*" En ABAP Cloud, donde NUMOFCHAR no elimina espacios.
*
*" Opciones
*mv_count = numofchar( condense( mv_response ) ).
*out->write( |NUMOFCHAR: { mv_count }| ).
*
*mv_count = strlen( condense( mv_response ) ).
*out->write( |NUMOFCHAR: { mv_count }| ).

**********************************************************************
* 7. Funciones TO_LOWER y TO_UPPER
**********************************************************************
*DATA mv_translate_invoice TYPE string.
*
*mv_translate_invoice = 'Report the issuance of this invoice'.
*
*" Convertir a mayúsculas
*TRANSLATE mv_translate_invoice TO UPPER CASE.
*out->write( |MAYÚSCULAS: { mv_translate_invoice }| ).
*
*" Convertir a minúsculas
*TRANSLATE mv_translate_invoice TO LOWER CASE.
*out->write( |MINÚSCULAS: { mv_translate_invoice }| ).
*
*" Otra forma para ABAP Cloud
*mv_translate_invoice = to_upper( mv_translate_invoice ).
*out->write( |MAYÚSCULAS: { mv_translate_invoice }| ).
*
*mv_translate_invoice = to_lower( mv_translate_invoice ).
*out->write( |MINÚSCULAS: { mv_translate_invoice }| ).

**********************************************************************
* 8. Función INSERT y REVERSE
**********************************************************************
DATA mv_translate_invoice TYPE string.

mv_translate_invoice = 'Report the issuance of this invoice'.

" INSERT como función → agrega al final
mv_translate_invoice =
  insert(
    val = mv_translate_invoice
    sub = ' to client'
    off = strlen( mv_translate_invoice ) ).

out->write( |INSERT: { mv_translate_invoice }| ).

" REVERSE como función
mv_translate_invoice = reverse( mv_translate_invoice ).
out->write( |REVERSE: { mv_translate_invoice }| ).


  ENDMETHOD.
ENDCLASS.
