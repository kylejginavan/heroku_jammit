=begin
  Copyright (c) 2010 Kyle J. Ginavan & Mauro Torres.

  This file is part of Heroku Jammit Plugin.

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
=end

module Heroku::Command
  class Jammit < BaseWithApp

    def add
      is_root?

      display "===== Compiling assets...", false

        run "jammit -f"

      display "===== Commiting assets...", false

        run "git add '#{package_path}' && git commit -m 'assets at #{formatted_date(Time.now)}'"

      display "===== Done..."
    end

    def delete
      is_root?

      if missing_assets?
        display "===== You already have deleted the assets..."
      else
        display "===== Deleting compiled assets...", false

          run "rm -rf #{package_path}"

        display "===== Commiting deleted assets...", false

          run "git rm -rf #{package_path} && git commit -m 'delete assets at #{formatted_date(Time.now)}'"

        display "===== Done..."
      end
    end

    private

      def package_path
        file = open(config_file_path) {|f| YAML.load(f) }
        dir = "public/" + (file["package_path"] || "assets")
      end

      def config_file_path
        File.join(Dir.getwd, 'config', 'assets.yml')
      end

      def missing_assets?
        !File.exists? package_path
      end

      def missing_config_file?
        !File.exists? config_file_path
      end

      def is_root?
        if missing_config_file?
          display "app rails not found!, you need stay on the root of one rails app"
          exit
        end
      end

      def run(cmd)
        shell cmd
        if $?.exitstatus == 0
          display "[OK]"
        else
          display "[FAIL]"
        end
      end

      def formatted_date(date)
        date.strftime("%A %d, %Y")
      end

  end
end

