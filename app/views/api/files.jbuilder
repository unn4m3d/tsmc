json.prettify! if %w(1 yes true).include?(params[:pretty])
json.files @files
json.dir @dir
