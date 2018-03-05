module FactoryBoyfriend
  def create_user_session
    Authorization::User.create({
      name:  'Joe',
      image: 'http://image.jpg'
    })
  end
end
