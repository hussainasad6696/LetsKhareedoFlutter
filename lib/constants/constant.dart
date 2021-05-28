import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const kDefaultPadding = 15.0;
const String WEB = 'web';
const String MOBILE = 'mobile';
const double PREFERRED_SIZE = 50;
const double ADD_CARD_PADDING = 5.0;
const double RADIUS = 20.0;
const String WEB_CHECK = kIsWeb ? WEB : MOBILE;



const String BASE_IP = "10.0.2.2";
const String BASE_URL_HTTPS = BASE_IP+":8080";
const String BASE_URL_HTTP = BASE_IP+":8000";
const String BASE_URL_HTTP_WITH_ADDRESS = "http://"+BASE_IP+":8000";
const String BASE_URL_HTTP_WITH_ADDRESS_IMAGE = "http://127.0.0.1:8000";
const String PRODUCTS_ADDRESS_MALE = "/products/male";
const String PRODUCTS_ADDRESS_FEMALE = "/products/female";
const String PRODUCTS_ADDRESS_MALE_KIDS = "/products/male/kids";
const String PRODUCTS_ADDRESS_FEMALE_KIDS = "/products/female/kids";
const String PRODUCTS_ADDRESS_ACCESSORIES = "/products/accessories";
const String PRODUCTS_ADDRESS_STORE = "/products/store";
const String PRODUCT_IMAGE_ADDRESS = "/products/images/?id=";
const String SLIDER_IMAGE_ADDRESS = "/databaseEntryForm/slider-images";
const String SLIDER_IMAGE_SETTER_ADDRESS = "/products/sliderImages/?id=";
const String ADVERTISEMENT_IMAGES_ADDRESS = "/databaseEntryForm/advertisement";
const String ADVERTISEMENT_IMAGES_SETTER_ADDRESS = "/products/advertImages/?id=";
const String PRODUCT_HOT_OR_NOT = "/products/hotOrNot";


const String DB_NAME = "CartDB";
const String USER_DB = "UserDb";
const String USER_PREFERENCE_UUID_KEY = "user_uuid";


const Color APP_BAR_BACKGROUND = Color(0xFFFAFAFA);
const Color APPLICATION_BACKGROUND_COLOR = Color(0xFFFFFFFF);
// const Color APPLICATION_BACKGROUND_COLOR = Color(0xFFEEEEEE);
const kPrimaryColor = Color(0xFFA95EFA);
const kSecondaryColor = Color(0xFFF3F6F8);
const kTextColor = Color(0xFF171717);