import '../repositories/customer_repository.dart';

class DeleteCustomer {
  final CustomerRepository repository;

  DeleteCustomer(this.repository);

  Future<void> call(String id) async {
    await repository.deleteCustomer(id);
  }


}