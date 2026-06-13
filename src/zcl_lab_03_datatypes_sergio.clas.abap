CLASS zcl_lab_03_datatypes_sergio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_03_datatypes_sergio IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.

**********************************************************************
* 1. Conversiones de Tipo
**********************************************************************
" Declarar las siguientes variables:
DATA: MV_CHAR  TYPE c LENGTH 10 VALUE '12345',
      MV_NUM   TYPE i,
      MV_FLOAT TYPE f.

"Convierte el valor de MV_CHAR a un número entero.
  MV_NUM = MV_CHAR.
*
"Convierte el valor de MV_CHAR a un número de punto flotante.
  MV_FLOAT = mv_char.
*
*" Muestra el resultado.
*  out->write( |1. Conversiones de Tipo | ).
*  out->write( |Número Entero: { mv_num }| ).
*  out->write( |Punto Flotante: { mv_float }| ).

**********************************************************************
* 2. Truncamiento y Redondeo
**********************************************************************
" Declarar las siguientes variables del tipo “I”:
DATA: MV_TRUNC TYPE i,
      MV_ROUND TYPE i.

" Reutilizar la variable MV_FLOAT, asignando el valor decimal 123.45”
  CLEAR: MV_FLOAT.
  MV_FLOAT = '123.45'.

" Trunca el valor en la primera variable.
  MV_TRUNC = MV_FLOAT.

" Redondea el valor en la segunda variable sumándole el valor “0,5”
  MV_ROUND = MV_TRUNC.

*" Muestra el resultado.
*  out->write( |2. Truncamiento y Redondeo | ).
*  out->write( |Truncamiento: {  MV_TRUNC }| ).
*  out->write( |Redondeo: { MV_ROUND }| ).

**********************************************************************
*  3. Tipos en declaraciones en línea
**********************************************************************
" Declarar una variable en línea con el valor “ABAP”.
*DATA(LV_TEXT) = 'ABAP'.


**********************************************************************
* 4. Conversiones del Tipo Forzado
**********************************************************************
*" Reutilizar MV_CHAR y MV_NUM
*" MV_CHAR tiene valor '12345'
**CLEAR: MV_NUM.
*
*MV_NUM = CONV i( MV_CHAR ).
*
*out->write( |4. Conversion Forzada| ).
*out->write( |Valor original (char): { MV_CHAR }| ).
*out->write( |Valor convertido (int): { MV_NUM }| ).


**********************************************************************
* 5. Cálculo de Fecha y Hora
**********************************************************************
" Declarar las siguientes variables.
DATA: MV_DATE_1 TYPE D VALUE '20260101',
      MV_DATE_2 TYPE D VALUE '20260611',
      MV_DAYS   TYPE I,
      MV_TIME   TYPE T.

" Obtener número de días entre la primera variable y la segunda.
" Mostrar el resultado en la tercera.
  MV_DAYS = MV_DATE_2 - MV_DATE_1.

" Mostrar con el formato de “DDMMAAAA” el valor de la primera variable.
  MV_DATE_1 = cl_abap_context_info=>get_system_date( ).
  MV_DATE_2 = cl_abap_context_info=>get_system_date( ).

" Muestra el resultado.
*  out->write( |Fecha 1 formato SAP: { mv_date_1 }| ).
*  out->write( |Fecha 2 formato SAP: { mv_date_2 }| ).
*  out->write( |Cantidad de días entre fechas: { mv_days }| ).
*  out->write( |Fecha 1 formato DDMMAAAA: { mv_date_1+6(2) }{ mv_date_1+4(2) }{ mv_date_1+0(4) }| ).

**********************************************************************
* 6. Campos Timestamp
**********************************************************************
" Declarar la variable:
DATA: MV_TIMESTAMP TYPE UTCLONG.

" Obtener la fecha actual con la función “UTCLONG_CURRENT()”.
  mv_timestamp = utclong_current( ).

" Luego obtener la fecha del sistema pasar la fecha y hora a 2
" variables reutilizar las variables MV_DATE_2 y MV_TIME.
  mv_date_2 = cl_abap_context_info=>get_system_date( ).
  mv_time   = cl_abap_context_info=>get_system_time( ).

"Por último, restar 2 días a la primera variable.
  mv_date_2 = mv_date_2 - 2.


" Muestra el resultado.
*  out->write( |Timestamp actual UTCLONG: { mv_timestamp }| ).
*  out->write( |Fecha del sistema menos 2 días: { mv_date_2 }| ).
*  out->write( |Hora del sistema: { mv_time }| ).


ENDMETHOD.

ENDCLASS.
