# Limpa os dados existentes no banco
User.destroy_all
Address.destroy_all
Task.destroy_all

# Criação do primeiro usuário com 1 tarefa
user1 = User.create!(
  name: "Alice",
  email: "alice@example.com",
  address_attributes: {
    street: "123 Main St",
    city: "New York",
    state: "NY",
  }
)
user1.tasks.create!(
  title: "Setup Project",
  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin eget eros eget sem tempor interdum.",
  completed: false
)

# Criação do segundo usuário com 2 tarefas
user2 = User.create!(
  name: "Bob",
  email: "bob@example.com",
  address_attributes: {
    street: "456 Elm St",
    city: "Los Angeles",
    state: "CA",
  }
)
user2.tasks.create!(
  title: "Write Documentation",
  description: "Suspendisse potenti. Sed ac mi a metus pharetra ullamcorper quis vel sapien. Donec auctor purus id nisi convallis, vel tincidunt justo fringilla.",
  completed: true
)
user2.tasks.create!(
  title: "Review Pull Requests",
  description: "Mauris bibendum metus vel urna pharetra, non vulputate ligula fermentum. Integer convallis ligula a nunc tincidunt facilisis.",
  completed: false
)

# Criação do terceiro usuário com 3 tarefas
user3 = User.create!(
  name: "Charlie",
  email: "charlie@example.com",
  address_attributes: {
    street: "789 Oak St",
    city: "San Francisco",
    state: "CA",
  }
)
user3.tasks.create!(
  title: "Prepare Presentation",
  description: "Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Proin molestie libero ut arcu elementum, non vehicula ligula suscipit.",
  completed: false
)
user3.tasks.create!(
  title: "Schedule Meetings",
  description: "Fusce tempus, mauris quis gravida posuere, magna eros pulvinar ligula, non accumsan justo ligula id libero. Donec sit amet justo nec arcu ultricies ultrices.",
  completed: true
)
user3.tasks.create!(
  title: "Optimize Database",
  description: "Nam euismod nunc vitae nisi tempus, in vestibulum lorem interdum. Integer a massa a dolor consequat consequat non nec enim.",
  completed: false
)

puts "Seeding complete! Created 3 users with associated addresses and tasks."
