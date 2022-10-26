import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:networks_app/model/products/product_model.dart';
import 'package:networks_app/services/retro/retro_client.dart';

class DetailsView extends StatelessWidget {

 final int? id;
 final String? name;
   DetailsView({super.key,required this.id,required this.name});

   var retroClient=RetroClient(Dio(BaseOptions(
    connectTimeout: 15000,
    receiveTimeout: 5000,
    sendTimeout: 15000,
   )
   )
   );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name'),
      ),

      body: FutureBuilder<Product>(
        future: retroClient.getProductUsingId(id.toString()),
        builder:(context, snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData||snapshot.hasError) {
            return const Center(
              child: Text(' You heve not hasData or has gor error '),
            );
          }
          Product? product=snapshot.data;
         return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                SizedBox(
                  height: 500,
                  child:PageView.builder(
                    itemCount: product!.images.length,
                    itemBuilder:(context, index) {
   
                      return Card(
                        child: CachedNetworkImage(
                          errorWidget:(context, url, error) => SizedBox.shrink(),
                          placeholder: (context, url) => const SizedBox.shrink(),
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.width,
                          imageUrl: product.images[index]??product.thumbnail!),
                      );
                    },
                    )
                ),
                Flexible(child: Text(product.brand??'description',style:TextStyle(
                  color: Colors.amber,fontSize: 18,
                  fontWeight: FontWeight.bold
                ),)),
                   Flexible(child: Text(product.category?? 'title',style: TextStyle(
                  color: Colors.greenAccent,fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                )
                )
            ],
          ),
         );
        },
        ),  
    );
  }
}