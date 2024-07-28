namespace :dev do
  desc "Configurando o ambiente"
  task setup: :environment do
    puts "Resetando o banco de dados"
    # %(rails db:drop db:create db:migrate)

    #########################################s

    puts "Cadastrando tipos de contatos..."
    kinds = %w(Amigo Comercial Conhecido)
    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    puts "Tipos de contatos Cadastrados com sucesso!"

    ###########################################

    puts "Cadastrando contatos..."
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
      )
    end
    puts "Contatos Cadastrados com sucesso!"

    ###########################################

    puts "Cadastrando telefones..."
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        phone = Phone.create!(number: Faker::PhoneNumber.cell_phone)
        contact.phones << phone
        contact.save!
      end
    end
    puts "Telefones Cadastrados com sucesso!"

    ###########################################

    puts "Cadastrando os endereços..."
    Contact.all.each do |contact|
      Address.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end
    puts "Endereços Cadastrados com sucesso!"

    puts "Criando Usuário Padrão..."
    User.create!(
      email:"eriko@eriko.com",
      password:"12345678",
      password_confirmation:"12345678"
    )
    puts "Usuário Criado Com Sucesso!"
  end
end
