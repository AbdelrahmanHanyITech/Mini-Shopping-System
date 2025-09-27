import 'dart:io';

void main() {
  // Map for products
  Map<int, Map<String, dynamic>> products = {
    1: {"name": "Laptop", "price": 15000},
    2: {"name": "Smartphone", "price": 8000},
    3: {"name": "Headphones", "price": 1200},
    4: {"name": "Keyboard", "price": 700},
    5: {"name": "Mouse", "price": 400},
  };

  Map<int, int> cart = {};  // cart

  // welcome message
  stdout.write("Welcome! Please enter your name: ");
  String? name = stdin.readLineSync();
  print("Hi $name!\n");

  bool shopping = true;
  while (shopping) {
    // show products
    print("\nProducts:");
    products.forEach((k, v) {
      print("$k. ${v['name']} - ${v['price']} EGP");
    });

    // choose products
    stdout.write("Enter product number: ");
    int choice = int.parse(stdin.readLineSync()!);
    if (!products.containsKey(choice)) continue;

    stdout.write("How many ${products[choice]!['name']}? ");
    int qty = int.parse(stdin.readLineSync()!);
    cart[choice] = (cart[choice] ?? 0) + qty;

    // show cart 
    print("\nCart:");
    int total = 0, i = 1;
    cart.forEach((k, q) {
      int price = products[k]!['price'];
      int sub = price * q;
      total += sub;
      print("$i. ${products[k]!['name']} - $price EGP x$q = $sub EGP");
      i++;
    });
    print("Subtotal = $total EGP");

    stdout.write("Add more? (yes/no): ");
    if (stdin.readLineSync()!.toLowerCase() != "yes") shopping = false;
  }

  // delete product
  stdout.write("\nRemove something? (yes/no): ");

  if (stdin.readLineSync()!.toLowerCase() == "yes") {
    stdout.write("Enter product number: ");
    int r = int.parse(stdin.readLineSync()!);
    if (cart.containsKey(r)) {
      stdout.write("Remove all or one? (all/one): ");
      String t = stdin.readLineSync()!;
      if (t == "all") cart.remove(r);
      else cart[r] = cart[r]! - 1 <= 0 ? 0 : cart[r]! - 1;

      if (cart[r] == 0) cart.remove(r);
    }
  }

  // receit
  print("\nFinal Cart:");
  int total = 0, i = 1;
  cart.forEach((k, q) {
    int price = products[k]!['price'];
    int sub = price * q;
    total += sub;
    print("$i. ${products[k]!['name']} - $price EGP x$q = $sub EGP");
    i++;
  });
  print("Total = $total EGP");

  // payment
  print("\nPayment method: 1. Visa  2. Cash");
  int pay = int.parse(stdin.readLineSync()!);
  if (pay == 1) {
    stdout.write("Name on card: ");
    stdin.readLineSync();
    stdout.write("Card number: ");
    stdin.readLineSync();
    String? cvv;
    do {
      stdout.write("CVV (3 digits): ");
      cvv = stdin.readLineSync();
    } while (cvv == null || cvv.length != 3 || int.tryParse(cvv) == null);

    print("\n payment Successful .  $total EGP has been deducted from your Visa. Thank you!");
  } else {
    print("\nPlease prepare $total EGP cash. Thank you!");
  }

  print("\nThanks for shopping with us, $name!");
}