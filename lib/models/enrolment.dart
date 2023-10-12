import 'package:cloud_firestore/cloud_firestore.dart';

class Enrolment {
  /// id is the referral code of the user for the particular enrolment
  String? id;
  String? courseId;
  double? amount;

  /// step number is 1 by default.
  /// which means if the enrolment without code the number 1 is applied
  /// if the enrolment was with a code the step counter follows the algorithm
  ///  1. get data from [enrolments > code > doc ]
  ///  2. copy all docs to [ enrolments > code > referrals > refCode ]
  ///  3. count refCode count
  ///  4. add users enrolment referral data to referral collection
  int? step;
  String? referredCode;
  int? createdAt;
  String? uid;
  double? totalEarned;

  Enrolment({
    this.id,
    this.courseId,
    this.amount,
    this.step,
    this.referredCode,
    this.createdAt,
    this.uid,
    this.totalEarned,
  });

  factory Enrolment.fromMap(Map<String, dynamic> map) {
    return Enrolment(
      id: map['id'] as String?,
      courseId: map['courseId'] as String?,
      amount: (map['amount'] ?? 0.0).toDouble() as double?,
      step: map['step'] as int?,
      referredCode: map['referredCode'] as String?,
      createdAt: map['createdAt'] as int?,
      uid: map['uid'] as String?,
      totalEarned: (map['totalEarned'] ?? 0.0).toDouble() as double?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'amount': amount,
      'step': step,
      'referredCode': referredCode,
      'createdAt': createdAt,
      'uid': uid,
      'totalEarned': totalEarned,
    };
  }

  CollectionReference<Enrolment> dbRef(String? uid) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('enrolments')
          .withConverter(
            fromFirestore: (snap, _) => Enrolment.fromMap(snap.data()!),
            toFirestore: (Enrolment enrolment, _) => enrolment.toMap(),
          );
}
