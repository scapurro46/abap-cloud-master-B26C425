CLASS zcl_lab_02_arithmetic_sergio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_LAB_02_ARITHMETIC_SERGIO IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.

**********************************************************************
* 1. Suma / Sentencia ADD
**********************************************************************

" Declaraciones.
DATA: LV_BASE_RATE            TYPE i VALUE 20,
      LV_CORP_AREA_RATE       TYPE i VALUE 10,
      LV_MEDICAL_SERVICE_RATE TYPE I VALUE 15,
      LV_TOTAL_RATE           TYPE P LENGTH 6 DECIMALS 2.

" Operación SUMA (ADD).
  CLEAR LV_TOTAL_RATE.
  LV_TOTAL_RATE = LV_BASE_RATE + LV_CORP_AREA_RATE + LV_MEDICAL_SERVICE_RATE.
  out->write( | SUMA | ).
  out->write( | Number a { lv_base_rate } Number b { lv_corp_area_rate } Number c { lv_medical_service_rate } Total { lv_total_rate }| ).

  ADD 5 TO LV_TOTAL_RATE.
  out->write( | Total { lv_total_rate } | ).

**********************************************************************
* 2. Resta / Sentencia SUBTRACT
**********************************************************************

" Declaraciones.
DATA: LV_MAINTENANCE_RATE TYPE i VALUE 30,
      LV_MARGIN_RATE      TYPE i VALUE 10,
      LV_BASE_RATE2       TYPE P LENGTH 6 DECIMALS 2.

" Operación RESTA (SUBTRACT).
  CLEAR LV_BASE_RATE2.
  LV_BASE_RATE2 = LV_MAINTENANCE_RATE - LV_MARGIN_RATE.
  out->write( | RESTA | ).
  OUT->write( |Number a { lv_maintenance_rate } Number b { lv_margin_rate } Total { lv_base_rate2 }| ).

  SUBTRACT 4 FROM LV_BASE_RATE2.
  out->write( |Total { lv_base_rate2 }| ).

**********************************************************************
* 3. Multiplicación / Sentencia MULTIPLY
**********************************************************************

" Declaraciones.
DATA: LV_PACKAGE_WEIGHT  TYPE i VALUE 2,
      LV_COST_PER_KG     TYPE i VALUE 3,
      LV_MULTI_RATE.

" Operación MULTIPLICACIÓN (MULTIPLY).
  CLEAR LV_MULTI_RATE.
  LV_MULTI_RATE = LV_PACKAGE_WEIGHT * LV_COST_PER_KG.
  out->write( | MULTILICACIÓN | ).
  OUT->write( |Number a { LV_PACKAGE_WEIGHT } Number b { LV_COST_PER_KG } Total { LV_MULTI_RATE }| ).

  MULTIPLY LV_MULTI_RATE BY 2.
  out->write( |Total { LV_MULTI_RATE }| ).

**********************************************************************
* 4. División / Sentencia DIVIDE
**********************************************************************

" Declaraciones.
DATA: LV_TOTAL_WEIGHT   TYPE i VALUE 38,
      LV_NUM_PACKAGES   TYPE i VALUE 4,
      LV_APPLIED_RATE   TYPE p VALUE 8 DECIMALS 2.

" Operación DIVISIÓN (MULTIPLY).
  CLEAR LV_APPLIED_RATE.
  LV_APPLIED_RATE = LV_TOTAL_WEIGHT / LV_NUM_PACKAGES.
  out->write( | DIVISIÓN | ).
  OUT->write( |Number a { LV_TOTAL_WEIGHT } Number b { LV_NUM_PACKAGES } Total { LV_APPLIED_RATE }| ).

  DIVIDE LV_APPLIED_RATE BY 3.
  out->write( |Total { LV_APPLIED_RATE }| ).

**********************************************************************
* 5. División sin resto / Sentencia DIV
**********************************************************************

" Declaraciones.
DATA: LV_TOTAL_COST    TYPE i VALUE 17,
      LV_DISCOUNT_THRESHOLD    TYPE i VALUE 4,
      LV_RESULT    TYPE p VALUE 4 DECIMALS 2.

" Operación DIVICIÓN (DIV).
  CLEAR LV_RESULT .
  LV_RESULT  = LV_TOTAL_COST / LV_DISCOUNT_THRESHOLD .
  out->write( | DIVISIÓN SIN RESTO | ).
  OUT->write( |Number a { LV_TOTAL_COST } Number b { LV_DISCOUNT_THRESHOLD  } Total { LV_RESULT  }| ).

  LV_RESULT = LV_TOTAL_COST DIV LV_DISCOUNT_THRESHOLD. "Resultado con redondeo.
  out->write( |Total { LV_RESULT }| ).

**********************************************************************
* 6. Resto (residuo) de división / Sentencia MOD
**********************************************************************

" Declaraciones.
DATA: LV_REMAINDER TYPE p VALUE 4 DECIMALS 2.

" Asignación de nuevos valores.
CLEAR: LV_TOTAL_COST,
       LV_DISCOUNT_THRESHOLD.

  LV_TOTAL_COST = 19.
  LV_DISCOUNT_THRESHOLD = 4.

" Operación DIVISIÓN (MOD).
  CLEAR LV_REMAINDER  .
  LV_REMAINDER  = LV_TOTAL_COST / LV_DISCOUNT_THRESHOLD.
  out->write( | DIVISIÓN MOD | ).
  OUT->write( |Number a { LV_TOTAL_COST } Number b { LV_DISCOUNT_THRESHOLD  } Total { LV_REMAINDER  }| ).

  LV_REMAINDER  = LV_TOTAL_COST MOD LV_DISCOUNT_THRESHOLD. "Residuo de toda la operación.
  out->write( |Total { LV_REMAINDER  }| ).

**********************************************************************
* 7. Exponenciación
**********************************************************************

" Declaraciones.
DATA: LV_WEIGHT TYPE i VALUE 5,
      LV_EXPO   TYPE i.

" Operación EXPONENCIACIÓN (EXP).
" Eleva al cuadrado la primera variable y guarda el resultado.
  LV_EXPO  = LV_WEIGHT ** 2.
  out->write( | EXPONENCIACIÓN | ).
  OUT->write( |Number a { LV_EXPO }| ).

"Con declaración en línea.
  CLEAR: LV_WEIGHT,
         LV_EXPO.

  LV_WEIGHT = 5.

  DATA(LV_EXPO2) = 2.

  LV_EXPO = LV_WEIGHT ** LV_EXPO2.
  OUT->write( |Number a { LV_EXPO }| ).

**********************************************************************
* 8. Raíz cuadrada
**********************************************************************

" Declaraciones.
DATA: LV_SQUARE_ROOT   TYPE i.

" Operación RAIZ CUADRADA.
" Obtener la raíz cuadrada del valor de la variable LV_EXPO de la
" actividad anterior

  LV_EXPO = SQRT( LV_EXPO ).
  OUT->write( | RAIZ CUADRADA | ).
  OUT->write( |Total SQRT: { LV_EXPO }| ).
  OUT->write( |Fin del ejercicio. | ).

ENDMETHOD.
ENDCLASS.
