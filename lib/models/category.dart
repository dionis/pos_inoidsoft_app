class Category {
  final String title;
  final String image;

  Category({required this.title, required this.image});
}

final List<Category> categories = [
  Category(title: "Shoes", image: "images/shoes.png"),
  Category(title: "Beauty", image: "images/beauty.png"),
  Category(title: "Jewelery", image: "images/jewelry.png"),
  Category(title: "men's\nFashion", image: "images/men.png"),
];
