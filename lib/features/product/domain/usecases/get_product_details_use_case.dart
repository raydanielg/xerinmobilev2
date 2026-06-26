import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductDetailsUseCase
    extends UseCaseWithParams<ProductEntity, String> {
  final ProductRepository repository;

  GetProductDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductEntity>> call(String params) {
    return repository.getProductById(params);
  }
}
