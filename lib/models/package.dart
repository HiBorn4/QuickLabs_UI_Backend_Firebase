class Package {
  final String packageName;
  final int noOfTests;
  final List<String> deepTests;
  final int packagePrice;
  final int disPackagePrice;
  bool addedToCart;

  Package(
      {required this.packageName,
      required this.noOfTests,
      required this.deepTests,
      required this.packagePrice,
      required this.disPackagePrice,
      required this.addedToCart});
}

List<Package> createPackageInstances(List<List<dynamic>> packagesData) {
  return packagesData.map((data) {
    return Package(
      packageName: data[0] as String,
      noOfTests: data[1] as int,
      deepTests: List<String>.from(data[2]),
      packagePrice: data[3] as int,
      disPackagePrice: data[4] as int,
      addedToCart: data[5] as bool,
    );
  }).toList();
}
