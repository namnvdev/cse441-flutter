import 'package:flutter/material.dart';
import '../widgets/product_form_dialog.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/update_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../widgets/product_card.dart';

class ProductListPage extends StatefulWidget {
  final GetProducts getProducts;
  final CreateProduct createProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;

  const ProductListPage({
    super.key, 
    required this.getProducts,
    required this.createProduct,
    required this.updateProduct,
    required this.deleteProduct,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  bool _loading = true;
  String? _error;
  List<Product> _items = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final data = await widget.getProducts();
      setState(() { _items = data; });
    } catch (e) {
      setState(() { _error = e.toString(); });
    } finally {
      setState(() { _loading = false; });
    }
  }

  Future<void> _createProduct() async {
    final product = await showDialog<Product>(
        context: context,
        builder: (_) => const ProductFormDialog());
    
    if (product == null) return;
    try {
      final data = await widget.createProduct(product);
      setState(() { _items.add(data); });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

    Future<void> _editProduct(Product product) async {
    final updated = await showDialog<Product>(
      context: context,
      builder: (_) => ProductFormDialog(product: product),
    );
    if (updated != null) {
      await widget.updateProduct(updated);
      _load();
    }
  }

  Future<void> _deleteProduct(String id) async {
    await widget.deleteProduct(id);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách sản phẩm')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Lỗi: $_error'),
                      const SizedBox(height: 8),
                      OutlinedButton(onPressed: _load, child: const Text('Thử lại'))
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    itemCount: _items.length,
                     itemBuilder: (ctx, i) {
                      return ProductCard(
                        product: _items[i],
                        onEdit: () => _editProduct(_items[i]),
                        onDelete: () => _deleteProduct(_items[i].id),
                      );
                    },
                  ),
                ),
            floatingActionButton: FloatingActionButton(
                onPressed: _createProduct,
                child: const Icon(Icons.add),
              ),
    
    );
  }
}
