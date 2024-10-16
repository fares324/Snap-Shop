import 'package:e_commerce/models/products.dart';
import 'package:e_commerce/provider/cart_provider.dart';
import 'package:e_commerce/screens/constans.dart';
import 'package:flutter/material.dart';

class AddToCart extends StatefulWidget {
  final Product product;
  const AddToCart({super.key, required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
        left: 15,
        right: 15,
      ),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2)),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (currentIndex != 1) {
                        setState(() {
                          currentIndex--;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    currentIndex.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex++;
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                final provider = CartProvider.of(context, listen: false);

                // Check if the product is already in the cart
                bool isInCart = provider.isInCart(widget.product);

                if (isInCart) {
                  // Show a message that the product is already in the cart
                  const snackBar = SnackBar(
                    content: Center(
                      child: Text(
                        "Already in the cart",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  // Add product to the cart
                  widget.product.quantity = currentIndex;
                  provider.tooglefavorites(widget.product);

                  // Show success message
                  const snackBar = SnackBar(
                    content: Center(
                      child: Text(
                        "Successfully added",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: kprimaryColor,
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                ),
                child: const Text(
                  "Add To Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
