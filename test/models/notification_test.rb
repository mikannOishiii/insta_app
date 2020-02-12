require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
    @notification = Notification.new(visitor_id: users(:michael).id,
                                     visited_id: users(:archer).id,
                                     action: 'follow')
  end

  test "should be valid" do
    assert @notification.valid?
  end

  test "should require a visitor_id" do
    @notification.visitor_id = nil
    assert_not @notification.valid?
  end

  test "should require a visited_id" do
    @notification.visited_id = nil
    assert_not @notification.valid?
  end

  test "should require a action" do
    @notification.action = nil
    assert_not @notification.valid?
  end
end
