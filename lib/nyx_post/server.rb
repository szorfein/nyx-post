module NyxPost
  module Server
    class << self
      def start
        start_grpc_server
      end

      private

      def start_grpc_server
        s = GRPC::RpcServer.new
        s.add_http2_port('0.0.0.0:50052', :this_port_is_insecure)
        #s.handle(Service::Demo)
        s.handle(Service::Rails)
        s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
      end
    end
  end
end
