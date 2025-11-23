# 🔌 Instruksi: Membuat Service (API & Storage)

Folder ini berisi service untuk komunikasi dengan API dan local storage.

## 🎯 Tujuan

Setelah mengerjakan folder ini, kamu akan:
- Memahami cara membuat HTTP request
- Mampu menggunakan async/await dan Future
- Mampu handle error dengan try-catch
- Mampu menyimpan data ke local storage

## 📚 Konsep Dasar

### Async/Await

API call adalah operasi asynchronous (tidak langsung selesai). Gunakan `async` dan `await`:

```dart
Future<String> fetchData() async {
  final response = await http.get(url);
  return response.body;
}
```

### Future

`Future` adalah tipe data untuk operasi asynchronous. Bisa dalam 3 state:
- **Uncompleted**: Masih berjalan
- **Completed with value**: Berhasil, ada hasil
- **Completed with error**: Gagal, ada error

### Error Handling

Selalu gunakan try-catch untuk handle error:

```dart
try {
  final result = await apiCall();
  return result;
} catch (e) {
  print('Error: $e');
  throw Exception('Failed to fetch data');
}
```

### Response Format API

Semua response dari API mengikuti format standar:

**Success Response**:
```json
{
  "success": true,
  "message": "Success message",
  "data": { ... }
}
```

**Error Response**:
```json
{
  "success": false,
  "message": "Error message",
  "errors": {
    "fieldName": "Error detail for specific field"
  }
}
```

**Cara Parse Response**:
```dart
final response = await ApiService.get('/foods');

// Cek success
if (response['success'] == true && response['data'] != null) {
  final data = response['data'];
  // Process data...
} else {
  // Handle error
  final errorMessage = response['message'] ?? 'Request failed';
  final errors = response['errors']; // untuk validation errors
}
```

## 📝 Service yang Perlu Dibuat

### 1. api_service.dart (Pekan 4)

**Fungsi**: Service untuk semua HTTP request ke backend API

**Setup Base URL**:
```dart
class ApiService {
  // Base URL API yang sudah disediakan mentor
  static const String baseUrl = 'http://api-alfood.zero-dev.my.id';
}
```

**Catatan**: Base URL sudah disediakan oleh mentor, jadi langsung gunakan URL di atas.

**Method GET** (dengan support query parameters):
```dart
static Future<Map<String, dynamic>> get(
  String endpoint, {
  bool includeToken = true,
  Map<String, String>? queryParameters,
}) async {
  try {
    String fullEndpoint = endpoint;
    
    // Tambahkan query parameters jika ada
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final queryString = queryParameters.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
      fullEndpoint += '?$queryString';
    }
    
    final url = Uri.parse('$baseUrl$fullEndpoint');
    final response = await http.get(
      url,
      headers: _getHeaders(includeToken: includeToken),
    );
    
    return _handleResponse(response);
  } catch (e) {
    throw Exception('Network error: $e');
  }
}
```

**Method POST**:
```dart
static Future<Map<String, dynamic>> post(
  String endpoint,
  Map<String, dynamic> body, {
  bool includeToken = true,
}) async {
  try {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      url,
      headers: _getHeaders(includeToken: includeToken),
      body: json.encode(body),
    );
    
    return _handleResponse(response);
  } catch (e) {
    throw Exception('Network error: $e');
  }
}
```

**Helper untuk Headers**:
```dart
static Map<String, String> _getHeaders({bool includeToken = true}) {
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  if (includeToken) {
    final token = StorageService.getToken();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
  }
  
  return headers;
}
```

