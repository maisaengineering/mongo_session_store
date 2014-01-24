require 'mongoid'
require 'mongo_session_store/mongo_store_base'

module ActionDispatch
  module Session
    class MongoidStore < MongoStoreBase

      class Session
        include Mongoid::Document
        include Mongoid::Timestamps

        store_in :collection => MongoSessionStore.collection_name

        field :_id, :type => String

        field :data, :type => String, :default => [Marshal.dump({})].pack("m*")
      end
      
      private
      def pack(data)
          [Marshal.dump(data)].pack("m*")
      end

      def unpack(packed)
      
         return nil unless packed
         Marshal.load(packed.unpack("m*").first)

      end

    end
  end
end 

MongoidStore = ActionDispatch::Session::MongoidStore 
