// TODO: Buat AuthCubit untuk state management authentication
// 
// State yang perlu dibuat:
// - AuthInitial: State awal
// - AuthLoading: State saat proses login/register
// - AuthSuccess: State saat login/register berhasil (berisi User dan token)
// - AuthError: State saat terjadi error (berisi error message)
//
// Method yang perlu dibuat:
// - Future<void> login(String email, String password)
//   - Set state ke AuthLoading
//   - Panggil AuthService.login()
//   - Jika berhasil: simpan token dan user ke StorageService, emit AuthSuccess
//   - Jika gagal: emit AuthError
//
// - Future<void> register(String name, String email, String password)
//   - Set state ke AuthLoading
//   - Panggil AuthService.register()
//   - Jika berhasil: simpan token dan user ke StorageService, emit AuthSuccess
//   - Jika gagal: emit AuthError
//
// - Future<void> logout()
//   - Clear token dan user dari StorageService
//   - Emit AuthInitial
//
// - Future<void> checkAuth()
//   - Cek apakah ada token di StorageService
//   - Jika ada: ambil user data, emit AuthSuccess
//   - Jika tidak: emit AuthInitial
//
// Catatan:
// - Extends Cubit<AuthState>
// - Gunakan emit() untuk mengubah state
//
// Lihat INSTRUKSI.md di folder cubit/ untuk panduan lengkap.

// TODO: Buat AuthCubit untuk state management authentication
// 
// State yang perlu dibuat:
// - AuthInitial: State awal
// - AuthLoading: State saat proses login/register
// - AuthSuccess: State saat login/register berhasil (berisi User dan token)
// - AuthError: State saat terjadi error (berisi error message)
//
// Method yang perlu dibuat:
// - Future<void> login(String email, String password)
//   - Set state ke AuthLoading
//   - Panggil AuthService.login()
//   - Jika berhasil: simpan token dan user ke StorageService, emit AuthSuccess
//   - Jika gagal: emit AuthError
//
// - Future<void> register(String name, String email, String password)
//   - Set state ke AuthLoading
//   - Panggil AuthService.register()
//   - Jika berhasil: simpan token dan user ke StorageService, emit AuthSuccess
//   - Jika gagal: emit AuthError
//
// - Future<void> logout()
//   - Clear token dan user dari StorageService
//   - Emit AuthInitial
//
// - Future<void> checkAuth()
//   - Cek apakah ada token di StorageService
//   - Jika ada: ambil user data, emit AuthSuccess
//   - Jika tidak: emit AuthInitial
//
// Catatan:
// - Extends Cubit<AuthState>
// - Gunakan emit() untuk mengubah state
//
// Lihat INSTRUKSI.md di folder cubit/ untuk panduan lengkap.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user.dart';
import '../services/auth_service.dart'; 
import '../services/storage_service.dart'; 

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
        await StorageService.clearAuth();
        emit(AuthInitial());
      }
    } else {
      emit(AuthInitial());
    }
  }
}