/*import 'package:reactive_forms/reactive_forms.dart';

class ReactiveConst {
  static const email = "email";
  static const password = "password";
  static const confirmPassword = "confirmPassword";
  static const answers = "answers";

  static const phone = "phone";
  static const userName = "userName";



  static ValidatorFunction mustMatch(
      String controlName, String matchingControlName) {
    return (AbstractControl<dynamic> control) {
      final form = control as FormGroup;

      final formControl = form.control(controlName);
      final matchingFormControl = form.control(matchingControlName);

      if (formControl.value != matchingFormControl.value) {
        matchingFormControl.setErrors({'': true});

        // force messages to show up as soon as possible
        matchingFormControl.markAsTouched();
      } else {
        matchingFormControl.removeError('');
      }

      return null;
    };
  }
}
*/
