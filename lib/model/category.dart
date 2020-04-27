class CategoryListModel {
  String message;
  List<Data> data;
  String code;

  CategoryListModel({this.message, this.data, this.code});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
  List<BxMallSubDto> bxMallSubDto;
  Null comments;
  String image;
  String mallCategoryId;
  String mallCategoryName;

  Data(
      {this.bxMallSubDto,
      this.comments,
      this.image,
      this.mallCategoryId,
      this.mallCategoryName});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['bxMallSubDto'] != null) {
      bxMallSubDto = new List<BxMallSubDto>();
      json['bxMallSubDto'].forEach((v) {
        bxMallSubDto.add(new BxMallSubDto.fromJson(v));
      });
    }
    comments = json['comments'];
    image = json['image'];
    mallCategoryId = json['mallCategoryId'];
    mallCategoryName = json['mallCategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bxMallSubDto != null) {
      data['bxMallSubDto'] = this.bxMallSubDto.map((v) => v.toJson()).toList();
    }
    data['comments'] = this.comments;
    data['image'] = this.image;
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallCategoryName'] = this.mallCategoryName;
    return data;
  }
}

class BxMallSubDto {
  String mallSubId;
  String mallSubName;
  String mallCategoryId;
  String comments;

  BxMallSubDto(
      {this.mallSubId, this.mallSubName, this.mallCategoryId, this.comments});

  BxMallSubDto.fromJson(Map<String, dynamic> json) {
    mallSubId = json['mallSubId'];
    mallSubName = json['mallSubName'];
    mallCategoryId = json['mallCategoryId'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallSubId'] = this.mallSubId;
    data['mallSubName'] = this.mallSubName;
    data['mallCategoryId'] = this.mallCategoryId;
    data['comments'] = this.comments;
    return data;
  }
}