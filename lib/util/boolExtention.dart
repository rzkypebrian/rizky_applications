extension BoolExtention on bool {
  bool toggle() {
    if (this == true) {
      return false;
    } else {
      return true;
    }
  }
}
