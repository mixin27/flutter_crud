import 'package:flutter_crud/auth/core/shared/auth_providers.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final obscureTextProvider = StateProvider<bool>(
  (ref) => true,
);

final passwordValidatorProvider = Provider(
  (ref) => MultiValidator([
    RequiredValidator(errorText: 'Password is required.'),
  ]),
);

final emailValidatorProvider = Provider(
  (ref) => MultiValidator([
    RequiredValidator(errorText: 'Email is required.'),
    EmailValidator(errorText: 'Please provide a valid email address.')
  ]),
);
final nameValidatorProvider = Provider(
  (ref) => MultiValidator([
    RequiredValidator(errorText: 'Name is required.'),
  ]),
);
final phoneValidatorProvider = Provider(
  (ref) => MultiValidator([
    RequiredValidator(errorText: 'Phone number is required.'),
  ]),
);

final isInAuthProgressProvider = StateProvider<bool>(
  (ref) => ref.watch(authNotifierProvider).maybeWhen(
        orElse: () => false,
        inProgress: () => true,
      ),
);
