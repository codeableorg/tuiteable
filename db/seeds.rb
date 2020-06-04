# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
wilber_user = User.create!(username:"Wilber1" ,name: "Wilber", email: "wilber@mail.com", password:"123456")
humberto_user = User.create!(username:"Humberto1" ,name: "Humberto", email: "humberto@mail.com", password:"123456")
sebas_user = User.create!(username:"Sebas1" ,name: "Sebas", email: "sebas@mail.com", password:"123456")
wilber_user.tuits.create!(body:"soy Wilber")
humberto_user.tuits.create!(body:"soy Humberto")
sebas_user.tuits.create!(body:"soy Sebas")
wilber_user.liked_tuits << Tuit.second
humberto_user.liked_tuits << Tuit.third
sebas_user.liked_tuits << Tuit.first
wilber_comment = Comment.create!(body:"Buen tuit, Sebas",tuit_id:3,user_id:wilber_user.id)
humberto_comment = Comment.create!(body:"Buen tuit, Wilber",tuit_id:1,user_id:humberto_user.id)
sebas_comment = Comment.create!(body:"Buen tuit, Humberto",tuit_id:2,user_id:sebas_user.id)
Tuit.first.retuits.create!(body:"Hola Wilber, soy Sebas", owner_id:3)
Tuit.second.retuits.create!(body:"Hola Humberto, soy Wilber", owner_id:1)
Tuit.third.retuits.create!(body:"Hola Sebas, soy Humberto", owner_id:2)
#  Can one self follow itself?
wilber_user.followers << humberto_user
wilber_user.followers << sebas_user
sebas_user.followees << humberto_user
