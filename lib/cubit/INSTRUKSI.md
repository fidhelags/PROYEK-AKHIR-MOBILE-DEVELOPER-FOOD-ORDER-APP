# 🎛️ Instruksi: State Management dengan Cubit

Folder ini berisi Cubit untuk state management menggunakan package `flutter_bloc`.

## 🎯 Tujuan

Setelah mengerjakan folder ini, kamu akan:
- Memahami konsep state management
- Mampu menggunakan Cubit dan BlocProvider
- Mampu manage app state dengan baik

## 📚 Konsep Dasar

### Apa itu State Management?

State management adalah cara mengelola data/state aplikasi yang bisa berubah. Contoh:
- Data cart (tambah item, update quantity)
- Data user (login, logout)
- Data makanan dari API (loading, loaded, error)

### Cubit vs Bloc

- **Cubit**: Simple state management, hanya emit state
- **Bloc**: Lebih kompleks, menggunakan events dan states

Kita menggunakan **Cubit** karena lebih sederhana untuk pemula.

### Struktur Cubit

```dart
// 1. Define State
abstract class MyState {}

class MyInitial extends MyState {}
class MyLoaded extends MyState {
  final String data;
  MyLoaded(this.data);
}

// 2. Create Cubit
class MyCubit extends Cubit<MyState> {
  MyCubit() : super(MyInitial());
  
  void loadData() {
    emit(MyLoaded('Hello'));
  }
}

// 3. Use di Widget
BlocProvider(
  create: (context) => MyCubit(),
  child: MyWidget(),
)

// 4. Listen State
BlocBuilder<MyCubit, MyState>(
  builder: (context, state) {
    if (state is MyLoaded) {
      return Text(state.data);
    }
    return CircularProgressIndicator();
  },
)

// 5. Call Method
context.read<MyCubit>().loadData();
```

## 📝 Cubit yang Perlu Dibuat

### 1. cart_cubit.dart (Pekan 3)

**State**:
```dart
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;
  CartLoaded(this.cartItems);
}
```

**Cubit**:
```dart
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  
  List<CartItem> _cartItems = [];
  
  List<CartItem> get cartItems => _cartItems;
  
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  
  double get subtotal => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  
  double get tax => subtotal * 0.08;  // 8% tax
  
  double get deliveryFee => 0.0;  // Free delivery
  
  double get total => subtotal + tax + deliveryFee;
  
  void addToCart(CartItem cartItem) {
    // Cek apakah item sudah ada
    final existingIndex = _cartItems.indexWhere(
      (item) =>
          item.foodItem.id == cartItem.foodItem.id &&
          item.selectedSize == cartItem.selectedSize &&
          _listEquals(item.selectedExtras, cartItem.selectedExtras),
    );
    
    if (existingIndex != -1) {
      // Update quantity
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + cartItem.quantity,
      );
    } else {
      // Tambah item baru
      _cartItems.add(cartItem);
    }
    
    emit(CartLoaded(_cartItems));
  }
  
  void removeFromCart(String cartItemId) {
    _cartItems.removeWhere((item) => item.id == cartItemId);
    
    if (_cartItems.isEmpty) {
      emit(CartInitial());
    } else {
      emit(CartLoaded(_cartItems));
    }
  }
  
  void updateQuantity(String cartItemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(cartItemId);
      return;
    }
    
    final index = _cartItems.indexWhere((item) => item.id == cartItemId);
    if (index != -1) {
      _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
      emit(CartLoaded(_cartItems));
    }
  }
  
  void clearCart() {
    _cartItems.clear();
    emit(CartInitial());
  }
  
  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
```

**Cara Menggunakan**:
```dart
// Di main.dart, wrap app dengan BlocProvider
BlocProvider(
  create: (context) => CartCubit(),
  child: MyApp(),
)

// Di widget, listen state
BlocBuilder<CartCubit, CartState>(
  builder: (context, state) {
    if (state is CartLoaded) {
      return Text('Cart: ${state.cartItems.length} items');
    }
    return Text('Cart is empty');
  },
)

// Call method
context.read<CartCubit>().addToCart(cartItem);
```

---

### 2. auth_cubit.dart (Pekan 5)

**State**:
```dart
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  final String token;
  AuthSuccess(this.user, this.token);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
```

