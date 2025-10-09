import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

class AddCustomer {
  final CustomerRepository repository;

  AddCustomer(this.repository);

  Future<void> call(Customer customer) {
    return repository.createCustomer(customer);
  }

}