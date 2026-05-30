CLASS zcl_lab_01_var_sergio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* Constantes - Espejo de todas las variables.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  CONSTANTS:
    mc_purchase_date TYPE d VALUE '20260525',
    mc_purchase_time TYPE t VALUE '151900',

    mc_price         TYPE f VALUE '10.5',
    mc_tax           TYPE i VALUE '16',

    mc_increase      TYPE decfloat16 VALUE '20.5',
    mc_discounts     TYPE decfloat34 VALUE '10.5',

    mc_type          TYPE c LENGTH 10 VALUE 'PC',
    mc_shipping      TYPE p LENGTH 8 DECIMALS 2 VALUE '40.36',

    mc_id_code       TYPE n LENGTH 4 VALUE '1110',
    mc_qr_code       TYPE x LENGTH 5 VALUE 'F5CF',

    mc_product       TYPE string VALUE 'Laptop',
    mc_bar_code      TYPE xstring VALUE '1212121211'.
ENDCLASS.


CLASS zcl_lab_01_var_sergio IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
*    out->write( 'This is my firt class in ABAP' ).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* Declaraciones - Tipo de datos elementales.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fecha y Hora.
    DATA MV_PURCHASE_DATE TYPE D.
    DATA MV_PURCHASE_TIME TYPE T.

* Asignar valores.
    MV_PURCHASE_DATE = '20260525'.
    MV_PURCHASE_TIME = '151900'.

    out->write( | Fecha { MV_PURCHASE_DATE } - Hora { MV_PURCHASE_TIME }| ).

" Precio e Impuesto.
    DATA MV_PRICE TYPE F VALUE '10.5'.
    DATA MV_TAX   TYPE i VALUE '16'.

" Calculos.
    DATA MV_INCREASE  TYPE DECFLOAT16 VALUE '20.5'.
    DATA MV_DISCOUNTS TYPE DECFLOAT34 VALUE '10.5'.

" Envío.
    DATA MV_TYPE     TYPE c LENGTH 10 VALUE 'PC'.
    DATA MV_SHIPPING TYPE p LENGTH 8 DECIMALS 2 VALUE '40.36'.

" Código.
    DATA MV_ID_CODE TYPE n LENGTH 4 VALUE '1110'.
    DATA MV_QR_CODE TYPE x LENGTH 5 VALUE 'F5CF'.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* Declaraciones - Tipo de datos complejos.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Declaración de estructura.
    TYPES:BEGIN OF MTY_CUSTOMER,
          ID       TYPE i,
          CUSTOMER TYPE c LENGTH 15,
          AGE      TYPE i,
    END OF MTY_CUSTOMER.

    DATA LMY_CUSTOMER TYPE MTY_CUSTOMER.

" Asignar valores.
    LMY_CUSTOMER-id       = '123'.
    LMY_CUSTOMER-customer = 'Sergio Capurro'.
    LMY_CUSTOMER-age      = '40'.

    out->write( LMY_CUSTOMER ).

    DATA ms_employees TYPE /dmo/employee_hr.

    ms_employees-client          = '123'.
    ms_employees-employee        = '456'.
    ms_employees-first_name      = 'Sergio'.
    ms_employees-last_name       = 'Capurro'.
    ms_employees-manager         = '789'.
    ms_employees-salary          = '200000'.
    ms_employees-salary_currency = 'AR'.

    out->write( ms_employees ).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* Objetos de datos - Variables.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA mv_product  TYPE string   VALUE 'Laptop'.
    DATA mv_bar_code TYPE xstring VALUE '1212121211'.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* Asignar las constantes a las variables
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    mv_purchase_date = mc_purchase_date.
    mv_purchase_time = mc_purchase_time.

    mv_price         = mc_price.
    mv_tax           = mc_tax.

    mv_increase      = mc_increase.
    mv_discounts     = mc_discounts.

    mv_type          = mc_type.
    mv_shipping      = mc_shipping.

    mv_id_code       = mc_id_code.
    mv_qr_code       = mc_qr_code.

    mv_product       = mc_product.
    mv_bar_code      = mc_bar_code.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* Declaración en línea.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA(lv_product)  = mv_product.
    DATA(lv_bar_code) = mv_bar_code.

  ENDMETHOD.

ENDCLASS.
