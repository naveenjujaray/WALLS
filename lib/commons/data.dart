import 'package:Walls/commons/category_model.dart';

String apikey = '563492ad6f91700001000001e2f48293d99b401da63cff22ea606b44';

List<CategoryModel> getCategory(){

  List<CategoryModel> category = new List();
  CategoryModel categoryModel = new CategoryModel();

  //
  categoryModel.imgUrl = "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoriesName = "Street Art";
  category.add(categoryModel);
  categoryModel = new CategoryModel();
  //
  categoryModel.imgUrl = "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoriesName = "Wildi Life";
  category.add(categoryModel);
  categoryModel = new CategoryModel();
  //
  categoryModel.imgUrl = "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoriesName = "Nature";
  category.add(categoryModel);
  categoryModel = new CategoryModel();
  //
  categoryModel.imgUrl =
  "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoriesName = "City";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  //
  categoryModel.imgUrl =
  "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  categoryModel.categoriesName = "Motivation";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  //
  categoryModel.imgUrl =
  "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoriesName = "Bikes";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  //
  categoryModel.imgUrl =
  "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoriesName = "Cars";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  return category;

}