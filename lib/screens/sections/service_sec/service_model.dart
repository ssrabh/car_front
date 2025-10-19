// 1. Data Structure for a single Service Card
class ServiceModel {
  String imgPath;
  String title;
  String subtitle;
  List<String> data; // Features included in the service
  String price;

  ServiceModel({
    required this.imgPath,
    required this.title,
    required this.subtitle,
    required this.data,
    required this.price,
  });
}

// 2. Static Data Repository for the Service Section
class ServiceModelData {
  static const String mainTitle = "Our Professional Services";
  static const String subTitle =
      "From basic wash to premium detailing, we've got your vehicle covered with professional care and eco-friendly products.";

  static List<ServiceModel> datalist = [
    ServiceModel(
        imgPath: "assets/images/foam.png",
        title: "Foam Wash & Wax",
        subtitle:
            'Deep cleaning that removes dirt and grime while being gentle on your paint.',
        data: [
          'Exterior foam wash',
          'Basic rim/tyre clean',
          'Interior vacuum',
          'Basic window cleaning',
        ],
        price: '₹150'),
    ServiceModel(
        imgPath: "assets/images/deep.png", // Assuming a different image
        title: "Full Interior Detail",
        subtitle:
            'A thorough deep clean of your cabin, removing odors and stains.',
        data: [
          'Deep vacuum & shampoo',
          'Dashboard & console polish',
          'Seat cleaning (Fabric/Leather)',
          'Air freshener treatment',
        ],
        price: '₹999'),
    ServiceModel(
        imgPath: "assets/images/premium.png", // Assuming a different image
        title: "Premium Oil Change",
        subtitle:
            'Fast and reliable oil change service using only synthetic oils.',
        data: [
          'Full synthetic oil replacement',
          'Oil filter change',
          'Multi-point inspection',
          'Fluid top-offs',
        ],
        price: '₹1499'),
    ServiceModel(
        imgPath: "assets/images/premium.png", // Assuming a different image
        title: "Premium Oil Change",
        subtitle:
            'Fast and reliable oil change service using only synthetic oils.',
        data: [
          'Full synthetic oil replacement',
          'Oil filter change',
          'Multi-point inspection',
          'Fluid top-offs',
        ],
        price: '₹1499'),
  ];
}
