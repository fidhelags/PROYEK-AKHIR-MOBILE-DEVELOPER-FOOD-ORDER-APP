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
