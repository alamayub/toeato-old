// login exceptions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

class UserDisabledAuthException implements Exception {}

// register exceptions
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// generic exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

class CouldNotCreateUserException implements Exception {}

// link with credential
class InvalidPhoneNumberAuthException implements Exception {}

class ProviderAlreadyLinkedAuthException implements Exception {}

class InvalidCredentialAuthException implements Exception {}

class CredentialAlreadyUsedByOtherAccountAuthException implements Exception {}

class EmailAlreadyInUseByOtherAccountAuthException implements Exception {}

class OperationNotAllowedAuthException implements Exception {}

class InvalidVerificationCodeAuthException implements Exception {}

class InvalidVerificationIdAuthException implements Exception {}

class AccountExistWithDifferentCredentialAuthException implements Exception {}
