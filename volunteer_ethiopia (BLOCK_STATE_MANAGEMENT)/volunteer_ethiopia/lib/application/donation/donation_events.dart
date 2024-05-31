
class DonationEvents {}

class Donate extends DonationEvents {
  String account_number;
  int donated_amount;
  int user;
  int post;

  Donate(this.account_number, this.donated_amount, this.user, this.post);

}
