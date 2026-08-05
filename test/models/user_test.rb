require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
    assert_equal("downcased@example.com", user.email_address)
  end

  test "requires a well formed email address" do
    user = User.new(email_address: "sem-arroba", password: "segredo123")

    assert_not user.valid?
    assert_includes user.errors[:email_address], "não é válido"
  end

  test "rejects a duplicate email address" do
    user = User.new(email_address: users(:one).email_address, password: "segredo123")

    assert_not user.valid?
    assert_includes user.errors[:email_address], "já está em uso"
  end

  test "rejects a password shorter than 8 characters" do
    user = User.new(email_address: "curta@example.com", password: "1234567")

    assert_not user.valid?
    assert_not_empty user.errors[:password]
  end

  test "allows updating a user without touching the password" do
    user = users(:one)

    assert user.update(email_address: "renomeada@example.com")
  end
end
