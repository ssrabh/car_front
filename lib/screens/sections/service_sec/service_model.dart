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
        title: "Foam Wash",
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
        imgPath: "assets/images/premium.png",
        title: "Premium Wash",
        subtitle:
            "Complete exterior and interior cleaning with premium products and attention to detail",
        data: [
          "Everything in Foam",
          "Interior vacuum",
          "Dashboard polish",
          "Tire shine"
        ],
        price: '₹199'),
    ServiceModel(
        imgPath: "assets/images/deep.png",
        title: "Deep Cleaning",
        subtitle:
            "Intensive interior and exterior deep clean removing stubborn stains and odors",
        data: [
          "Complete premium wash",
          "Steam cleaning",
          "Stain removal",
          "Odor elimination"
        ],
        price: '₹599'),
    ServiceModel(
        imgPath: "assets/images/rubbing.png", // Assuming a different image
        title: "Rubbing & Polishing",
        subtitle:
            "Restore your car's shine with professional polishing and paint correction",
        data: [
          "Paint correction",
          "Professional polishing",
          "Scratch removal",
          "Protective wax"
        ],
        price: '₹1299'),
    ServiceModel(
        imgPath: "assets/images/engine.png", // Assuming a different image
        title: "Engine Detailing",
        subtitle:
            "Thorough cleaning of engine compartment and undercarriage for optimal performance",
        data: [
          "Engine degreasing",
          "Undercarriage wash",
          "Component protection",
          "Performance boost"
        ],
        price: '₹499'),
  ];
}