**Cubit**:
```dart
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    
    try {
      final response = await AuthService.login(
        email: email,
        password: password,
      );
      
      if (response.success && response.token != null && response.user != null) {
        // Simpan token dan user
        await StorageService.saveToken(response.token!);
        await StorageService.saveUser(response.user!);
        
        emit(AuthSuccess(response.user!, response.token!));
      } else {
        emit(AuthError(response.message ?? 'Login failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  
  Future<void> register(String name, String email, String password) async {
    emit(AuthLoading());
    
    try {
      final response = await AuthService.register(
        name: name,
        email: email,
        password: password,
      );
      
      if (response.success && response.token != null && response.user != null) {
        await StorageService.saveToken(response.token!);
        await StorageService.saveUser(response.user!);
        
        emit(AuthSuccess(response.user!, response.token!));
      } else {
        emit(AuthError(response.message ?? 'Register failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  
  Future<void> logout() async {
    await StorageService.clearAuth();
    emit(AuthInitial());
  }
  
  Future<void> checkAuth() async {
    if (StorageService.isAuthenticated()) {
      final user = StorageService.getUser();
      final token = StorageService.getToken();
      
      if (user != null && token != null) {
        emit(AuthSuccess(user, token));
      } else {
        emit(AuthInitial());
      }
    } else {
      emit(AuthInitial());
    }
  }
}
```

---

### 3. checkout_cubit.dart (Pekan 5)

**State**:
```dart
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final Order order;
  CheckoutSuccess(this.order);
}

class CheckoutError extends CheckoutState {
  final String message;
  CheckoutError(this.message);
}
```

**Cubit**:
```dart
class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  
  Future<void> createOrder({
    required Map<String, dynamic> orderData,
  }) async {
    emit(CheckoutLoading());
    
    try {
      final response = await CheckoutService.createOrder(orderData: orderData);
      
      // Parse response sesuai format API: {success: true, data: {...}}
      if (response['success'] == true && response['data'] != null) {
        final order = Order.fromJson(response['data'] as Map<String, dynamic>);
        emit(CheckoutSuccess(order));
      } else {
        emit(CheckoutError(response['message'] ?? 'Failed to create order'));
      }
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }
}
```

---

### 4. order_cubit.dart (Pekan 5)

**State**:
```dart
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  OrderLoaded(this.orders);
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}
```

**Cubit**:
```dart
class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  
  Future<void> fetchOrders({String? status}) async {
    emit(OrderLoading());
    
    try {
      // Tambahkan query parameter status jika ada
      Map<String, String>? queryParams;
      if (status != null && status.isNotEmpty) {
        queryParams = {'status': status};
      }
      
      final response = await ApiService.get(
        '/orders',
        queryParameters: queryParams,
      );
      
      // Parse response sesuai format API: {success: true, data: [...]}
      if (response['success'] == true && response['data'] != null) {
        final List<dynamic> ordersData = response['data'] as List<dynamic>;
        final orders = ordersData.map((json) => Order.fromJson(json)).toList();
        emit(OrderLoaded(orders));
      } else {
        emit(OrderError(response['message'] ?? 'Failed to fetch orders'));
      }
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
  
  Future<Order?> fetchOrderDetail(String orderId) async {
    try {
      final response = await ApiService.get('/orders/$orderId');
      
      // Parse response sesuai format API: {success: true, data: {...}}
      if (response['success'] == true && response['data'] != null) {
        return Order.fromJson(response['data'] as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
```

**Cara Menggunakan dengan Status Filter**:
```dart
// Get semua orders
context.read<OrderCubit>().fetchOrders();

// Get hanya pending orders
context.read<OrderCubit>().fetchOrders(status: 'pending');

// Get hanya completed orders
context.read<OrderCubit>().fetchOrders(status: 'completed');

// Valid status values: pending, processing, on_delivery, completed, cancelled
```

## 🔧 Langkah Pengerjaan

### Pekan 3: CartCubit
1. Buat CartState (CartInitial, CartLoaded)
2. Buat CartCubit dengan method addToCart, removeFromCart, dll
3. Setup BlocProvider di main.dart
4. Gunakan di CartPage dengan BlocBuilder

### Pekan 5: AuthCubit, CheckoutCubit, OrderCubit
1. Buat AuthCubit untuk login/register
2. Buat CheckoutCubit untuk checkout
3. Buat OrderCubit untuk order history
4. Setup semua BlocProvider di main.dart

## 💡 Tips

1. **Gunakan emit()** untuk mengubah state
2. **Jangan emit state yang sama** (akan trigger rebuild)
3. **Handle error** dengan state Error
4. **Gunakan BlocBuilder** untuk listen state
5. **Gunakan context.read<Cubit>()** untuk call method tanpa listen

## 📖 Referensi

- Flutter Bloc: https://bloclibrary.dev/
- Cubit Documentation: https://bloclibrary.dev/#/coreconcepts?id=cubit

## ✅ Checklist

- [ ] Buat CartCubit dengan state dan method (Pekan 3)
- [ ] Setup BlocProvider di main.dart (Pekan 3)
- [ ] Buat AuthCubit (Pekan 5)
- [ ] Buat CheckoutCubit dengan response parsing yang benar (Pekan 5)
- [ ] Buat OrderCubit dengan status filter support (Pekan 5)
- [ ] Test semua cubit dengan UI
- [ ] Test OrderCubit dengan berbagai status filter (pending, completed, dll)

---

**Selesai!** Sekarang kamu sudah memahami semua konsep. Lanjutkan dengan implementasi sesuai instruksi di setiap folder.

