// 1. Data Structure for a single Testimonial Card
class TestimonialModel {
  final String quote;
  final String author;
  final String details;
  final String initial; // For avatar circle

  TestimonialModel({
    required this.quote,
    required this.author,
    required this.details,
    required this.initial,
  });
}

// 2. Static Data Repository for the Testimonials Section
class TestimonialModelData {
  // We don't need a main title/subtitle here, as the testimonials section
  // title is usually self-explanatory (e.g., "What Our Clients Say").

  static List<TestimonialModel> datalist = [
    TestimonialModel(
        quote:
            '“Outstanding service! My BMW looks showroom fresh. The team was incredibly professional and the monthly subscription saves me so much time.”',
        author: 'Rajesh Kumar',
        details: 'BMW X5 Owner, Mumbai',
        initial: 'R'),
    TestimonialModel(
        quote:
            '“Best car wash in the city! The deep cleaning removed stains I thought were permanent. Monthly subscription is absolutely worth every rupee!”',
        author: 'Priya Sharma',
        details: 'Honda City Owner, Delhi',
        initial: 'P'),
    TestimonialModel(
        quote:
            '“Professional service with fair pricing. They saved me 3 hours every weekend and my car always looks perfect. Highly recommend CarCare!”',
        author: 'Arjun Patel',
        details: 'Maruti Swift Owner, Bangalore',
        initial: 'A'),
    // Adding one more testimonial for a better grid/carousel view
    TestimonialModel(
        quote:
            '“The attention to detail on my classic car was phenomenal. They treat every vehicle like their own. A fantastic experience.”',
        author: 'Sunita Menon',
        details: 'Vintage Car Enthusiast, Chennai',
        initial: 'S'),
  ];
}
