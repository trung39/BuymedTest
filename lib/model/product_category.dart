enum ProductCategory {
  painRelief, antibiotic, supplement, allergy;

  String get text {
    return switch (this) {
      painRelief => 'Pain Relief',
      antibiotic => 'Antibiotic',
      supplement => 'Supplement',
      allergy => 'Allergy',
    };
  }
}