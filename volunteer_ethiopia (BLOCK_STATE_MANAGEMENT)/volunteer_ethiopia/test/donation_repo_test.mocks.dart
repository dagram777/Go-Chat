

import 'dart:async' as _i4;

import 'package:volunteer_ethiopia_mobile/lib.dart' as _i3;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;



class _FakeClient_0 extends _i1.Fake implements _i2.Client {}

class _FakeDonation_1 extends _i1.Fake implements _i3.Donation {}

/// A class which mocks [DonationDataProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockDonationRepository extends _i1.Mock
    implements _i3.DonationDataProvider {
  MockDonationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Client get client => (super.noSuchMethod(Invocation.getter(#client),
      returnValue: _FakeClient_0()) as _i2.Client);
  @override
  _i4.Future<_i3.Donation?> createDonation(_i3.Donation? donation) =>
      (super.noSuchMethod(Invocation.method(#createDonation, [donation]),
              returnValue: Future<_i3.Donation?>.value())
          as _i4.Future<_i3.Donation?>);
  @override
  _i4.Future<void> deleteDonation(int? id) =>
      (super.noSuchMethod(Invocation.method(#deleteDonation, [id]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<List<_i3.Donation>> getDonationsByUser(int? userId) =>
      (super.noSuchMethod(Invocation.method(#getDonationsByUser, [userId]),
              returnValue: Future<List<_i3.Donation>>.value(<_i3.Donation>[]))
          as _i4.Future<List<_i3.Donation>>);
  @override
  _i4.Future<_i3.Donation> updateDonation(int? id, _i3.Donation? donation) =>
      (super.noSuchMethod(Invocation.method(#updateDonation, [id, donation]),
              returnValue: Future<_i3.Donation>.value(_FakeDonation_1()))
          as _i4.Future<_i3.Donation>);
}
