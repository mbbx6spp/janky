require "xmpp4r"
require "xmpp4r/muc"

module Janky
  module ChatService
    class Jabber
      def initialize(settings)
        @jid = settings["JANKY_CHAT_JABBER_JID"]
        if @jid.nil? || @jid.empty?
          raise Error, "JANKY_CHAT_JABBER_JID setting is required"
        end
        @pwd = settings["JANKY_CHAT_JABBER_PASSWORD"]
        if @pwd.nil? || @pwd.empty?
          raise Error, "JANKY_CHAT_JABBER_PASSWORD setting is required"
        end
        @rooms = settings["JANKY_CHAT_JABBER_ROOMS"]
        if @rooms.nil? || @pwd.empty?
          raise Error, "JANKY_CHAT_JABBER_ROOMS setting is required"
        end

        @client = ::Jabber::Client.new(@jid)
        @client.auth(@pwd)
      end

      def speak(message, room_id, options = {:color => "yellow"})
        muc = Jabber::MUC::SimpleMUCClient.new(@client)
        muc.join(Jabber::JID.new(room_id))
        muc.say(message)
      end

      def rooms
        @rooms
      end
    end
  end
end
