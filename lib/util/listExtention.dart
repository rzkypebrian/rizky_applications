extension ListExtention<T> on List<T> {
  T operator -(int index) {
    return this[this.length - 1 - index];
  }
}