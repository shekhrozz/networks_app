
import 'package:dio/dio.dart';
import 'package:networks_app/model/products/product_model.dart';
import 'package:networks_app/model/products/products_wrapper.dart';
import 'package:retrofit/retrofit.dart';
part 'retro_client.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com')
abstract class RetroClient {
  factory RetroClient(Dio dio, {String? baseUrl}) = _RetroClient;

  @GET('/products')
  Future<ProductWrapper> getProducts();

 @GET('/products/{id}')
 Future<Product> getProductUsingId(@Path('id') String id);

 
}