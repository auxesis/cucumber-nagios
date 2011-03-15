require 'ssh-forever'  unless defined? SecureShellForever
module Cuken
  module Api
    module Ssh

      def ssh_init_password_less
        @ssh_forever_options ||= ssh_forever_default_options
        cmd = ssh_forever(@ssh_forever_options)
        run_simple(unescape(cmd))
      end

      def ssh_init_password_less_batch(table=nil)
        if table == :default
          return @ssh_forever_options = ssh_forever_default_options
        elsif table.nil?
          return @ssh_forever_options ||={}
        end
        table.hashes.each do |hash|
          hsh = parse_ssh_forever_options(hash)
          cmd = ssh_forever(hsh)
          run_simple(unescape(cmd))
        end
      end

      def ssh_forever_options(table=nil)
        if table == :default
          return @ssh_forever_options = ssh_forever_default_options
        elsif table.nil?
          return @ssh_forever_options ||={}
        end
        table.hashes.each do |hash|
          hsh = parse_ssh_forever_options(hash)
          cmd = ssh_forever(hsh)
          run_simple(unescape(cmd))
        end
      end

      def ssh_client_hostname(n=nil)
        name = ENV['HOSTNAME']|| ENV['HOST']||ENV['COMPUTERNAME']||(`hostname`).strip rescue 'localhost'
        if @ssh_forever_options
          @ssh_forever_options[:user] = n.nil? ? name : n
        end
        name
      end

      def ssh_client_username(n=nil)
        name = ENV['USER']|| ENV['USERNAME']|| (`whoami`).strip rescue 'root'
        if @ssh_forever_options
          @ssh_forever_options[:hostname] = n.nil? ? name : n
        end
        name
      end

      private

      def ssh_forever(hsh)
        "ssh-forever #{hsh[:user]}@#{hsh[:hostname]} -p #{hsh[:port]} -i ~/.ssh/id_rsa_cuken -n #{hsh[:name]} -a -q"
      end
      def parse_ssh_forever_options(hsh)
        new_hsh = hsh.inject({}) { |h, (k, v)| h[k.intern] = v; h }
        ssh_forever_default_options.merge(new_hsh).inject({}) do |h, (k, v)|
          v=v.to_s
          if v[/\:default/]
            v = ssh_forever_default_options[k.to_sym]
            h[k]=v
            next h
          end
          if v[/`(.*)`/]
            cmd=v.gsub(/`/,'')
            run_simple(unescape(cmd))
            v = output_from(cmd).strip
          end
          h[k]=v
          h
        end
      end

      def ssh_forever_default_options
        {:user => ssh_client_username, :hostname => ssh_client_hostname,
        :port => 22, :name => 'cuken', :identity_file => '~/.ssh/id_rsa_cuken',
        :auto => true, :intense => true, :quiet => true }
      end
    end
  end
end
