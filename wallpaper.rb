#!/bin/ruby
require 'rubygems'
require 'bundler/setup'
require 'net/http'
require 'xmlsimple'
require 'fileutils'
require 'RMagick'
require 'trollop'
require "facter"
require "open3"

opts = Trollop::options do
  opt :market, "Market as per Microsoft language code - see http://msdn.microsoft.com/en-us/library/ms533052(v=vs.85).aspx", :type => :string
  opt :bgopts, "Background Picture Options. Use one of wallpaper,centered,scales,stretched,zoom or spanned", :type => :string
end			

if opts[:market]
  market = opts[:market]
else
  market = "en-WW"
end

if opts[:bgopts]
  bgopts = opts[:bgopts]
else
  bgopts = "centered"
end

url = "http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=#{market}"
xml_data = Net::HTTP.get_response(URI.parse(url)).body

wallpaperdir = ENV['HOME']+'/.wallpaper'
data = XmlSimple.xml_in(xml_data)

if File.directory?("#{wallpaperdir}")
  FileUtils.rm Dir["#{wallpaperdir}/*"]
 

else
  FileUtils.mkdir_p("#{wallpaperdir}")
end

index = 1

data['image'].each do |image|
    url = "http://www.bing.com" + (image['url'])[0]
    url["1366x768"]="1920x1200"
    image_data = Net::HTTP.get_response(URI.parse(url)).body
    img = Magick::Image::from_blob(image_data).first
    resized_image = img.resize_to_fit(1920,1200)
    color = img.resize(1,1).pixel_color(0,0).to_color(compliance=Magick::AllCompliance,hex=true)
    file = "#{wallpaperdir}" + "/" + "#{index}.png"
    resized_image.write(file)
    case Facter.value(:osfamily)
    when 'Windows'
       # fds
    when 'Linux'
        system("gsettings set org.gnome.desktop.background picture-uri file://#{file}")
        system("gsettings set org.gnome.desktop.background picture-options #{bgopts}")
        system("gsettings set org.gnome.desktop.background primary-color #{color}")
    when 'Darwin'
 
        osascript = "-e \"tell application \\\"System Events\\\" to set picture of every desktop to \\\"#{file}\\\"\""
        system("osascript #{osascript}")
      
   else
        # fsd
    end      
      
end


