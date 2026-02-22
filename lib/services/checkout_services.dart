import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utilities/api_paths.dart';

abstract class CheckoutServices {
  Future<void> setCard(String userId, PaymentCardModel paymentCard);
  Future<void> updateSelectedCard(String userId, String paymentCardId);
  Future<List<PaymentCardModel>> fetchPaymentMethods(String userId);
  Future<void> deletePaymentCard(String userId, String paymentCardId);
}

class CheckoutServicesImpl implements CheckoutServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<void> setCard(String userId, PaymentCardModel paymentCard) async =>
      await firestoreServices.setData(
        path: ApiPaths.paymentCard(userId, paymentCard.id),
        data: paymentCard.toMap(),
      );

  @override
  Future<void> updateSelectedCard(String userId, String selectedCardId) async {
    final allCards = await fetchPaymentMethods(userId);
    for (var card in allCards) {
      await firestoreServices.updateData(
        path: ApiPaths.paymentCard(userId, card.id),
        data: {'isChosen': card.id == selectedCardId ? true : false},
      );
    }
  }

  @override
  Future<List<PaymentCardModel>> fetchPaymentMethods(String userId) async =>
      await firestoreServices.getCollection(
        path: ApiPaths.paymentCards(userId),
        builder: (data, documnetId) {
          data['id'] = documnetId;
          return PaymentCardModel.fromMap(data);
        },
      );

  @override
  Future<void> deletePaymentCard(String userId, String paymentCardId) async =>
      await firestoreServices.deleteData(
        path: ApiPaths.paymentCard(userId, paymentCardId),
      );
}
