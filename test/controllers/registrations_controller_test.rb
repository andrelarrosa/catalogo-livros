require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "new" do
    get new_registration_path
    assert_response :success
  end

  test "create with valid data signs the user in" do
    assert_difference("User.count", 1) do
      post registration_path, params: { user: {
        email_address: "nova@example.com",
        password: "segredo123",
        password_confirmation: "segredo123"
      } }
    end

    assert_redirected_to root_path
    assert cookies[:session_id]
    assert_equal "nova@example.com", User.last.email_address
  end

  test "create normalizes the email address" do
    post registration_path, params: { user: {
      email_address: "  MAIUSCULA@Example.COM  ",
      password: "segredo123",
      password_confirmation: "segredo123"
    } }

    assert_equal "maiuscula@example.com", User.last.email_address
  end

  test "create with a duplicate email address fails" do
    assert_no_difference("User.count") do
      post registration_path, params: { user: {
        email_address: users(:one).email_address,
        password: "segredo123",
        password_confirmation: "segredo123"
      } }
    end

    assert_response :unprocessable_content
    assert_select "div", /já está em uso/
  end

  test "create with mismatched confirmation fails" do
    assert_no_difference("User.count") do
      post registration_path, params: { user: {
        email_address: "outra@example.com",
        password: "segredo123",
        password_confirmation: "diferente123"
      } }
    end

    assert_response :unprocessable_content
    assert_nil cookies[:session_id].presence
  end

  test "create with a short password fails" do
    assert_no_difference("User.count") do
      post registration_path, params: { user: {
        email_address: "curta@example.com",
        password: "1234567",
        password_confirmation: "1234567"
      } }
    end

    assert_response :unprocessable_content
  end

  test "an authenticated user is redirected away from the sign up page" do
    sign_in_as users(:one)

    get new_registration_path
    assert_redirected_to root_path
  end
end