**Helper untuk Handle Response**:
```dart
static Map<String, dynamic> _handleResponse(http.Response response) {
  final responseData = json.decode(response.body) as Map<String, dynamic>;
  
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return responseData;
  } else {
    // Handle berbagai status code sesuai API_DOCUMENTATION.md
    final message = responseData['message'] ?? 'Request failed';
    final errors = responseData['errors'];
    
    switch (response.statusCode) {
      case 400:
        // Bad Request - Validation errors atau invalid data
        if (errors != null && errors is Map) {
          final errorMessages = (errors as Map).entries
              .map((e) => '${e.key}: ${e.value}')
              .join(', ');
          throw Exception('Validation Error: $errorMessages');
        }
        throw Exception('Bad Request: $message');
      case 401:
        // Unauthorized - Token invalid atau missing
        throw Exception('Unauthorized: Invalid or missing token');
      case 403:
        // Forbidden - No permission
        throw Exception('Forbidden: You don\'t have permission');
      case 404:
        // Not Found - Resource tidak ditemukan
        throw Exception('Not Found: $message');
      case 500:
        // Internal Server Error
        throw Exception('Server Error: Internal server error');
      default:
        throw Exception('Request failed (${response.statusCode}): $message');
    }
  }
}
```


**Cara Menggunakan**:
```dart
// GET request sederhana
final response = await ApiService.get('/foods');

// GET request dengan query parameters
final response = await ApiService.get(
  '/foods',
  queryParameters: {
    'category': 'Main Course',
    'search': 'pizza',
  },
  includeToken: false,  // endpoint public tidak perlu token
);

// POST request
final response = await ApiService.post(
  '/auth/login',
  {'email': 'user@example.com', 'password': 'password123'},
  includeToken: false,  // login tidak perlu token
);
```

---

### 2. auth_service.dart (Pekan 5)

**Fungsi**: Service untuk authentication (login, register)

**Method Register**:
```dart
static Future<AuthResponse> register({
  required String name,
  required String email,
  required String password,
}) async {
  try {
    final response = await ApiService.post(
      '/auth/register',
      {
        'name': name,
        'email': email,
        'password': password,
      },
      includeToken: false,  // register tidak perlu token
    );
    
    // Response format: {success: true, message: "...", data: {user: {...}, token: "..."}}
    // AuthResponse.fromJson harus handle format ini
    return AuthResponse.fromJson(response);
  } catch (e) {
    // Handle error - extract message dari exception
    String errorMessage = e.toString().replaceAll('Exception: ', '');
    return AuthResponse(
      success: false,
      message: errorMessage,
    );
  }
}
```

**Method Login**:
```dart
static Future<AuthResponse> login({
  required String email,
  required String password,
}) async {
  try {
    final response = await ApiService.post(
      '/auth/login',
      {
        'email': email,
        'password': password,
      },
      includeToken: false,
    );
    
    // Response format: {success: true, message: "...", data: {user: {...}, token: "..."}}
    return AuthResponse.fromJson(response);
  } catch (e) {
    String errorMessage = e.toString().replaceAll('Exception: ', '');
    return AuthResponse(
      success: false,
      message: errorMessage,
    );
  }
}
```

**Method Get Current User**:
```dart
static Future<AuthResponse> getCurrentUser() async {
  try {
    final response = await ApiService.get('/auth/me');
    
    // Response format: {success: true, message: "...", data: {id: "...", name: "...", ...}}
    // AuthResponse.fromJson harus handle format ini (data berisi user object langsung)
    return AuthResponse.fromJson(response);
  } catch (e) {
    String errorMessage = e.toString().replaceAll('Exception: ', '');
    return AuthResponse(
      success: false,
      message: errorMessage,
    );
  }
}
```

**Catatan Penting untuk AuthResponse Model**:
Model `AuthResponse` harus bisa handle format response API:
- Untuk register/login: `{success: true, data: {user: {...}, token: "..."}}`
- Untuk getCurrentUser: `{success: true, data: {id: "...", name: "...", ...}}`

Pastikan `AuthResponse.fromJson()` bisa parse kedua format tersebut.

---

### 3. storage_service.dart (Pekan 5)

**Fungsi**: Service untuk local storage menggunakan Hive

**Initialize**:
```dart
static Box? _box;

static Future<void> init() async {
  _box = await Hive.openBox('auth_box');
}
```

**Save Token**:
```dart
static Future<void> saveToken(String token) async {
  await _box?.put('access_token', token);
}
```

**Get Token**:
```dart
static String? getToken() {
  return _box?.get('access_token');
}
```

**Save User**:
```dart
static Future<void> saveUser(User user) async {
  await _box?.put('user_data', user.toJson());
}
```

