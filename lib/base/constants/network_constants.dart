///product internal codes to easily know network statuses
abstract class NetworkConstants {

  //success codes
  static const int successCode = 1000;
  static const int createdCode = 1001;
  static const int logoutSuccessCode = 1002;
  static const int tokenApprovedCode = 1003;
  static const int deletedCode = 1004;
  static const int updatedCode = 1005;
  static const int uploadedCode = 1006;
  static const int entryExistsCode = 1007;

  // Error codes
  static const int incorrectUsernamePasswordCode = 2000;
  static const int invalidCredentialsCode = 2001;
  static const int creationFailedCode = 2002;
  static const int badRequestCode = 2003;
  static const int deletionFailedCode = 2004;
  static const int notFoundCode = 2005;
  static const int logoutFailedCode = 2006;
  static const int serverErrorCode = 2007;
  static const int underMaintenanceCode = 2008;
  static const int firebaseErrorCode = 2009;

  //messages
  static const String successMessage = "success";
  static const String failureMessage = "failed";
  static const String errorMessage = "error";
}
