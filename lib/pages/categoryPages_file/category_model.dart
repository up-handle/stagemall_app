

///左边大的分类模型
class BigCategoryModel{
  final int id;
  final String name;
  BigCategoryModel({this.id , this.name});

  factory BigCategoryModel.formJson(Map json){
    return BigCategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }
}


////右边两级三级的菜单栏
class CategoryTwoThreeModel{
   int id;
   String name;
   List<ThreeCateModel> list;

  CategoryTwoThreeModel(this.id, this.name, this.list);

  CategoryTwoThreeModel.formJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    if (null != json['list']) {
      list = new List<ThreeCateModel>();
      json['list'].forEach((v) {
        list.add(new ThreeCateModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic>toJson(){
   final Map<String, dynamic> data = new Map<String,dynamic>();
   data['id'] = this.id;
   data['name'] = this.name;
   if(null != this.list){
     data['list'] =this.list.map((v) => v.toJson()).toList();
   }
   return data;
  }
}


class ThreeCateModel
{
   int id;
   String name;
   String url;
   ThreeCateModel(this.id, this.name, this.url);

   ThreeCateModel.fromJson(Map<String,dynamic> json){
     id = json['id'];
     name = json['name'];
     url  = json['url'];
   }

   Map<String, dynamic> toJson(){
     final Map<String, dynamic> date = new Map<String, dynamic>();
     date['id'] = this.id;
     date['name'] = this.name;
     date['url'] = this.url;
     return date;
   }
}

