import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:networks_app/model/products/product_model.dart';
import 'package:networks_app/pages/product/detail/details_view.dart';
import 'package:networks_app/services/retro/retro_client.dart';
import 'package:networks_app/model/products/products_wrapper.dart';
import 'package:dio/dio.dart';
class ProductView extends StatelessWidget {
   ProductView({super.key});
  var client=RetroClient(Dio(BaseOptions(
    connectTimeout: 15000,
    receiveTimeout: 5000,
    sendTimeout: 15000
  )));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: SafeArea(child: FutureBuilder(
        future: client.getProducts(),
        builder:(context, snapshot) {
        if (snapshot.connectionState==ConnectionState.waiting) {
          
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData||snapshot.hasError) {
          return const Center(
            child: Text('You have an error'),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.products.length,

          itemBuilder:(context, index) {
            Product? product=snapshot.data!.products[index];
            return ListTile(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:(context) => DetailsView(id: product.id, name:product.title),));
              },
              leading: CachedNetworkImage(imageUrl: product.images[0]??product.thumbnail!,
              errorWidget: (context, url, error) => const SizedBox.shrink(),
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              ),
              title: Text(product.title?? 'product'),
              subtitle:Text(product.brand?? 'brand'),
            );
        },
        );
      },
      )
      )
    );
  }
}