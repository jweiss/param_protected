module ParamProtected
  module ControllerModifications
    
    def self.extended(action_controller)
      action_controller.class_eval do
        class_inheritable_accessor :_param_protected_options
        self._param_protected_options = {}
        extend  ClassMethods
        include InstanceMethods
        alias_method_chain :params, :protection
      end
    end
    
    module ClassMethods
      
      def _param_actions(params)
        actions = nil
        if params.last.is_a?(Hash)
          actions = {:only => params.last.delete(:only)} if params.last[:only]
          actions = {:except => params.last.delete(:except)} if params.last[:except]
        end
        actions
      end
      
      def param_protected(*params)
        actions = _param_actions(params)
        Protector.instance(self).declare_protection(params, actions, BLACKLIST)
      end
      
      def param_accessible(*params)
        actions = _param_actions(params)
        Protector.instance(self).declare_protection(params, actions, WHITELIST)
      end
      
      def param_accessible_defaults
        _param_protected_options[:accessible_defaults] = true
      end
    end
    
    module InstanceMethods
      
      def params_with_protection
        
        # #params is called internally by ActionController::Base a few times before an action is dispatched,
        # thus we can't filter and cache it right off the bat.  We have to wait for #action_name to be present
        # to know that we're really in an action and @_params actually contains something.  Then we can filter
        # and cache it.
        
        if action_name.blank?
          params_without_protection
        else
          @params_protected ||= Protector.instance(self.class).protect(params_without_protection, action_name)
        end
      end
      
    end
    
  end
end