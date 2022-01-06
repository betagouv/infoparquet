class ApplicationController < ActionController::Base
    default_form_builder CustomFormBuilder


    protected 

        def authorize_roles roles
            fail "Not Allowed" unless roles.include? current_user.role or current_user.role_root?
        end

        def enrolled_user!
            if !current_user.role_root? and current_user.administration_id == nil
                raise ActionController::RoutingError.new 'Forbidden'
            end
        end
end
