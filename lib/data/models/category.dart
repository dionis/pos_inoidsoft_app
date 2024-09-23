class Category {
  final String title;
  final String image;

  Category({required this.title, required this.image});
}

final List<Category> categories = [
  // Category(title: "Shoes", image: "images/shoes.png"),
  // Category(title: "Beauty", image: "images/beauty.png"),
  // Category(title: "Jewelery", image: "images/jewelry.png"),
  // Category(title: "men's\nFashion", image: "images/men.png"),
];

Map<String, String> itemCategoriesEsMap = {
  'Electrónicos': 'assets/categories/electronic.jpg',
  'Ropas': 'assets/categories/woman_cloths.jpg',
  'Libros': 'assets/categories/books.png',
  'Jardín': 'assets/categories/home-jardin.jpg',
  'Deportes': 'assets/categories/sports.jpg',
  'Belleza ': 'images/beauty.png',
  'Juguetes': 'assets/categories/toys.jpg',
  'Carros': 'assets/categories/cars.png',
  'Dulces': 'assets/categories/grocery.jpg',
  'Salud': 'assets/categories/health.png',
  'Mascotas': 'assets/categories/pets.jpg',
  'Oficina': 'assets/categories/offices.jpg',
  'Joyas': 'images/jewelry.png',
  'Ferreteria': 'assets/categories/hardware_store.png',
  'Bebes': 'assets/categories/bebes.jpg',
  'Musica': 'assets/categories/music.png',
  'Zapatos': 'images/shoes.png',
  'Otros': 'assets/no-image.jpg'
};
