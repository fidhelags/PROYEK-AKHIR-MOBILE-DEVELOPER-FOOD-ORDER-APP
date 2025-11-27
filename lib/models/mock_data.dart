import '../models/food_item.dart';
import '../models/category.dart';
import '../models/extra_item.dart';
import '../models/review.dart';

class MockData {
  static List<Category> getCategories() {
    return [
      Category(id: '1', name: 'Pizza'),
      Category(id: '2', name: 'Burgers'),
      Category(id: '3', name: 'Chicken'),
      Category(id: '4', name: 'Seafood'),
      Category(id: '5', name: 'Drink'),
    ];
  }

  static List<FoodItem> getFoodItems() {
    return [
      FoodItem(
        id: '1',
        name: 'Classic Beef Burger',
        description:
            'Premium beef patty with fresh lettuce, tomato, onion, and our special sauce.',
        price: 12.99,
        rating: 4.8,
        imageUrl: 'assets/images/classic-beef-burger.jpeg',
        category: 'Burger',
        ingredients: ['Beef', 'Lettuce', 'Tomato', 'Cheese'],
        deliveryTime: '15-20 min',
        sizeOptions: {'Small': 0.0, 'Medium': 2.0, 'Large': 4.0},
        extras: [
          ExtraItem(
            id: '1',
            name: 'Extra Cheese',
            description: 'Melted cheddar cheese',
            price: 1.50,
          ),
          ExtraItem(
            id: '2',
            name: 'Bacon',
            description: 'Crispy bacon strips',
            price: 2.00,
          ),
          ExtraItem(
            id: '3',
            name: 'Avocado',
            description: 'Fresh sliced avocado',
            price: 1.00,
          ),
        ],
        reviews: [
          Review(
            id: '1',
            userId: 'u1',
            userName: 'Sarah M.',
            rating: 5.0,
            comment:
                'Amazing burger! The beef was perfectly cooked and the ingredients were fresh.',
            createdAt: DateTime(2024, 6, 1, 10, 30),
          ),
          Review(
            id: '2',
            userId: 'u2',
            userName: 'Mike R.',
            rating: 5.0,
            comment: 'Best burger in town! Quick delivery and great taste.',
            createdAt: DateTime(2024, 6, 2, 14, 15),
          ),
        ],
      ),
      FoodItem(
        id: '2',
        name: 'Margherita Pizza',
        description:
            'Classic Italian pizza with fresh mozzarella, tomato sauce, and basil leaves.',
        price: 18.99,
        rating: 4.3,
        imageUrl: 'assets/images/margherita-pizza.png',
        category: 'Pizza',
        ingredients: ['Mozzarella', 'Tomato Sauce', 'Basil', 'Olive Oil'],
        deliveryTime: '20-25 min',
        sizeOptions: {'Small': 0.0, 'Medium': 3.0, 'Large': 6.0},
      ),
      FoodItem(
        id: '3',
        name: 'Crispy Chicken Wings',
        description:
            'Spicy crispy chicken wings served with ranch dipping sauce.',
        price: 14.99,
        rating: 4.2,
        imageUrl: 'assets/images/crispy-chicken-wings.jpeg',
        category: 'Chicken',
        ingredients: ['Chicken', 'Spices', 'Flour', 'Oil'],
        deliveryTime: '12-15 min',
        sizeOptions: {'6 pieces': 0.0, '12 pieces': 5.0, '24 pieces': 10.0},
      ),
      FoodItem(
        id: '6',
        name: 'Pepperoni Pizza',
        description:
            'Classic pepperoni pizza with melted cheese and spicy pepperoni.',
        price: 16.99,
        rating: 4.1,
        imageUrl: 'assets/images/pepperoni-pizza.jpeg',
        category: 'Pizza',
        ingredients: ['Pepperoni', 'Mozzarella', 'Tomato Sauce', 'Herbs'],
        deliveryTime: '20-25 min',
        sizeOptions: {'Small': 0.0, 'Medium': 3.0, 'Large': 6.0},
      ),
    ];
  }
}
