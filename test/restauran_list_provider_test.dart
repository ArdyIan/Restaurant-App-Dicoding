import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_api_dicoding/data/api/api_service.dart';
import 'package:restaurant_api_dicoding/data/model/restauran.dart';
import 'package:restaurant_api_dicoding/data/model/restauran_list_response.dart';
import 'package:restaurant_api_dicoding/provider/home/restauran_list_provider.dart';
import 'package:restaurant_api_dicoding/static/restauran_list_result_state.dart';

// ini auto-generate file mock
import 'restauran_list_provider_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late RestauranListProvider provider;
  late MockApiServices mockApiService;

  setUp(() {
    mockApiService = MockApiServices();
    provider = RestauranListProvider(mockApiService);
  });

  test('state awal harus None', () {
    expect(provider.resultState, isA<RestauranListNoneState>());
  });

  test('mengembalikan LoadedState saat API sukses', () async {
    final restaurant = Restauran(
      id: "rqdv5juczeskfw1e867",
      name: "Melting Pot",
      description: "Lorem ipsum",
      address: "Jalan Mawar No. 1",
      pictureId: "14",
      city: "Medan",
      rating: 4.2,
      menus: Menus(foods: [], drinks: []),
    );

    // Stub sukses
    when(mockApiService.getRestauranList()).thenAnswer(
      (_) async => RestauranListResponse(
        error: false,
        message: "success",
        count: 1,
        restaurants: [restaurant],
      ),
    );

    await provider.fetchRestauranList();

    expect(provider.resultState, isA<RestauranListLoadedState>());
    final state = provider.resultState as RestauranListLoadedState;

    expect(state.data.isNotEmpty, true);
    expect(state.data.first.name, "Melting Pot");
  });

  test('mengembalikan ErrorState saat API gagal', () async {
    // Stub gagal
    when(mockApiService.getRestauranList())
        .thenThrow(Exception("Failed to load"));

    await provider.fetchRestauranList();

    expect(provider.resultState, isA<RestauranListErrorState>());
    final state = provider.resultState as RestauranListErrorState;

    expect(state.error, contains("Failed"));
  });
}
