module Admin

  class BaseController < ApplicationController

    before_action :check_admin

    def check_admin

      if not current_user.admin?
        raise ActionController::RoutingError.new('Forbidden')
      end
    end
  end
end
