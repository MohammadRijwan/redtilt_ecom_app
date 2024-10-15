import 'package:flutter/material.dart';

class AddRemoveProductButton extends StatelessWidget {
  final int quantity;
  final Function addProduct;
  final Function removeProduct;
  const AddRemoveProductButton(
      {super.key,
      required this.quantity,
      required this.addProduct,
      required this.removeProduct});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    removeProduct();
                  },
                  child: const Icon(
                    Icons.remove,
                    size: 20,
                  ),
                ),
                Text('$quantity'),
                GestureDetector(
                  onTap: () {
                    addProduct();
                  },
                  child: const Icon(
                    Icons.add,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
