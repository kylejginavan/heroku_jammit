=begin
  Copyright (c) 2010 Kyle J. Ginavan & Mauro Torres.  AU!!!

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

begin
  require 'jammit'
rescue LoadError
  raise "jammit gem is missing.  Please install jammit: sudo gem install jammit"
end
require 'yaml'
require File.dirname(__FILE__) + '/lib/heroku_jammit'
require File.dirname(__FILE__) + '/lib/help'

