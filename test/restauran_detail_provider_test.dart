import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_api_dicoding/data/api/api_service.dart';
import 'package:restaurant_api_dicoding/data/model/restauran_detail_response.dart';
import 'package:restaurant_api_dicoding/provider/detail/restauran_detail_provider.dart';
import 'package:restaurant_api_dicoding/static/restauran_detail_result_state.dart';
import 'package:restaurant_api_dicoding/utils/result_state.dart';


import 'restauran_detail_provider_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late RestauranDetailProvider provider;
  late MockApiServices mockApiService;

  setUp(() {
    mockApiService = MockApiServices();
    provider = RestauranDetailProvider(
       mockApiService,
     
    );
  });

test('state awal harus loading', () {
  expect(provider.resultState, isA<RestauranDetailLoadingState>());
});


  test('mengembalikan detail restoran saat API sukses', () async {
    final detailResponse = RestauranDetailResponse.fromJson({
      "error": false,
      "message": "success",
      "restaurant": {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Lorem ipsum",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2,
        "menus": {
          "foods": [],
          "drinks": [],
        }
      }
    });


    when(mockApiService.getRestauranDetail("rqdv5juczeskfw1e867"))
        .thenAnswer((_) async => detailResponse);

    await provider.fetchRestauranDetail("rqdv5juczeskfw1e867");

expect(provider.resultState, isA<RestauranDetailLoadedState>());
final state = provider.resultState as RestauranDetailLoadedState;
expect(state.data.name, "Melting Pot");

  });

  test('mengembalikan detail restoran saat API sukses', () async {
  final detailResponse = RestauranDetailResponse.fromJson({
    "error": false,
    "message": "success",
    "restaurant": {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description": "Lorem ipsum",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2,
      "menus": {
        "foods": [],
        "drinks": [],
      }
    }
  });


  when(mockApiService.getRestauranDetail("rqdv5juczeskfw1e867"))
      .thenAnswer((_) async => detailResponse);

  await provider.fetchRestauranDetail("rqdv5juczeskfw1e867");

  expect(provider.resultState, isA<RestauranDetailLoadedState>());
  final state = provider.resultState as RestauranDetailLoadedState;
  expect(state.data.name, "Melting Pot");
});

}
