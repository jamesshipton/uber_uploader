require 'pstore'

module UberUploader
  class DataStore
    class << self
      def pstore
        @pstore ||= PStore.new 'data_store.pstore'
      end

      def get guid
        pstore.transaction(true) do
          pstore[guid]
        end
      end

      def set file
        pstore.transaction do
          pstore[file.guid] = file
        end
      end
    end
  end
end