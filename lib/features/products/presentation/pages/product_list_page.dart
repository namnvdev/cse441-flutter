import 'package:flutter/material.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/domain/usecases/get_products.dart';
import '../widgets/product_card.dart';

class ProductListPage extends StatefulWidget {
  final GetProducts getProducts;
  const ProductListPage({super.key, required this.getProducts});

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
                    itemBuilder: (ctx, i) => ProductCard(product: _items[i]),
                  ),
                ),
    );
  }
}
