class RegardsSender
  include Service

  def initialize(current_user, target_user_id)
    @sender_user = current_user
    @target_user_id = target_user_id
  end

  def execute
    parse_target_user
    return false unless users_valid?
    send_email
    true
  end

  private

  attr_accessor :sender_user, :target_user, :target_user_id

  def users_valid?
    sender_user && target_user
  end

  def parse_target_user
    self.target_user = User.find_by(id: target_user_id)
  end

  def send_email
    UserMailer.sample_email(sender_user, target_user).deliver
  end
end
