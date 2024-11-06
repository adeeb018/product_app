
class Product {
  final int id;
  final int partsCat;
  final String partImage;
  final int vBrand;
  final int vCategory;
  final String price;
  final String? partsName;
  final String description;
  final String? offerPrice;
  final bool isOffer;
  final String productRating;

  Product({
    required this.id,
    required this.partsCat,
    required this.partImage,
    required this.vBrand,
    required this.vCategory,
    required this.price,
    this.partsName,
    required this.description,
    this.offerPrice,
    required this.isOffer,
    required this.productRating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      partsCat: json['parts_Cat'],
      partImage: json['part_image'],
      vBrand: json['v_brand'],
      vCategory: json['v_category'],
      price: json['price'] ?? '0.0',
      partsName: json['parts_name'],
      description: json['description'],
      offerPrice: json['offer_price'] ?? '0.0',
      isOffer: json['is_offer'],
      productRating: json['product_rating'] ?? '0.0',
    );
  }

  @override
  String toString() {
    return '''
Product(
  id: $id, 
  partsCat: $partsCat, 
  partImage: $partImage, 
  vBrand: $vBrand, 
  vCategory: $vCategory, 
  price: $price, 
  partsName: ${partsName ?? 'N/A'}, 
  description: $description, 
  offerPrice: ${offerPrice ?? 'N/A'}, 
  isOffer: $isOffer, 
  productRating: $productRating
)''';
  }
}
