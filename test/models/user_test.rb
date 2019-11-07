require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:t_user)
    @user.password= '123456'
    @user.save
  end

  test "测试" do
    # User.password_digest '123456'
  end


end
