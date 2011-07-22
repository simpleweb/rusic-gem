require 'sinatra/base'
require 'liquid'
require 'yaml'

module Rusic
  class Server < Sinatra::Base

    set :views, Dir.pwd

    set :public, Dir.pwd + '/public'

    enable :logging

    helpers do
      def bucket
        bucket = YAML.load_file('rusic.yml')['bucket']
        bucket['ideas'].map { |i| Idea.new(i) }
        bucket
      end
    end

    get '/' do
      liquid :"ideas/index.html", :layout => :"layouts/subdomain.html", :locals => { :rusic => bucket }
    end
  end
end
