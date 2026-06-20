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
DATA: MV_INVOICE_NUM TYPE string VALUE '2015ABCD'.

" Eliminar 2 caracteres al inicio
  SHIFT MV_INVOICE_NUM BY 2 PLACES LEFT.
  MV_INVOICE_NUM = shift_right( val = MV_INVOICE_NUM places = 2 ).

" Mostrar resultado
  out->write( |Resultado SHIFT : { mv_invoice_num }| ).

**********************************************************************
* 6. Funciones STRLEN y NUMOFCHAR
**********************************************************************
DATA: MV_RESPONSE    TYPE string VALUE ' Generating Invoice ',
      MV_COUNT       TYPE string.
  ENDMETHOD.
ENDCLASS.
