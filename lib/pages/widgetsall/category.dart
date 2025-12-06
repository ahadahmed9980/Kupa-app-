import 'package:grocerapp/pages/model/category_model.dart';

//Matlab categories ek list hai jisme sirf Categorymodel objects store honge.
List<Categorymodel> getcategory() {
  List<Categorymodel> category = [];
  Categorymodel categorymodel = new Categorymodel();
  categorymodel.name = "Noodels";
  categorymodel.image = "assets/images/noodels.png";
  category.add(categorymodel);
  categorymodel.name = "Burgers";
  categorymodel.image = "assets/images/burger.png";
  category.add(categorymodel);
   categorymodel.name = "Burgers";
  categorymodel.image = "assets/images/burger.png";
  category.add(categorymodel);

  return category;
}
