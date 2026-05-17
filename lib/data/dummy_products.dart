// lib/data/dummy_products.dart

import '../models/product_model.dart';

// ─── Toko Dummy ───────────────────────────────────────────────────────────────

const _ecoFutureStore = StoreInfo(
  storeName: 'Eco Future Store',
  storeProfileImage: 'https://i.pravatar.cc/150?img=11',
  totalSales: 24100,
);

const _greenHomeStore = StoreInfo(
  storeName: 'Green Home Store',
  storeProfileImage: 'https://i.pravatar.cc/150?img=12',
  totalSales: 18500,
);

const _naturePlantStore = StoreInfo(
  storeName: 'Nature Plant Store',
  storeProfileImage: 'https://i.pravatar.cc/150?img=13',
  totalSales: 9830,
);

const _zabrinaStore = StoreInfo(
  storeName: 'Zabrina Dress',
  storeProfileImage: 'https://i.pravatar.cc/150?img=14',
  totalSales: 53900,
);

// ─── Flash Sale Products ───────────────────────────────────────────────────────

final List<Product> flashSaleProducts = [
  Product(
    id: 'fs_001',
    name: 'Bioplastic Ramah Lingkungan',
    price: 15000,
    originalPrice: 20000,
    description:
        'Bioplastik terbuat dari bahan alami dan dapat terurai secara hayati. '
        'Selalu tejat utuh. Mengurangi limbah plastik konvensional.',
    imageUrl: 'https://images.unsplash.com/photo-1618160702438-9b02ab6515c9?w=300',
    rating: 4.8,
    reviewCount: 2418,
    storeInfo: _ecoFutureStore,
    badge: 'Flash Sale',
    discountPercent: 25,
    isFreeShipping: true,
  ),
  Product(
    id: 'fs_002',
    name: 'Biomass Pupuk Organik',
    price: 40000,
    originalPrice: 55000,
    description:
        'Pupuk organik dari biomassa berkualitas tinggi. '
        'Menyuburkan tanaman secara alami tanpa bahan kimia berbahaya.',
    imageUrl: 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=300',
    rating: 4.7,
    reviewCount: 1230,
    storeInfo: _greenHomeStore,
    badge: 'Flash Sale',
    discountPercent: 27,
  ),
  Product(
    id: 'fs_003',
    name: 'Biobattery Portable',
    price: 45000,
    originalPrice: 65000,
    description:
        'Baterai portabel ramah lingkungan berbasis teknologi bio. '
        'Dapat diisi ulang dan menggunakan material daur ulang.',
    imageUrl: 'https://images.unsplash.com/photo-1585771724684-38269d6639fd?w=300',
    rating: 4.5,
    reviewCount: 876,
    storeInfo: _ecoFutureStore,
    badge: 'Flash Sale',
    discountPercent: 30,
  ),
  Product(
    id: 'fs_004',
    name: 'Tas Kanvas Eco Premium',
    price: 85000,
    originalPrice: 120000,
    description:
        'Tas kanvas premium dengan desain stylish dan ramah lingkungan. '
        'Terbuat dari bahan kanvas daur ulang berkualitas tinggi.',
    imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=300',
    rating: 4.9,
    reviewCount: 3412,
    storeInfo: _zabrinaStore,
    badge: 'Terlaris',
    discountPercent: 29,
    isFreeShipping: true,
  ),
];

// ─── Grid / Pilihan Untukmu Products ─────────────────────────────────────────

final List<Product> recommendedProducts = [
  Product(
    id: 'rec_001',
    name: 'Pot Tanaman Minimalis',
    price: 35000,
    originalPrice: 35000,
    description:
        'Pot tanaman dengan desain minimalis modern. '
        'Terbuat dari semen daur ulang, cocok untuk dekorasi indoor.',
    imageUrl: 'https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=300',
    rating: 4.6,
    reviewCount: 521,
    storeInfo: _naturePlantStore,
    isFreeShipping: true,
  ),
  Product(
    id: 'rec_002',
    name: 'Tas Belanja Jaring Alami',
    price: 25000,
    originalPrice: 32000,
    description:
        'Tas belanja dari bahan jaring alami yang kuat dan awet. '
        'Pengganti kantong plastik yang stylish.',
    imageUrl: 'https://images.unsplash.com/photo-1597484661643-2f5fef640dd1?w=300',
    rating: 4.4,
    reviewCount: 315,
    storeInfo: _greenHomeStore,
    discountPercent: 22,
  ),
  Product(
    id: 'rec_003',
    name: 'Sabun Batang Organik',
    price: 18000,
    originalPrice: 22000,
    description:
        'Sabun batang 100% organik dari minyak kelapa murni. '
        'Tanpa SLS, paraben, dan bahan kimia keras.',
    imageUrl: 'https://images.unsplash.com/photo-1607006344380-b6775a0824a7?w=300',
    rating: 4.8,
    reviewCount: 1897,
    storeInfo: _ecoFutureStore,
    discountPercent: 18,
    isFreeShipping: true,
  ),
  Product(
    id: 'rec_004',
    name: 'Sikat Gigi Bambu',
    price: 12000,
    originalPrice: 15000,
    description:
        'Sikat gigi ramah lingkungan dari bambu organik. '
        'Gagang bambu terurai secara alami di alam.',
    imageUrl: 'https://images.unsplash.com/photo-1607613009820-a29f7bb81c04?w=300',
    rating: 4.7,
    reviewCount: 2103,
    storeInfo: _ecoFutureStore,
    discountPercent: 20,
  ),
  Product(
    id: 'rec_005',
    name: 'Lilin Aromaterapi Kedelai',
    price: 55000,
    originalPrice: 70000,
    description:
        'Lilin aromaterapi dari minyak kedelai alami. '
        'Terbakar lebih lama, bebas racun, aroma alami lavender.',
    imageUrl: 'https://images.unsplash.com/photo-1602607144478-5b6c0b5e1f91?w=300',
    rating: 4.9,
    reviewCount: 734,
    storeInfo: _naturePlantStore,
    badge: 'Terpopuler',
    discountPercent: 21,
    isFreeShipping: true,
  ),
  Product(
    id: 'rec_006',
    name: 'Botol Minum Stainless',
    price: 75000,
    originalPrice: 95000,
    description:
        'Botol minum stainless steel food grade. '
        'Menjaga suhu minuman hingga 12 jam. Bebas BPA.',
    imageUrl: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=300',
    rating: 4.8,
    reviewCount: 4521,
    storeInfo: _greenHomeStore,
    badge: 'Pilihan Editor',
    discountPercent: 21,
    isFreeShipping: true,
  ),
];

// ─── Toko Ekslusif ─────────────────────────────────────────────────────────

final List<Map<String, dynamic>> exclusiveStores = [
  {
    'name': 'Budi Speed',
    'image': 'https://i.pravatar.cc/150?img=21',
    'sales': '291.100 Pengikut',
  },
  {
    'name': 'Fall Store',
    'image': 'https://i.pravatar.cc/150?img=22',
    'sales': '241.260 Pengikut',
  },
  {
    'name': 'Zabrina Dress',
    'image': 'https://i.pravatar.cc/150?img=23',
    'sales': '53.908 Pengikut',
  },
  {
    'name': 'Tirza Store',
    'image': 'https://i.pravatar.cc/150?img=24',
    'sales': '59.298 Pengikut',
  },
];
