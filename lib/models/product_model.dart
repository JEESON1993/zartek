// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantImage,
    required this.tableId,
    required this.tableName,
    required this.branchName,
    required this.nexturl,
    required this.tableMenuList,
  });

  final String restaurantId;
  final String restaurantName;
  final String restaurantImage;
  final String tableId;
  final String tableName;
  final String branchName;
  final String nexturl;
  final List<TableMenuList> tableMenuList;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        restaurantId:
            json["restaurant_id"] == null ? null : json["restaurant_id"],
        restaurantName:
            json["restaurant_name"] == null ? null : json["restaurant_name"],
        restaurantImage:
            json["restaurant_image"] == null ? null : json["restaurant_image"],
        tableId: json["table_id"] == null ? null : json["table_id"],
        tableName: json["table_name"] == null ? null : json["table_name"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
        nexturl: json["nexturl"] == null ? null : json["nexturl"],
        tableMenuList: List<TableMenuList>.from(
            json["table_menu_list"].map((x) => TableMenuList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "restaurant_id": restaurantId == null ? null : restaurantId,
        "restaurant_name": restaurantName == null ? null : restaurantName,
        "restaurant_image": restaurantImage == null ? null : restaurantImage,
        "table_id": tableId == null ? null : tableId,
        "table_name": tableName == null ? null : tableName,
        "branch_name": branchName == null ? null : branchName,
        "nexturl": nexturl == null ? null : nexturl,
        "table_menu_list": tableMenuList == null
            ? null
            : List<dynamic>.from(tableMenuList.map((x) => x.toJson())),
      };
}

class TableMenuList {
  TableMenuList({
    required this.menuCategory,
    required this.menuCategoryId,
    required this.menuCategoryImage,
    required this.nexturl,
    required this.categoryDishes,
  });

  final String menuCategory;
  final String menuCategoryId;
  final String menuCategoryImage;
  final String nexturl;
  final List<CategoryDish> categoryDishes;

  factory TableMenuList.fromJson(Map<String, dynamic> json) => TableMenuList(
        menuCategory:
            json["menu_category"] == null ? null : json["menu_category"],
        menuCategoryId:
            json["menu_category_id"] == null ? null : json["menu_category_id"],
        menuCategoryImage: json["menu_category_image"] == null
            ? null
            : json["menu_category_image"],
        nexturl: json["nexturl"] == null ? null : json["nexturl"],
        categoryDishes: List<CategoryDish>.from(
            json["category_dishes"].map((x) => CategoryDish.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menu_category": menuCategory == null ? null : menuCategory,
        "menu_category_id": menuCategoryId == null ? null : menuCategoryId,
        "menu_category_image":
            menuCategoryImage == null ? null : menuCategoryImage,
        "nexturl": nexturl == null ? null : nexturl,
        "category_dishes": categoryDishes == null
            ? null
            : List<dynamic>.from(categoryDishes.map((x) => x.toJson())),
      };
}

class CategoryDish {
  CategoryDish({
    required this.dishId,
    required this.dishName,
    required this.dishPrice,
    required this.dishImage,
    required this.dishCurrency,
    required this.dishCalories,
    required this.dishDescription,
    required this.dishAvailability,
    required this.dishType,
    required this.nexturl,
    required this.addonCat,
  });

  final String dishId;
  final String dishName;
  final double dishPrice;
  final String dishImage;
  final dynamic dishCurrency;
  final int dishCalories;
  final String dishDescription;
  final bool dishAvailability;
  final int dishType;
  final String nexturl;
  final List<AddonCat> addonCat;

  factory CategoryDish.fromJson(Map<String, dynamic> json) => CategoryDish(
        dishId: json["dish_id"] == null ? null : json["dish_id"],
        dishName: json["dish_name"] == null ? null : json["dish_name"],
        dishPrice:
            json["dish_price"] == null ? null : json["dish_price"].toDouble(),
        dishImage: json["dish_image"] == null ? null : json["dish_image"],
        dishCurrency: dishCurrencyValues.map[json["dish_currency"]],
        dishCalories:
            json["dish_calories"] == null ? null : json["dish_calories"],
        dishDescription:
            json["dish_description"] == null ? null : json["dish_description"],
        dishAvailability: json["dish_Availability"] == null
            ? null
            : json["dish_Availability"],
        dishType: json["dish_Type"] == null ? null : json["dish_Type"],
        nexturl: json["nexturl"] == null ? null : json["nexturl"],
        addonCat: List<AddonCat>.from(
            json["addonCat"].map((x) => AddonCat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dish_id": dishId == null ? null : dishId,
        "dish_name": dishName == null ? null : dishName,
        "dish_price": dishPrice == null ? null : dishPrice,
        "dish_image": dishImage == null ? null : dishImage,
        "dish_currency": dishCurrency == null
            ? null
            : dishCurrencyValues.reverse[dishCurrency],
        "dish_calories": dishCalories == null ? null : dishCalories,
        "dish_description": dishDescription == null ? null : dishDescription,
        "dish_Availability": dishAvailability == null ? null : dishAvailability,
        "dish_Type": dishType == null ? null : dishType,
        "nexturl": nexturl == null ? null : nexturl,
        "addonCat": addonCat == null
            ? null
            : List<dynamic>.from(addonCat.map((x) => x.toJson())),
      };
}

class AddonCat {
  AddonCat({
    required this.addonCategory,
    required this.addonCategoryId,
    required this.addonSelection,
    required this.nexturl,
    required this.addons,
  });

  final String addonCategory;
  final String addonCategoryId;
  final int addonSelection;
  final String nexturl;
  final List<Addon> addons;

  factory AddonCat.fromJson(Map<String, dynamic> json) => AddonCat(
        addonCategory:
            json["addon_category"] == null ? null : json["addon_category"],
        addonCategoryId: json["addon_category_id"] == null
            ? null
            : json["addon_category_id"],
        addonSelection:
            json["addon_selection"] == null ? null : json["addon_selection"],
        nexturl: json["nexturl"] == null ? null : json["nexturl"],
        addons: List<Addon>.from(json["addons"].map((x) => Addon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "addon_category": addonCategory == null ? null : addonCategory,
        "addon_category_id": addonCategoryId == null ? null : addonCategoryId,
        "addon_selection": addonSelection == null ? null : addonSelection,
        "nexturl": nexturl == null ? null : nexturl,
        "addons": addons == null
            ? null
            : List<dynamic>.from(addons.map((x) => x.toJson())),
      };
}

class Addon {
  Addon({
    required this.dishId,
    required this.dishName,
    required this.dishPrice,
    required this.dishImage,
    required this.dishCurrency,
    required this.dishCalories,
    required this.dishDescription,
    required this.dishAvailability,
    required this.dishType,
  });

  final String dishId;
  final String dishName;
  final int dishPrice;
  final String dishImage;
  final dynamic dishCurrency;
  final int dishCalories;
  final String dishDescription;
  final bool dishAvailability;
  final int dishType;

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
        dishId: json["dish_id"] == null ? null : json["dish_id"],
        dishName: json["dish_name"] == null ? null : json["dish_name"],
        dishPrice: json["dish_price"] == null ? null : json["dish_price"],
        dishImage: json["dish_image"] == null ? null : json["dish_image"],
        dishCurrency: dishCurrencyValues.map[json["dish_currency"]],
        dishCalories:
            json["dish_calories"] == null ? null : json["dish_calories"],
        dishDescription:
            json["dish_description"] == null ? null : json["dish_description"],
        dishAvailability: json["dish_Availability"] == null
            ? null
            : json["dish_Availability"],
        dishType: json["dish_Type"] == null ? null : json["dish_Type"],
      );

  Map<String, dynamic> toJson() => {
        "dish_id": dishId == null ? null : dishId,
        "dish_name": dishName == null ? null : dishName,
        "dish_price": dishPrice == null ? null : dishPrice,
        "dish_image": dishImage == null ? null : dishImage,
        "dish_currency": dishCurrencyValues.reverse[dishCurrency],
        "dish_calories": dishCalories == null ? null : dishCalories,
        "dish_description": dishDescription == null ? null : dishDescription,
        "dish_Availability": dishAvailability == null ? null : dishAvailability,
        "dish_Type": dishType == null ? null : dishType,
      };
}

enum DishCurrency { SAR }

final dishCurrencyValues = EnumValues({"SAR": DishCurrency.SAR});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
