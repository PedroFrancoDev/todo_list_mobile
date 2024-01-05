class TaskValidate {
  final regex = RegExp(r'^(?!\s*$).+');

  bool validationValue(String task) {
    if (regex.hasMatch(task)) {
      return true;
    }

    return false;
  }
}
