class BrandEntity {
  String brandName;
  int weight;
  String type;
  String category;
  double price;

  BrandEntity(
      {this.brandName, this.category, this.weight, this.type, this.price});

  Map<String, dynamic> toMap() {
    return {
      'brandName': this.brandName,
      'weight': this.weight,
      'type': this.type,
      'category': this.category,
      'price': this.price,
    };
  }
}