**Get User**:
```dart
static User? getUser() {
  final userData = _box?.get('user_data');
  if (userData != null && userData is Map) {
    return User.fromJson(Map<String, dynamic>.from(userData));
  }
  return null;
}
```

**Clear Auth**:
```dart
static Future<void> clearAuth() async {
  await _box?.delete('access_token');
  await _box?.delete('user_data');
}
```

**Check Authentication**:
```dart
static bool isAuthenticated() {
  return getToken() != null && getToken()!.isNotEmpty;
}
```

---

### 4. checkout_service.dart (Pekan 5)

**Fungsi**: Service untuk checkout dan order

**Method Create Order**:
```dart
static Future<Map<String, dynamic>> createOrder({
  required Map<String, dynamic> orderData,
}) async {
  try {
    final response = await ApiService.post('/orders', orderData);
    
    // Response sudah dalam format: {success: true, data: {...}}
    // Return langsung karena sudah di-parse oleh ApiService
    return response;
  } catch (e) {
    throw Exception('Failed to create order: $e');
  }
}
```

**Method Apply Promo Code**:
```dart
static Future<Map<String, dynamic>> applyPromoCode(String promoCode) async {
  try {
    final response = await ApiService.post(
      '/promo/validate',
      {'code': promoCode},
      includeToken: false,  // promo validation tidak perlu token
    );
    
    // Parse response sesuai format API
    if (response['success'] == true && response['data'] != null) {
      return response['data'] as Map<String, dynamic>;
    } else {
      throw Exception(response['message'] ?? 'Invalid promo code');
    }
  } catch (e) {
    throw Exception('Invalid promo code: $e');
  }
}
```

---

### 5. food_service.dart (Pekan 4) - Opsional

**Fungsi**: Service khusus untuk food-related endpoints

**Method Get All Foods** (dengan query parameters):
```dart
static Future<List<FoodItem>> getFoods({
  String? category,
  String? search,
}) async {
  try {
    Map<String, String>? queryParams;
    
    if (category != null || search != null) {
      queryParams = {};
      if (category != null) queryParams['category'] = category;
      if (search != null) queryParams['search'] = search;
    }
    
    final response = await ApiService.get(
      '/foods',
      queryParameters: queryParams,
      includeToken: false,  // endpoint public
    );
    
    // Parse response sesuai format API: {success: true, data: [...]}
    if (response['success'] == true && response['data'] != null) {
      final List<dynamic> foodsData = response['data'] as List<dynamic>;
      return foodsData.map((json) => FoodItem.fromJson(json)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch foods');
    }
  } catch (e) {
    throw Exception('Failed to fetch foods: $e');
  }
}
```

**Method Get Food by ID**:
```dart
static Future<FoodItem> getFoodById(String foodId) async {
  try {
    final response = await ApiService.get(
      '/foods/$foodId',
      includeToken: false,  // endpoint public
    );
    
    // Parse response sesuai format API: {success: true, data: {...}}
    if (response['success'] == true && response['data'] != null) {
      return FoodItem.fromJson(response['data'] as Map<String, dynamic>);
    } else {
      throw Exception(response['message'] ?? 'Food not found');
    }
  } catch (e) {
    throw Exception('Failed to fetch food: $e');
  }
}
```

---

### 6. category_service.dart (Pekan 4) - Opsional

**Fungsi**: Service untuk fetch categories

**Method Get All Categories**:
```dart
static Future<List<Category>> getCategories() async {
  try {
    final response = await ApiService.get(
      '/categories',
      includeToken: false,  // endpoint public
    );
    
    // Parse response sesuai format API: {success: true, data: [...]}
    if (response['success'] == true && response['data'] != null) {
      final List<dynamic> categoriesData = response['data'] as List<dynamic>;
      return categoriesData.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch categories');
    }
  } catch (e) {
    throw Exception('Failed to fetch categories: $e');
  }
}
```

---

### 7. health_service.dart (Opsional - untuk testing)

**Fungsi**: Service untuk health check endpoint

**Method Health Check**:
```dart
static Future<bool> checkHealth() async {
  try {
    final response = await ApiService.get(
      '/health',
      includeToken: false,  // endpoint public
    );
    
    return response['success'] == true;
  } catch (e) {
    return false;
  }
}
```

