class AuthErrorHandler {
  static getErrorMessage(error) {
    String errorMessage = '';
    print(error.code);
    switch (error.code) {
      case 'user-not-found':
        errorMessage = 'User not found. Please check your email or register.';
        break;
      case 'wrong-password':
        errorMessage = 'Incorrect password. Please try again.';
        break;
      case 'network-request-failed':
        errorMessage =
            'Network request failed. Please check your internet connection.';
        break;
      // Add more cases for other Firebase sign-in related error codes as needed
      case 'email-already-in-use':
        errorMessage =
            'Email is already in use. Please use a different email or sign in.';
        break;
      case 'invalid-email':
        errorMessage = 'Invalid email address. Please enter a valid email.';
        break;
      case 'weak-password':
        errorMessage = 'Weak password. Please use a stronger password.';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many requests! please wait before trying again';
        break;
      // Add more cases for other Firebase sign-up related error codes as needed
      default:
        errorMessage = 'An error occurred. Please try again later.';
        break;
    }

    return errorMessage;
  }
}
