def require_directories(dirs)
  dirs.each do |dir|
    Dir["#{settings.root}/#{dir}/*.rb"].each {|file| require file }
  end
end

def file_path(root, filename)
  "#{root}/processed_files/#{filename}.csv"
end
