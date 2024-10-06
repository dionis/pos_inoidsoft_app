import 'package:flutter/material.dart';

const kscaffoldColor = Color(0xffffffff);
const kcontentColor = Color(0xffF5F5F5);
const kprimaryColor = Color(0xffff660e);

const String PRODUCT_NAME = "Nombre del producto";
const String ERROR_TEXT_PRODUCT_NAME = "El nombre del producto es obligatorio";
const String ADD_PRODUCT = "Añadir producto";
const String PRODUCT_PRICE = "Precio del Producto";
const String TABLE_PRODUCT_NAME = 'Nombre';
const String TABLE_PRODUCT_QUANTITY = 'Cantidad';
const String TABLE_PRODUCT_PRICE = 'Precio';

const String TABLE_PRODUCT_TOTAL = 'Total';
const String TABLE_PROCUT_CASH_TOTAL = 'Efectivo';
const String TABLE_PRODUCT_TRANSFER_TOTAL = 'Transferencia';
const String TABLE_INVOICE = "Recibo";

const String TABLE_PAYMENT_METHOD = "Método de pago";
const String TABLE_SELLER_NAME = "Nombre del vendedor:";

List<String> paymentMethod = [
  "Transferencia / Efectivo",
  "Efectivo",
  "Tarjeta",
  "Transferencia",
  "Otro"
];

const INVOCE_NAME = 'Recibo de compra';
const PRINT_INVOCE = 'Imprimir';

const DAILY_STADISTICS = 'Diaria';

const WEEKLY_STADISTICS = 'Semanal';

const MONTH_STADISTICS = 'Mensual';

const MY_SALES = 'Mis ventas';

const BY_PRODUCT_SALES = 'Por producto';

const STADISCTICS_TITLE = 'Estadísticas de ventas';

String BNC = 'Banco Nancional de Cuba';
String CADECA = 'Cadeca';
String EXTERNAL = 'Exterior';
String MANUAL = 'Manual';

//List<String> currencyExchangeSource = [MANUAL, CADECA, EXTERNAL];
List<String> currencyExchangeSource = [MANUAL];

String TYPE_EXCHANGE = 'Fuente de referencia';

String CANCEL_ACTION = 'Cerrar';

String TITLE_CHANGE_COIN = 'Tipo de moneda';

String SEE_ALL = 'Ver Todos';

String TITLE_PAYMENT_METHOD = 'Forma de pago';

String BUSSINES_NAME = 'Nombre del negocio';

String BUSSINES_ADDRESS = 'Dirección del negocio';

String BUSSINES_PHONE_NUMBER = 'Teléfono del negocio';

String BUSSINES_WEBPAGE = "Página web del negocio";

String SELECT_CATEGORY_HINT = "Seleccionar categoría";

Map<String, Color> colorCodesEn = {
  'Red': Colors.red,
  'Orange': Colors.orange,
  'Yellow': Colors.yellow,
  'green': Colors.green,
  'Blue': Colors.blue,
  'Indigo': Colors.indigo,
  'Purple': Colors.purple,
  'Pink': Colors.pink,
  'Black': Colors.black,
  'White': Colors.white,
  'Brown': Colors.brown,
  'Grey': Colors.grey,
  'Lime': Colors.lime,
  'Teal': Colors.teal,
  'Cyan': Colors.cyan,
};

Map<String, Color> colorCodesEs = {
  'Rojo': Colors.red,
  'Naranja': Colors.orange,
  'Amarillo': Colors.yellow,
  'Verde': Colors.green,
  'Azul': Colors.blue,
  'Indigo': Colors.indigo,
  'Rosado': Colors.pink,
  'Negro': Colors.black,
  'Blanco': Colors.white,
  'Marron': Colors.brown,
  'Gris': Colors.grey,
  'Violeta': Colors.purple,
  'Limón': Colors.lime,
  'Verde azulado': Colors.teal,
  'Cian': Colors.cyan,
};

String EDIT_ITEM_ERROR_PRICE_MSSG = 'No es un valor correcto, revise por favor';

String EDIT_ITEM_ERROR_PRICE_POSITIVE_MSSG =
    'El precio debe ser un número positivo';

String PHONE_NUMBER_TITLE = 'Teléfono';

String ERROR_PHONE_NUMBER_EMPTY = 'El número de teléfono es obligatorio';

String ERROR_MAGNETIC_CART_EMPTY = 'El número de teléfono es obligatorio';

String ERROR_PHONE_NUMBER_REGULAR_EXPRESSION =
    'El número de teléfono solo puede contener números';

int MAGNETIC_CART_NUMBER_LENGTH = 12;

String MAGNETIC_CART_NUMBER_TITLE = 'Número de tarjeta magnética';

String ERROR_MAGNETIC_CART_NUMBER_EMPTY =
    'El número de targeta magnética es obligatorio';

String ERROR_MAGNETIC_CART_NUMBERR_REGULAR_EXPRESSION =
    'El número de targeta magnética solo puede contener números';

String ADD_VENDOR_NAME = 'Nombre del vendedor';

String ADD_ACCOUNT_NUMBER = 'Número de tarjeta o cuenta bancaria';

String ADD_PHONE_NUMBER = 'Inserte el numero de teléfono';

String VENDOR_NAME = 'Nombre';
String UPDATE_IMAGE = "Actualizar imagen:";

String ERROR_VENDOR_NAME_EMPTY = 'El nombre del vendedor es obligatorio';

String ERROR_VENDOR_NAME_REGULAR_EXPRESSION =
    "El nombre del vendedor solo puede contener letras y números";

String ERROR_IDENTIFICATOR_NUMBER_EMPTY =
    'El carnet de identidad es obligatorio';

String ERROR_IDENTIFICATOR_NUMBER_REGULAR_EXPRESSION =
    "El carnet de identidad solo puede contener números";

String IDENTIFICATION_NUMBER_TITLE = 'Carnet de Identidad';

enum ImageSourceType { camera, gallery, video, photo }

String ERROR_SELECT_IMAGE_FROM_GALLERY = 'Debe seleccionar una imagen';

String NOT_FILE_ADDRESS = 'assets/no-image.jpg';

String ACTION_BUTTON = 'Add';

String ERROR_IN_DATA = 'Los datos tienen errores, revise por favor';

String DAILY = 'diarias';
String DAY = 'Día';

String WEEKLY = 'semanales';
String WEEK = 'Semana';

String MONTHLY = 'mensuales';
String MONTH = 'Mes';

String SALES = 'Venta total';

String MAX_DAY = 'Max';
