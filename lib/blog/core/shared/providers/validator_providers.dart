import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final nameValidatorProvider = Provider(
  (ref) => MultiValidator([RequiredValidator(errorText: 'Name is required')]),
);

final titleValidatorProvider = Provider(
  (ref) => MultiValidator([RequiredValidator(errorText: 'Title is required')]),
);

final contentValidatorProvider = Provider(
  (ref) =>
      MultiValidator([RequiredValidator(errorText: 'Content is required')]),
);
