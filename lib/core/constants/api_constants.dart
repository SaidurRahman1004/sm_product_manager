class ApiConstants {
  // baseUrl
  static const String baseUrl = 'https://product-management-seven-xi.vercel.app/api/v1';

  // Auth Endpoint
  static const String login = '/auth/login';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resetPassword = '/auth/reset-password';
  static const String resendOtp = '/auth/resend-otp';
  static const String profile = '/auth/profile';

  // UserEndpoints
  static const String register = '/users/register';
  static const String completeProfile = '/users/complete-profile';
  static const String updateProfile = '/users/profile';

  // ProductEndpoints
  static const String products = '/products';
}