class ApplicationController < ActionController::Base

    protected 

        def authorize_roles roles
            fail "Not Allowed" unless roles.include? current_user.role or current_user.role_root?
        end
end
