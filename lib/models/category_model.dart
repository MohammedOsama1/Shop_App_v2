class CategoryModel {
  bool? status;
  CategoryData? data;

  CategoryModel({this.status, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? CategoryData.fromJson(json['data']) : null;
  }
}

class CategoryData {
  int? currentPage;
  List<Data>? data;

  CategoryData({
    this.currentPage,
    this.data,
  });

  CategoryData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }

  }
}

class Data {
  int? id;
  String? name;
  String? image;

  Data({this.id, this.name, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