## 🔧 Langkah Pengerjaan

### Pekan 4: ApiService
1. Install package `http` (lihat `DEPENDENCIES.md`)
2. Buat ApiService dengan method GET dan POST
3. **PENTING**: Set `baseUrl = 'http://api-alfood.zero-dev.my.id'` (sudah disediakan mentor)
4. Test dengan fetch data makanan

### Pekan 5: AuthService & StorageService
1. Setup Hive untuk local storage
2. Buat StorageService
3. Buat AuthService
4. Buat CheckoutService

## 📖 Endpoint API yang Akan Digunakan

**Base URL**: `http://api-alfood.zero-dev.my.id`

Lihat `API_DOCUMENTATION.md` di root folder untuk detail lengkap endpoint yang disediakan mentor.

**Endpoint Utama**:

### Authentication
- `POST /auth/register` - Register user baru
- `POST /auth/login` - Login user
- `GET /auth/me` - Get current user (requires authentication)

### Categories
- `GET /categories` - Get semua kategori

### Foods
- `GET /foods` - Get semua makanan
  - Query parameters: `?category=Main Course` (filter by category)
  - Query parameters: `?search=pizza` (search by name)
  - Query parameters: `?category=Dessert&search=cake` (combine filters)
- `GET /foods/:id` - Get detail makanan by ID

### Orders
- `POST /orders` - Create order/checkout (requires authentication)
- `GET /orders` - Get order history (requires authentication)
  - Query parameters: `?status=pending` (filter by status)
  - Valid status: `pending`, `processing`, `on_delivery`, `completed`, `cancelled`
- `GET /orders/:id` - Get order detail by ID (requires authentication)

### Promo
- `POST /promo/validate` - Validate promo code

### Health Check
- `GET /health` - Check server health status

**Contoh URL lengkap**:
- `http://api-alfood.zero-dev.my.id/foods`
- `http://api-alfood.zero-dev.my.id/foods?category=Main Course&search=pizza`
- `http://api-alfood.zero-dev.my.id/auth/login`
- `http://api-alfood.zero-dev.my.id/orders?status=pending`

## 💡 Tips

1. **Selalu handle error** dengan try-catch dan gunakan `_handleResponse()` untuk error handling yang konsisten
2. **Gunakan async/await** untuk operasi asynchronous
3. **Include token di header** untuk endpoint yang memerlukan authentication (set `includeToken: true`)
4. **Parse JSON response** dengan benar sesuai format API: `{success: true, data: {...}}`
5. **Gunakan query parameters** untuk filter dan search (contoh: category, search, status)
6. **Handle response format** - API selalu mengembalikan format: `{success: bool, message: string, data: {...}}`
7. **Test dengan Postman** atau tools lain sebelum implementasi
8. **Perhatikan status code** - 200/201 untuk success, 400 untuk validation error, 401 untuk unauthorized, 404 untuk not found

## 📖 Referensi

- HTTP Package: https://pub.dev/packages/http
- Hive Package: https://pub.dev/packages/hive
- Async/Await: https://dart.dev/codelabs/async-await

## ✅ Checklist

- [ ] Setup baseUrl di ApiService (Pekan 4)
- [ ] Buat method GET di ApiService dengan support query parameters (Pekan 4)
- [ ] Buat method POST di ApiService (Pekan 4)
- [ ] Buat helper `_handleResponse()` untuk error handling (Pekan 4)
- [ ] Buat StorageService dengan Hive (Pekan 5)
- [ ] Buat AuthService dengan semua method (Pekan 5)
- [ ] Buat CheckoutService dengan promo code validation (Pekan 5)
- [ ] (Opsional) Buat FoodService untuk fetch foods dengan query parameters
- [ ] (Opsional) Buat CategoryService untuk fetch categories
- [ ] Test semua service dengan API yang disediakan mentor
- [ ] Test error handling untuk berbagai status code (400, 401, 403, 404, 500)

---

**Lanjut ke**: `lib/cubit/INSTRUKSI.md` untuk membuat state management.

