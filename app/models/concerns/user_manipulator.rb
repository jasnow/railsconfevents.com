module UserManipulator
  extend ActiveSupport::Concern

  def promote_user!(params)
    raise PermissionError.new unless super_admin?
    return unless ["admin", "super_admin"].include? params[:role]
    user = User.find params[:id]
    return if user.super_admin?
    user.role = params[:role]
    user.save!
  end

  module Anonymous
    extend ActiveSupport::Concern

    def promote_user!(params)
      raise PermissionError.new
    end
  end
end
