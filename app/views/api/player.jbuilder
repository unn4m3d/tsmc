json.username @username
if @user.nil?
    json.error @error
else
    json.groups @groups
end