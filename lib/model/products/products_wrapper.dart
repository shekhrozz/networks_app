
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:networks_app/model/products/product_model.dart';
import 'package:networks_app/model/products/int_to_String_convertor.dart';
part 'products_wrapper.freezed.dart';
part 'products_wrapper.g.dart';


@freezed
class ProductWrapper with _$ProductWrapper {
  factory ProductWrapper({
    @Default(<Product>[]) List<Product> products,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'total') @IntToStringConverterNumber() int? total,
    @JsonKey(name: 'skip') int? skip,
    @JsonKey(name: 'limit') int? limit,
  }) = _ProductWrapper;

  factory ProductWrapper.fromJson(Map<String, dynamic> json) =>
      _$ProductWrapperFromJson(json);
}