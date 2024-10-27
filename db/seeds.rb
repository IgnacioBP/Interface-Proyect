# db/seeds.rb

# Limpiamos la base de datos
puts "Limpiando la base de datos..."
UserTweetReaction.destroy_all
Comment.destroy_all
Tweet.destroy_all
User.destroy_all
ReactionLevel.destroy_all

# Creamos los niveles de reacción
puts "Creando niveles de reacción..."
reaction_levels = [
  ReactionLevel.create(name: 'Like', emoji: '👍', level: 1),
  ReactionLevel.create(name: 'Love', emoji: '❤️', level: 2),
  ReactionLevel.create(name: 'Haha', emoji: '😂', level: 3),
  ReactionLevel.create(name: 'Dislike', emoji: '😮', level: 4),
  ReactionLevel.create(name: 'Sad', emoji: '😢', level: 5)
]

# Creamos algunos usuarios
puts "Creando usuarios..."
users = User.create!([
  { first_name: "Juan", last_name: "Pérez", email: "juan@example.com", password: "password" },
  { first_name: "María", last_name: "García", email: "maria@example.com", password: "password" },
  { first_name: "Carlos", last_name: "López", email: "carlos@example.com", password: "password" }
])

# Creamos algunos tweets
puts "Creando tweets..."
tweets = Tweet.create!([
  { body: "¡Hola mundo!", user: users[0] },
  { body: "¡Qué bonito día!", user: users[1] },
  { body: "Me encanta programar en Rails", user: users[2] }
])

# Creamos algunas reacciones de usuario a tweets
puts "Creando reacciones de usuario a tweets..."
UserTweetReaction.create!([
  { user: users[0], tweet: tweets[1], reaction_level: reaction_levels[3] },
  { user: users[1], tweet: tweets[2], reaction_level: reaction_levels[4] },
  { user: users[2], tweet: tweets[0], reaction_level: reaction_levels[2] }
])

puts "Creando reacciones de usuario a tweets..."
Tweet.all.each do |tweet|
  User.all.sample(rand(1..5)).each do |user|
    UserTweetReaction.create(
      user: user,
      tweet: tweet,
      reaction_level: reaction_levels.sample
    )
  end
end

puts "¡Seeds completados exitosamente!"