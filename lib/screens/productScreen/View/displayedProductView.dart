import 'package:co_ofline/screens/productScreen/Model/displayedProductModel.dart';
import 'package:co_ofline/screens/productScreen/View/addProductView.dart';
import 'package:co_ofline/screens/productScreen/View/editProductView.dart';
import 'package:co_ofline/screens/productScreen/ViewModel/displayedProductViewModel.dart';
import 'package:co_ofline/utility/constant/color.dart';
import 'package:co_ofline/utility/widgets/appBar/View/appbarView.dart';
import 'package:co_ofline/utility/widgets/drawer/View/drawerView.dart';
import 'package:co_ofline/utility/widgets/drawer/ViewModel/drawerViewModel.dart';
import 'package:co_ofline/utility/widgets/search/View/searchView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:co_ofline/utility/constant/string_extensions.dart';

class Product_Screen extends ConsumerStatefulWidget {
  final String shopId;
  final String startingYear;

  const Product_Screen(
      {super.key, required this.shopId, required this.startingYear});

  @override
  ConsumerState<Product_Screen> createState() => _Order_ScreenState();
}

class _Order_ScreenState extends ConsumerState<Product_Screen> {
  Map<String, String?> dropdownValues = {};

  @override
  Widget build(BuildContext context) {
    final productListAsyncValue = ref.watch(productListProvider(widget.shopId));
    final isOpenBoolean = ref.watch(isOpenProvider(widget.shopId));

    double mqw = MediaQuery.of(context).size.width;
    double mqh = MediaQuery.of(context).size.height;
    print(dropdownValues);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kWhite,
        appBar: MyAppBar(
          title: MySearchBar(hintext: 'Since ${widget.startingYear}'),
        ),
        floatingActionButton: SizedBox(
          height: mqh * 125 / 2340,
          width: mqw * 118 / 1080,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Add_Product()));
            },
            backgroundColor: kWhite,
            child: const Icon(
              Icons.add,
              color: kGrey,
              size: 30,
            ),
          ),
        ),
        drawer: CustomDrawer(
            mqw: mqw,
            mqh: mqh,
            isOpenBoolean: isOpenBoolean,
            onToggleShopOpen: (value) {
              ref
                  .read(isOpenProvider(widget.shopId).notifier)
                  .updateIsShopOpen(value);
            }),
        body: productListAsyncValue.when(data: (products) {
          List<ProductModel> inStockProducts =
              products.where((product) => product.inStock).toList();

          return Padding(
            padding: EdgeInsets.only(top: mqh * 20 / 2340),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14.0,
                childAspectRatio: 0.8,
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                Map<String, dynamic> unsortedMap = product.sizeVariants;
                List<MapEntry<String, dynamic>> sortedEntries = unsortedMap.entries.toList();

                // Sort the list based on the values
                sortedEntries.sort((a, b) => a.value.compareTo(b.value));

                // Convert the sorted list back to a map
                Map<String, dynamic> sortedMap = Map.fromEntries(sortedEntries);

                // Initialize dropdown value for each product if not already initialized
                dropdownValues.putIfAbsent(
                    products[index].product_name, () => sortedMap.keys.first);

                return Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0.5, 1.00),
                          color: Color.fromRGBO(230, 230, 231, 0.3),
                          blurRadius: 2.0,
                        ),
                        BoxShadow(
                          offset: Offset(-1, 0.3),
                          color: Color.fromRGBO(125, 125, 125, 0.15),
                          blurRadius: 2.0,
                        ),
                      ],
                      color: kWhite,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: mqh * 350 / 2340,
                              width: mqw * 530 / 1080,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18.0),
                                  topRight: Radius.circular(18.0),
                                ),
                                child: Image.network(
                                  product.product_image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            product.isVeg?
                            Positioned(
                                    right: mqw*35/1080,
                                    top: mqh*40/2340,
                                    child: Container(
                                      height: mqh*53/2340,
                                      width: mqw* 48/1080,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.green, width: 1.5),
                                          color: kWhite, borderRadius: BorderRadius.circular(6)),
                                      child: const Center(
                                        child: CircleAvatar(backgroundColor: Colors.green, radius: 5),
                                      ),

                                    ),
                                  ): const SizedBox( height:2,width:2),

                          ]
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: mqh * 30 / 2340,
                            left: mqw * 32 / 1080,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: mqw * 250 / 1080,
                                height: mqh * 115 / 2340,
                                child: Text(
                                  product.product_name.toTitleCase(),
                                  maxLines: 2,
                                  textDirection: TextDirection.ltr,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.7,
                                    fontWeight: FontWeight.w500,
                                    color: product.inStock ? kGrey : kRed,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                width: mqw * 160 / 1080,
                                height: mqh * 110 / 2340,
                                child: Text(
                                  "₹${sortedMap[dropdownValues[products[index].product_name]]}",
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: product.inStock ? kGrey : kRed,
                                    fontSize: 13.7,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: mqh * 10 / 2340,
                            bottom: mqh * 15 / 2340,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                               sortedMap.keys.first != "size"
                                  ? DropdownButton<String>(
                                      value: dropdownValues[products[index].product_name],
                                      underline: Container(
                                        color: kWhite,
                                      ),
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        color: product.inStock ? kGrey : kRed,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      icon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                        color: product.inStock ? kGrey : kRed,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValues[products[index].product_name] = newValue;
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(10),
                                      dropdownColor: kWhite,
                                      items: [
                                        ...sortedMap.keys
                                            .map((String category) {
                                          return DropdownMenuItem<String>(
                                            value: category,
                                            child: Text(category.toTitleCase()),
                                          );
                                        }).toList()
                                      ],
                                    )
                                  : const SizedBox(height: 48, width: 54),
                              SizedBox(
                                width: mqw * 50 / 1080,
                              ),
                              CircleAvatar(
                                backgroundColor:
                                    product.inStock ? kChipColor : kRed,
                                radius: 15,
                                child: Center(
                                    child: PopupMenuButton(
                                        shadowColor: kWhite,
                                        color: kWhite,
                                        surfaceTintColor: kWhite,
                                        iconSize: 14,
                                        icon: Icon(Icons.more_vert,
                                            color: product.inStock
                                                ? kGrey
                                                : kWhite),
                                        // color: kWhite,
                                        enabled: true,
                                        onSelected: (value) {
                                        },
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry>[
                                              PopupMenuItem(
                                                  child: Text(
                                                    product.inStock
                                                        ? 'Out of stock'
                                                        : 'In Stock',
                                                    style: const TextStyle(
                                                        color: kGrey),
                                                  ),
                                              onTap: () {
                                                final updateStatus = ref.watch(updateStatusProvider(UpdateStockParams(widget.shopId, product.id, product.inStock)));
                                              },),
                                              PopupMenuItem(
                                                  value: 'Delete',
                                                  child: const Text(
                                                    'Delete',
                                                    style:
                                                    TextStyle(color: kGrey),
                                                  ),
                                                onTap: () {
                                                  final deletePrduct = ref.watch(deleteProductProvider(UpdateStockParams(widget.shopId, product.id, product.inStock)));
                                                },
                                              ),
                                              PopupMenuItem(
                                                  value: 'Edit',
                                                  child: const Text(
                                                    'Edit',
                                                    style:
                                                        TextStyle(color: kGrey),
                                                  ),
                                                onTap: () {
                                                  Navigator.of(context,rootNavigator: true).push(
                                                      MaterialPageRoute(
                                                        maintainState: true,
                                                          builder: (context) =>  Edit_Product(shopId: widget.shopId, productId: product.id,)
                                                      )
                                                  );
                                                },
                                              )
                                            ])),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }, error: (error, stackTrace) {
          return Center(child: Text('Error: $error'));
        }, loading: () {
          return const CircularProgressIndicator(color: Colors.transparent);
        }),
      ),
    );
  }
}
