json.user do 
  json.extract! @user, :username, :id, :email
end