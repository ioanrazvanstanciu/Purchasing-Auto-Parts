import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/products_model.dart';

class ProductsProvider with ChangeNotifier {
  static List<ProductModel> _productsList = [];
  List<ProductModel> get getProducts {
    return _productsList;
  }

  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _productsList = [];
      // _productsList.clear();
      productSnapshot.docs.forEach((element) {
        _productsList.insert(
            0,
            ProductModel(
              id: element.get('id'),
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              productCategoryName: element.get('productCategoryName'),
              price: double.parse(
                element.get('price'),
              ),
              salePrice: element.get('salePrice'),
              isOnSale: element.get('isOnSale'),
              isPiece: element.get('isPiece'),
            ));
      });
    });
    notifyListeners();
  }

  ProductModel findProdById(String productId) {
    return _productsList.firstWhere((element) => element.id == productId);
  }

  List<ProductModel> findByCategory(String categoryName) {
    List<ProductModel> _categoryList = _productsList
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> _searchList = _productsList
        .where(
          (element) => element.title.toLowerCase().contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();
    return _searchList;
  }

  // static final List<ProductModel> _productsList = [
  //   //Engine Parts
  //   ProductModel(
  //     id: 'Spark plug',
  //     title: 'Spark plug',
  //     price: 4.99,
  //     salePrice: 4.49,
  //     imageUrl: 'https://i.imgur.com/mq8Fevr.png',
  //     productCategoryName: 'Engine Parts',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Air filter',
  //     title: 'Air filter',
  //     price: 2.85,
  //     salePrice: 2.35,
  //     imageUrl: 'https://i.imgur.com/ENaXtTy.png',
  //     productCategoryName: 'Engine Parts',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Motor Oil',
  //     title: 'Motor Oil',
  //     price: 5.99,
  //     salePrice: 5.49,
  //     imageUrl: 'https://i.imgur.com/hCcyXKk.png',
  //     productCategoryName: 'Engine Parts',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   //Lighting Parts
  //   ProductModel(
  //     id: 'Car headlight',
  //     title: 'Car headlight',
  //     price: 15.99,
  //     salePrice: 15.49,
  //     imageUrl: 'https://i.imgur.com/DHbVVMM.png',
  //     productCategoryName: 'Lighting Parts',
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Interior lights',
  //     title: 'Interior lights',
  //     price: 8.75,
  //     salePrice: 8.25,
  //     imageUrl: 'https://i.imgur.com/YRdNnVe.png',
  //     productCategoryName: 'Lighting Parts',
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   //Air Conditioning Parts
  //   ProductModel(
  //     id: 'Radiator',
  //     title: 'Radiator',
  //     price: 39.99,
  //     salePrice: 39.49,
  //     imageUrl: 'https://i.imgur.com/H6x67Xf.png',
  //     productCategoryName: 'Air Conditioning Parts',
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Thermostat',
  //     title: 'Thermostat',
  //     price: 5.59,
  //     salePrice: 5.09,
  //     imageUrl: 'https://i.imgur.com/UYwmBKg.png',
  //     productCategoryName: 'Air Conditioning Parts',
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Freon',
  //     title: 'Freon',
  //     price: 30.99,
  //     salePrice: 30.49,
  //     imageUrl: 'https://i.imgur.com/KaIVdj0.png',
  //     productCategoryName: 'Air Conditioning Parts',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  // ];
}
