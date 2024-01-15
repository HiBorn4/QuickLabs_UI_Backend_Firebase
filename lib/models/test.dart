class Test {
  final String testName;
  final int noOfTests;
  final int testPrice;
  final int disTestPrice;
  bool addedToCart;

  Test({
    required this.testName,
    required this.noOfTests,
    required this.testPrice,
    required this.disTestPrice,
    required this.addedToCart,
  });
}

List<Test> createTestInstances(List<List<dynamic>> testsData) {
  return testsData.map((data) {
    return Test(
      testName: data[0] as String,
      noOfTests: data[1] as int,
      testPrice: data[2] as int,
      disTestPrice: data[3] as int,
      addedToCart: data[4] as bool,
    );
  }).toList();
}
