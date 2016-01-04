class HoleController < ApplicationController
    def index
        redirect_to :action => 'all_holes'
    end
    
    def all_holes
        print "sss"
    end
end
