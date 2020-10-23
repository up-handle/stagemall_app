
//class HomeRecommendShowModel {
//  Header header;
//  Body body;
//
//  HomeRecommendShowModel({this.header, this.body});
//
//  HomeRecommendShowModel.fromJson(Map<String, dynamic> json) {
//    header =
//    json['header'] != null ? new Header.fromJson(json['header']) : null;
//    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.header != null) {
//      data['header'] = this.header.toJson();
//    }
//    if (this.body != null) {
//      data['body'] = this.body.toJson();
//    }
//    return data;
//  }
//}
//
//class Header {
//  String code;
//  String msg;
//
//  Header({this.code, this.msg});
//
//  Header.fromJson(Map<String, dynamic> json) {
//    code = json['code'];
//    msg = json['msg'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['code'] = this.code;
//    data['msg'] = this.msg;
//    return data;
//  }
//}



///////首页推荐

class RecommendHomeData {
  String title;
  String subtitle;
  Page page;

  RecommendHomeData({this.title = '', this.subtitle ='', this.page });

  RecommendHomeData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    page = json['page'] != null ? new Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    if (this.page != null) {
      data['page'] = this.page.toJson();
    }
    return data;
  }
}

class Page {
  int pageNum;
  int pageSize;
  List<ListData> list;
  Page({this.pageNum, this.pageSize, this.list});
  Page.fromJson(Map<String, dynamic> json) {
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    if (json['list']!= null) {
      list = new List<ListData>();
      json['list'].forEach((v) {
        list.add(new ListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNum'] = this.pageNum;
    data['pageSize'] = this.pageSize;
    if (null!=this.list) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListData {
  int id;
  int sku;
  String imagepath;
  String name;
  String url;
  String price;
  String realPrice;
  ListData(
      {this.id,
        this.sku,
        this.imagepath='',
        this.name ='',
        this.url,
        this.price,
        this.realPrice=''});
  ListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    imagepath = json['imagepath'];
    name = json['name'];
    url = json['url'];
    price = json['price'];
    realPrice = json['realPrice'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['imagepath'] = this.imagepath;
    data['name'] = this.name;
    data['url'] = this.url;
    data['price'] = this.price;
    data['realPrice'] = this.realPrice;
    return data;
  }
}

