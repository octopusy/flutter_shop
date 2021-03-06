class Productdetail {
  String totalCount = "0";
  List<ProductDetail> list;

  Productdetail({this.totalCount, this.list});

  Productdetail.fromJson(Map<String, dynamic> json) {
    this.totalCount = json['totalCount'];
    this.list = (json['list'] as List) != null
        ? (json['list'] as List).map((i) => ProductDetail.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['list'] =
        this.list != null ? this.list.map((i) => i.toJson()).toList() : null;
    return data;
  }
}

class ProductDetail {
  String activeStartDate = "";
  String name = "";
  double salePrice = 0;
  double retailPrice = 0;
  int inventory = 0;
  String description;
  String metaTitle;
  int id = 0;
  int skuId = 0;
  List<AttributesListBean> attributes = List();
  List<MediasListBean> medias = List();

  ProductDetail(
      this.activeStartDate,
      this.name,
      this.salePrice,
      this.retailPrice,
      this.inventory,
      this.id,
      this.metaTitle,
      this.skuId,
      this.attributes,
      this.medias);

  ProductDetail.N(this.name);

  ProductDetail.fromJson(Map<String, dynamic> json) {
    this.activeStartDate = json['activeStartDate'];
    this.name = json['name'];
    this.salePrice = json['salePrice'];
    this.retailPrice = json['retailPrice'];
    this.inventory = json['inventory'];
    this.id = json['id'];
    this.metaTitle = json['metaTitle'];
    this.description = json['description'];

    this.skuId = json['skuId'];
    this.attributes = (json['attributes'] as List) != null
        ? (json['attributes'] as List)
            .map((i) => AttributesListBean.fromJson(i))
            .toList()
        : null;
    this.medias = (json['medias'] as List) != null
        ? (json['medias'] as List)
            .map((i) => MediasListBean.fromJson(i))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activeStartDate'] = this.activeStartDate;
    data['name'] = this.name;
    data['salePrice'] = this.salePrice;
    data['retailPrice'] = this.retailPrice;
    data['inventory'] = this.inventory;
    data['id'] = this.id;
    data['metaTitle'] = this.metaTitle;
    data['description'] = this.description;
    data['skuId'] = this.skuId;
    data['attributes'] = this.attributes != null
        ? this.attributes.map((i) => i.toJson()).toList()
        : null;
    data['medias'] = this.medias != null
        ? this.medias.map((i) => i.toJson()).toList()
        : null;
    return data;
  }
}

class AttributesListBean {
  String value;
  String option;
  int valueId;
  int optionId;

  AttributesListBean({this.value, this.option, this.valueId, this.optionId});

  AttributesListBean.fromJson(Map<String, dynamic> json) {
    this.value = json['value'];
    this.option = json['option'];
    this.valueId = json['valueId'];
    this.optionId = json['optionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['option'] = this.option;
    data['valueId'] = this.valueId;
    data['optionId'] = this.optionId;
    return data;
  }
}

class MediasListBean {
  String name;
  String url;
  int id;

  MediasListBean({this.name, this.url, this.id});

  MediasListBean.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.url = json['url'];
    this.id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['id'] = this.id;
    return data;
  }
}
