require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "test data", user_id: @user.id)
  end

  test "micropost should be valid" do
    assert @micropost.valid?
  end 

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = " " 
    assert_not @micropost.valid?
  end

  test "content should not be more than 140 characters" do
    @micropost.content = "a" *141
    assert_not @micropost.valid?
  end

  test "micropost should be created" do
    assert @micropost.valid?
  end

  test "recent should be first" do
    assert_equal Micropost.first, microposts(:most_recent)
  end

end
